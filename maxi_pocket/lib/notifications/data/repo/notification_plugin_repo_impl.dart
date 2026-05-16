import 'package:flutter/foundation.dart' show immutable;
import 'package:logger/logger.dart';
import 'package:maxi_pocket/appointments/data/repo/source/appointment_db_source.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/appointment_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/financing_dto.dart'
    show FinancingDto;
import 'package:maxi_pocket/core/data/repo/source/dto/subscription_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/home_db_source.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart';
import 'package:maxi_pocket/notifications/data/repo/source/notification_plugin_source.dart';
import 'package:maxi_pocket/notifications/domain/services/repo/notification_plugin_repo.dart';
import 'package:maxi_pocket/notifications/shared/constants/notification_constants.dart';
import 'package:timezone/timezone.dart' as tz;

/// [NotificationPluginRepo] implementation that orchestrates scheduling across all expense types
/// by delegating to [NotificationPluginSource] for the platform plugin calls.
@immutable
class NotificationPluginRepoImpl implements NotificationPluginRepo {
  const NotificationPluginRepoImpl(
    this._source,
    this._appointmentService,
    this._homeService,
  );

  final NotificationPluginSource _source;
  final AppointmentDbSource _appointmentService;
  final HomeDbSource _homeService;

  /// Cancels all existing notifications, then schedules a reminder one day before every
  /// appointment, subscription payment, and financing instalment in the database.
  @override
  Future<void> scheduleAll() async {
    await _source.cancelAll();

    final List<AppointmentDto> appointments = await _appointmentService
        .getAppointmentsData();
    final List<SubscriptionDto> subscriptions = await _homeService
        .getSubscriptionsData();
    final List<FinancingDto> financings = await _homeService
        .getFinancingsData();

    for (final AppointmentDto a in appointments) {
      await _scheduleForDate(
        id: a.expense.id!.toInt(),
        title: NotificationContentConstants.appointmentTitle,
        body: NotificationContentConstants.appointmentBody(a.expense.name),
        date: a.expense.eventDate,
        type: MaxiPocketExpensesType.appointments,
      );
    }

    for (final SubscriptionDto s in subscriptions) {
      if (s.expense.id == null) continue;
      await _scheduleForDate(
        id: s.expense.id!.toInt(),
        title: NotificationContentConstants.subscriptionTitle,
        body: NotificationContentConstants.subscriptionBody(
          s.expense.name,
          s.amount,
        ),
        date: s.nextPaymentDate ?? s.expense.eventDate,
        type: MaxiPocketExpensesType.subscription,
      );
    }

    for (final FinancingDto f in financings) {
      if (f.expense.id == null) continue;
      await _scheduleForDate(
        id: f.expense.id!.toInt(),
        title: NotificationContentConstants.financingTitle,
        body: NotificationContentConstants.financingBody(
          f.expense.name,
          f.amount,
        ),
        date: f.nextPaymentDate ?? f.expense.eventDate,
        type: MaxiPocketExpensesType.financing,
      );
    }
  }

  /// Cancels all previously scheduled notifications for this app.
  @override
  Future<void> cancelAll() => _source.cancelAll();

  Future<void> _scheduleForDate({
    required int id,
    required String title,
    required String body,
    required DateTime date,
    required MaxiPocketExpensesType type,
  }) async {
    final DateTime dayBefore = date.subtract(const Duration(days: 1));
    final tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      dayBefore.year,
      dayBefore.month,
      dayBefore.day,
      NotificationContentConstants.reminderHour,
    );
    // final tz.TZDateTime scheduledDate = tz.TZDateTime.now(tz.local).add(const Duration(minutes: 1));
    if (scheduledDate.isBefore(tz.TZDateTime.now(tz.local))) return;
    await _source.schedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      type: type,
    );
    getDI<Logger>().i(
      'Notification scheduled for $title at $scheduledDate with body $body',
    );
  }

  /// Returns the current OS-level notification permission state without prompting the user.
  @override
  Future<MaxiPocketNotificationPermissionState>
  getPermissionNotificationStatus() =>
      _source.getPermissionNotificationStatus();

  /// Requests notification permission from the OS and returns the resulting state.
  @override
  Future<MaxiPocketNotificationPermissionState> requestPermission() =>
      _source.requestPermission();

  /// Opens the OS notification settings for this app; returns `true` if the settings screen was opened.
  @override
  Future<bool> openSettings() => _source.openSettings();
}
