import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/domain/services/shared_pref_service.dart';
import 'package:maxi_pocket/core/shared/constants/cache_constants.dart'
    show CacheKeys;
import 'package:maxi_pocket/core/shared/controllers/di.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart';
import 'package:maxi_pocket/notifications/domain/services/notification_service.dart';

/// Provider for [OnboardingViewModel], used to mark onboarding as completed and request notification permission.
final NotifierProvider<OnboardingViewModel, void> onboardingProvider =
    NotifierProvider<OnboardingViewModel, void>(
      OnboardingViewModel.new,
      retry: (int retryCount, Object error) => null,
    );

/// Handles the side effects when the user completes the onboarding flow.
class OnboardingViewModel extends Notifier<void> {
  final SharedPrefWithCacheService _sharedPrefWithCacheService =
      getDI<SharedPrefWithCacheService>();
  final NotificationService _notificationService = getDI<NotificationService>();
  final Logger _logger = getDI<Logger>();
  @override
  void build() {}

  /// Persists the onboarding-completed flag and enables notifications if the user grants permission.
  Future<void> setOnboardingCompleted() async {
    try {
      await _sharedPrefWithCacheService.setBoolWithCache(
        CacheKeys.onboardingCompleted,
        true,
      );
      final MaxiPocketNotificationPermissionState permissionState =
          await _notificationService.requestPermission();
      if (permissionState == MaxiPocketNotificationPermissionState.granted) {
        await _notificationService.enable();
      }
    } catch (e, stacktrace) {
      _logger.e(
        'Error setting onboarding completed: $e',
        stackTrace: stacktrace,
      );
    }
  }
}
