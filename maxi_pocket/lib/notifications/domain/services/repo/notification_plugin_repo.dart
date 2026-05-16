import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketNotificationPermissionState;

/// Domain repository interface for notification scheduling and permission management.
abstract class NotificationPluginRepo {
  /// Cancels all existing notifications, then schedules reminders for every tracked expense.
  Future<void> scheduleAll();

  /// Cancels all pending notifications for this app.
  Future<void> cancelAll();

  /// Returns the current OS notification permission state without prompting the user.
  Future<MaxiPocketNotificationPermissionState>
  getPermissionNotificationStatus();

  /// Requests notification permission from the OS and returns the resulting state.
  Future<MaxiPocketNotificationPermissionState> requestPermission();

  /// Opens the OS notification settings page; returns `true` on success.
  Future<bool> openSettings();
}
