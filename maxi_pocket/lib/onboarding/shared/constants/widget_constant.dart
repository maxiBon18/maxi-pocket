import 'package:flutter/foundation.dart' show immutable;

/// User-visible string constants displayed on the onboarding page.
@immutable
class OnboardingWidgetConstants {
  const OnboardingWidgetConstants._();

  /// Main headline welcoming the user to the app.
  static const String onboardingTitle = 'Benvenuto in Maxi Pocket';

  /// Subtitle beneath the main headline describing the app's purpose.
  static const String onboardingSubtitle =
      'La tua app per gestire le spese e appuntamenti';

  /// Title inside the notification info container card.
  static const String onboardingNotificationContainerTitle =
      'Non perderti nessun pagamento o appuntamento';

  /// Description inside the notification info container card explaining what notifications do.
  static const String onboardingNotificationContainerSubtitle =
      'Abilita le notifiche per ricevere un promemoria il giorno prima di ogni pagamento o appuntamento';

  /// Label on the primary CTA button that completes onboarding.
  static const String onboardingContinueButtonText = 'Continua';
}

/// Asset paths used on the onboarding page.
@immutable
class OnboardingAssetsConstants {
  const OnboardingAssetsConstants._();

  /// Illustration displayed in the notification info container on the onboarding page.
  static const String notificationIcon =
      'assets/images/onboarding_notification_container.png';
}
