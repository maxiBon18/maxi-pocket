/// User-visible string constants for the settings feature pages.
class SettingsWidgetConstants {
  const SettingsWidgetConstants._();

  /// App bar title displayed on the main settings page.
  static const String appBarTitle = 'Impostazioni';

  /// List-tile title for the notifications entry on the settings page.
  static const String notificationsTitle = 'Notifiche';

  /// List-tile subtitle for the notifications entry on the settings page.
  static const String notificationsSubtitle =
      'Gestisci le notifiche delle tue spese';

  /// List-tile title for the theme entry on the settings page.
  static const String themeTitle = 'Tema';

  /// List-tile subtitle for the theme entry on the settings page.
  static const String themeSubtitle = 'Cambia il tema tra chiaro e scuro';

  /// App bar title on the theme settings sub-page.
  static const String themePageTitle = 'Tema';

  /// Toggle tile title on the theme settings page.
  static const String darkModeTitle = 'Modalità scura';

  /// Toggle tile subtitle on the theme settings page.
  static const String darkModeSubtitle = 'Passa alla modalità scura';

  /// App bar title on the notifications settings sub-page.
  static const String notificationsPageTitle = 'Notifiche';

  /// Toggle tile title for enabling or disabling notifications.
  static const String enableNotificationsTitle = 'Abilita notifiche';

  /// Toggle tile subtitle explaining what notifications are sent.
  static const String enableNotificationsSubtitle =
      'Ricevi un promemoria sulle spese future';

  /// Section heading above the notification type description.
  static const String notificationsTypeSectionTitle = 'Tipo di notifica';

  /// Name of the only currently supported notification type.
  static const String notificationsTypeTitle = 'Pagamenti futuri';

  /// Description of when the payment reminder is delivered.
  static const String notificationsTypeSubtitle =
      'Il promemoria verrà inviato 1 giorno prima del pagamento';

  /// Error dialog title shown when toggling notifications fails.
  static const String enableNotificationsErrorTitle = 'Errore';

  /// Error dialog body shown when toggling notifications fails.
  static const String enableNotificationsErrorSubtitle =
      'Impossibile abilitare/disabilitare le notifiche';
}
