import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/domain/services/shared_pref_service.dart';
import 'package:maxi_pocket/core/shared/constants/cache_constants.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketNotificationPermissionState;
import 'package:maxi_pocket/notifications/domain/services/notification_service.dart';

/// Provider for [NotificationViewModel]; auto-disposed when the notifications settings page is removed.
final NotifierProvider<NotificationViewModel, bool> notificationProvider =
    NotifierProvider<NotificationViewModel, bool>(
      NotificationViewModel.new,
      retry: (int retryCount, Object error) => null,
      isAutoDispose: true,
    );

/// Manages the notifications toggle state and permission flow for the settings page.
///
/// State is `true` when notifications are enabled and persisted; `false` otherwise.
class NotificationViewModel extends Notifier<bool> {
  final SharedPrefWithCacheService _sharedPrefService =
      getDI<SharedPrefWithCacheService>();
  final NotificationService _notificationService = getDI<NotificationService>();
  final Logger _logger = getDI<Logger>();

  bool _isDenied = false;
  bool _isFromSettings = false;

  /// Whether the last permission check revealed that the user has denied (or permanently denied) notifications.
  bool get isDenied => _isDenied;

  /// Whether the UI should redirect the user to OS settings because the permission is permanently denied.
  bool get isFromSettings => _isFromSettings;

  @override
  bool build() =>
      _sharedPrefService.getBoolWithCache(CacheKeys.notificationsEnabled) ??
      false;

  /// Enables or disables notifications, handling the permission request flow.
  ///
  /// Returns `true` when the operation succeeded; `false` when the permission was denied
  /// or an error occurred.
  Future<bool> setEnabled(bool value) async {
    bool success = false;
    _isDenied = false;
    _isFromSettings = false;
    try {
      if (value) {
        final MaxiPocketNotificationPermissionState oldPermissionStatus =
            await _notificationService.getPermissionNotificationStatus();

        await _checkDeniedPermission(oldPermissionStatus);

        if (_isDenied) {
          _isFromSettings = true;
          return false;
        }

        final MaxiPocketNotificationPermissionState permissionState =
            await _notificationService.requestPermission();
        if (permissionState == MaxiPocketNotificationPermissionState.granted) {
          _isDenied = false;
          await _notificationService.enable();
        }
      } else {
        await getDI<NotificationService>().disable();
      }
      state = value;
      success = true;
    } catch (e, st) {
      _logger.e('Failed to toggle notifications', error: e, stackTrace: st);
      state = !value;
      success = false;
    }
    return success;
  }

  /// Opens the OS notification settings; returns `true` if the settings screen was shown.
  Future<bool> openSettings() async =>
      await _notificationService.openSettings();

  Future<void> _checkDeniedPermission(
    MaxiPocketNotificationPermissionState oldPermissionStatus,
  ) async {
    if (oldPermissionStatus ==
            MaxiPocketNotificationPermissionState.permanentlyDenied ||
        oldPermissionStatus == MaxiPocketNotificationPermissionState.denied) {
      _isDenied = true;
    }
  }
}
