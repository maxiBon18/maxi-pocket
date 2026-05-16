import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/domain/services/repo/shared_pref_repo.dart';
import 'package:maxi_pocket/core/shared/constants/cache_constants.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketNotificationPermissionState;
import 'package:maxi_pocket/notifications/domain/services/repo/notification_plugin_repo.dart';

/// Domain service that mediates between the notification plugin and persisted user preferences.
///
/// Reads the `notificationsEnabled` flag from cache before scheduling to avoid
/// unwanted reminders when the user has opted out.
class NotificationService {
  const NotificationService(
    this._notificationRepo,
    this._sharedPrefRepo,
    this._logger,
  );

  final NotificationPluginRepo _notificationRepo;
  final SharedPrefWithCacheRepo _sharedPrefRepo;
  final Logger _logger;

  bool get _isEnabled =>
      _sharedPrefRepo.getBoolWithCache(CacheKeys.notificationsEnabled) ?? false;

  /// Persists the enabled preference and schedules all expense reminders.
  Future<void> enable() async {
    try {
      await _sharedPrefRepo.setBoolWithCache(
        CacheKeys.notificationsEnabled,
        true,
      );
      await _notificationRepo.scheduleAll();
    } catch (e, st) {
      _logger.e('Failed to enable notifications', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// Persists the disabled preference and cancels all pending reminders.
  Future<void> disable() async {
    try {
      await _sharedPrefRepo.setBoolWithCache(
        CacheKeys.notificationsEnabled,
        false,
      );
      await _notificationRepo.cancelAll();
    } catch (e, st) {
      _logger.e('Failed to disable notifications', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// Schedules all expense reminders only when the user has previously enabled notifications.
  Future<void> scheduleAllIfEnabled() async {
    if (!_isEnabled) return;
    try {
      await _notificationRepo.scheduleAll();
    } catch (e, st) {
      _logger.e('Failed to schedule notifications', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// Returns the current OS notification permission state without prompting the user.
  Future<MaxiPocketNotificationPermissionState>
  getPermissionNotificationStatus() async =>
      await _notificationRepo.getPermissionNotificationStatus();

  /// Requests notification permission from the OS and returns the resulting state.
  Future<MaxiPocketNotificationPermissionState> requestPermission() async =>
      await _notificationRepo.requestPermission();

  /// Opens the OS notification settings for this app; returns `true` if the page was shown.
  Future<bool> openSettings() async => await _notificationRepo.openSettings();
}
