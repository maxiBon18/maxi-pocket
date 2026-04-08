import 'dart:ui' show Locale;

import 'package:flutter/foundation.dart';

/// App-wide configuration constants (name, locale, description).
@immutable
class AppConstants {
  const AppConstants._();

  static const String appName = 'Maxi Pocket';
  static const String appDescription = 'Tieni traccia di abbonamenti e finanziamenti';
  static const String languageCode = 'it';
  static const String countryCode = 'IT';
  static const Locale appLocale = Locale(languageCode, countryCode);
  static const String versionTitle = 'Versione';
}
