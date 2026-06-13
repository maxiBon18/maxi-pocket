import 'package:flutter/foundation.dart' show immutable;

/// User-visible string constants displayed on the onboarding page.
@immutable
class OnboardingWidgetConstants {
  const OnboardingWidgetConstants._();

  /// Main headline welcoming the user to the app.
  static const String onboardingTitle = 'Mantieni in controllo';

  /// Subtitle beneath the main headline describing the app's purpose.
  static const String onboardingSubtitle =
      'Attiva le notifiche per ricevere promemoria tempestivi per le tue spese e i tuoi appuntamenti.';

  /// Title inside the notification info container card.
  static const String onboardingNotificationContainerTitle =
      'Non perderti nessun pagamento';

  /// Description inside the notification info container card explaining what notifications do.
  static const String onboardingNotificationContainerSubtitle =
      'Ricevi notifiche prima della scadenza dei tuoi pagamenti.';

  /// Title inside the notification info container card.
  static const String onboardingNotificationAppointmentsContainerTitle =
      'Non mancare nessuna data';

  /// Description inside the notification info container card explaining what notifications do.
  static const String onboardingNotificationAppointmentsContainerSubtitle =
      'Promemoria puntuali per tutti i tuoi appuntamenti.';

  /// Label on the primary CTA button that completes onboarding.
  static const String onboardingContinueButtonText = 'Continua';
}

/// Asset paths used on the onboarding page.
@immutable
class OnboardingAssetsConstants {
  const OnboardingAssetsConstants._();

  /// Illustration displayed in the subscription/payments notification info container on the onboarding page.
  static const String notificationIcon =
      'assets/images/onboarding_notification_container.png';

  /// Illustration displayed in the appointments notification info container on the onboarding page.
  static const String notificationAppointmentsIcon =
      'assets/images/scheduled_notification_image.png';
}
