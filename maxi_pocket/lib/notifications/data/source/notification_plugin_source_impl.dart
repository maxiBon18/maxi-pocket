import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart';
import 'package:maxi_pocket/notifications/data/repo/source/notification_plugin_source.dart';
import 'package:maxi_pocket/notifications/shared/constants/notification_constants.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

/// [NotificationPluginSource] implementation backed by [FlutterLocalNotificationsPlugin]
/// and `permission_handler` for Android and iOS notification delivery and permissions.
@immutable
class NotificationPluginSourceImpl implements NotificationPluginSource {
  const NotificationPluginSourceImpl(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;

  static const NotificationDetails _appointmentDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      NotificationChannelConstants.appointmentChannelId,
      NotificationChannelConstants.appointmentChannelName,
      channelDescription:
          NotificationChannelConstants.appointmentChannelDescription,
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      threadIdentifier: NotificationChannelConstants.appointmentThreadId,
    ),
  );

  static const NotificationDetails _subscriptionDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      NotificationChannelConstants.subscriptionChannelId,
      NotificationChannelConstants.subscriptionChannelName,
      channelDescription:
          NotificationChannelConstants.subscriptionChannelDescription,
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      threadIdentifier: NotificationChannelConstants.subscriptionThreadId,
    ),
  );

  static const NotificationDetails _financingDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      NotificationChannelConstants.financingChannelId,
      NotificationChannelConstants.financingChannelName,
      channelDescription:
          NotificationChannelConstants.financingChannelDescription,
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      threadIdentifier: NotificationChannelConstants.financingThreadId,
    ),
  );

  /// Schedules a timezone-aware notification at [scheduledDate] on the channel matching [type].
  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
    required MaxiPocketExpensesType type,
  }) => _plugin.zonedSchedule(
    id: id,
    title: title,
    body: body,
    scheduledDate: scheduledDate,
    notificationDetails: _detailsForType(type),
    androidScheduleMode: AndroidScheduleMode.inexact,
  );

  /// Cancels all pending notifications via the plugin.
  @override
  Future<void> cancelAll() => _plugin.cancelAll();

  /// Checks the OS notification permission without showing a permission dialog.
  @override
  Future<MaxiPocketNotificationPermissionState>
  getPermissionNotificationStatus() async {
    final PermissionStatus status = await Permission.notification.status;
    return switch (status) {
      PermissionStatus.granted => MaxiPocketNotificationPermissionState.granted,
      PermissionStatus.denied => MaxiPocketNotificationPermissionState.denied,
      PermissionStatus.permanentlyDenied =>
        MaxiPocketNotificationPermissionState.permanentlyDenied,
      _ => MaxiPocketNotificationPermissionState.notDetermined,
    };
  }

  /// Displays the OS notification permission dialog and returns the user's decision.
  @override
  Future<MaxiPocketNotificationPermissionState> requestPermission() async {
    final PermissionStatus status = await Permission.notification.request();
    return switch (status) {
      PermissionStatus.granted => MaxiPocketNotificationPermissionState.granted,
      PermissionStatus.denied => MaxiPocketNotificationPermissionState.denied,
      PermissionStatus.permanentlyDenied =>
        MaxiPocketNotificationPermissionState.permanentlyDenied,
      _ => MaxiPocketNotificationPermissionState.notDetermined,
    };
  }

  /// Opens the OS app settings screen so the user can manually adjust notification permissions.
  @override
  Future<bool> openSettings() async => await openAppSettings();

  NotificationDetails _detailsForType(MaxiPocketExpensesType type) =>
      switch (type) {
        MaxiPocketExpensesType.appointments => _appointmentDetails,
        MaxiPocketExpensesType.financing => _financingDetails,
        _ => _subscriptionDetails,
      };
}
