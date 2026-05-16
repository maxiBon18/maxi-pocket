import 'package:maxi_pocket/core/shared/utils/enums.dart';
import 'package:timezone/timezone.dart' as tz;

/// Contract for the platform-level notification plugin data source.
abstract class NotificationPluginSource {
  /// Schedules a single notification with the given [id], [title], [body] and [scheduledDate].
  ///
  /// The [type] determines which notification channel the message is posted on.
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
    required MaxiPocketExpensesType type,
  });

  /// Cancels all pending notifications previously scheduled by this app.
  Future<void> cancelAll();

  /// Queries the OS for the current notification permission state without prompting the user.
  Future<MaxiPocketNotificationPermissionState>
  getPermissionNotificationStatus();

  /// Requests notification permission from the OS and returns the resulting state.
  Future<MaxiPocketNotificationPermissionState> requestPermission();

  /// Opens the OS notification settings page for this app; returns `true` on success.
  Future<bool> openSettings();
}
