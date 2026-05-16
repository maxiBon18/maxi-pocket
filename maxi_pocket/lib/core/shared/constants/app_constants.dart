import 'dart:ui' show Locale;

import 'package:flutter/foundation.dart';

/// App-wide configuration constants (name, locale, description).
@immutable
class AppConstants {
  const AppConstants._();

  /// Display name of the application shown in the splash screen and about section.
  static const String appName = 'Maxi Pocket';

  /// Short tagline describing the app's purpose, displayed below the name on the splash screen.
  static const String appDescription =
      'Tieni traccia di abbonamenti e finanziamenti';

  /// BCP 47 language code used for locale-aware formatting (e.g. date formatting via `intl`).
  static const String languageCode = 'it';

  /// BCP 47 country code paired with [languageCode] to form the full locale.
  static const String countryCode = 'IT';

  /// Full locale used for date formatting and potential future localisation.
  static const Locale appLocale = Locale(languageCode, countryCode);

  /// Label prefix used when displaying the app version string in the settings page.
  static const String versionTitle = 'Versione';

  /// File name of the local Drift SQLite database.
  static const String databaseName = 'maxi_pocket_db';
}
