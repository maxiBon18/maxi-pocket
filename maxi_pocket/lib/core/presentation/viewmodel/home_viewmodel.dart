import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/appointments/domain/services/appointment_service.dart';
import 'package:maxi_pocket/core/domain/entities/appointment_entity.dart' show AppointmentEntity;
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';
import 'package:maxi_pocket/core/domain/services/shared_pref_service.dart';
import 'package:maxi_pocket/core/shared/constants/cache_constants.dart' show CacheKeys;
import 'package:maxi_pocket/core/shared/controllers/di.dart';
import 'package:maxi_pocket/core/domain/entities/home_entity.dart';
import 'package:maxi_pocket/core/domain/services/home_services.dart';
import 'package:maxi_pocket/core/shared/utils/helpers_method.dart' show parseLocalizedTime;

/// Riverpod provider for the home screen state.
///
/// Retry is disabled because a failed read must surface as an error state rather
/// than silently loop; `splash_page.dart` listens for this provider's error state
/// to navigate, and repeated retries would re-fire that navigation.
final AsyncNotifierProvider<HomeNotifier, HomeEntity?> homeNotifierProvider =
    AsyncNotifierProvider<HomeNotifier, HomeEntity?>(
      HomeNotifier.new,
      retry: (int retryCount, Object error) => null,
    );

/// Loads and aggregates expense data for the home screen.
///
/// On [build], fetches subscriptions, financings, and appointments, then filters
/// them down to commitments due in the current calendar month (appointments are
/// further restricted to ones that haven't started yet).
class HomeNotifier extends AsyncNotifier<HomeEntity?> {
  final Logger _logger = getDI<Logger>();
  final HomeService _homeServices = getDI<HomeService>();
  final AppointmentService _appointmentService = getDI<AppointmentService>();
  final SharedPrefWithCacheService _sharedPrefWithCacheService = getDI<SharedPrefWithCacheService>();

  HomeEntity? _homeWeeklyEntity;
  bool _onboardingCompleted = false;

  /// Whether the onboarding process has been completed.
  bool get onboardingCompleted => _onboardingCompleted;

  /// Current-month snapshot entity populated after a successful [build].
  HomeEntity? get homeWeeklyEntity => _homeWeeklyEntity;

  @override
  Future<HomeEntity?> build() async {
    try {
      _onboardingCompleted = _sharedPrefWithCacheService.getBoolWithCache(CacheKeys.onboardingCompleted) ?? false;

      final List<SubscriptionEntity> subscriptionEntities = await _homeServices.getSubscriptionsData();
      final List<FinancingEntity> financingEntities = await _homeServices.getFinancingsData();
      final List<AppointmentEntity> appointmentEntities = await _appointmentService.getAppointmentsData();

      _calculateMonthlyEvents(subscriptionEntities, financingEntities, appointmentEntities);

      return _homeWeeklyEntity;
    } catch (e, st) {
      _logger.e('Error retrieving Home data', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// Returns the total count of this month's commitments (subscriptions + financings + appointments).
  int getNumberOfEvents() {
    if (_homeWeeklyEntity == null) return 0;
    return _homeWeeklyEntity!.subscriptionEntity.length +
        _homeWeeklyEntity!.financingEntity.length +
        (_homeWeeklyEntity!.appointmentEntity?.length ?? 0);
  }

  /// Populates [_homeWeeklyEntity] with subscriptions and financings due in the current
  /// calendar month, and appointments in the current month that haven't started yet
  /// (comparing full date and hour when a valid hour is parseable).
  void _calculateMonthlyEvents(
    List<SubscriptionEntity> subscriptionEntities,
    List<FinancingEntity> financingEntities,
    List<AppointmentEntity> appointmentEntities,
  ) {
    final int currentMonth = DateTime.now().month;

    final List<SubscriptionEntity> filteredSubscriptionEntities = subscriptionEntities.where((
      SubscriptionEntity entity,
    ) {
      final DateTime? date = entity.nextPaymentDate;
      if (date == null) return false;
      return date.month == currentMonth;
    }).toList();

    final List<FinancingEntity> filteredFinancingEntities = financingEntities.where((FinancingEntity entity) {
      final DateTime? date = entity.nextPaymentDate;
      if (date == null) return false;
      return date.month == currentMonth;
    }).toList();
    final List<AppointmentEntity> filteredAppointmentEntities = appointmentEntities.where((AppointmentEntity entity) {
      final DateTime date = entity.commitmentEntity.eventDate;
      final TimeOfDay? appointmentHour = parseLocalizedTime(
        entity.hour,
        locale: entity.commitmentEntity.localeTimezone,
      );
      if (appointmentHour == null) {
        return date.month == currentMonth && date.isAfter(DateTime.now());
      }
      final DateTime eventDateWithHour = DateTime(
        date.year,
        date.month,
        date.day,
        appointmentHour.hour,
        appointmentHour.minute,
      );
      return date.month == currentMonth && eventDateWithHour.isAfter(DateTime.now());
    }).toList();

    _homeWeeklyEntity = HomeEntity(
      subscriptionEntity: filteredSubscriptionEntities,
      financingEntity: filteredFinancingEntities,
      appointmentEntity: filteredAppointmentEntities,
    );
  }

}
