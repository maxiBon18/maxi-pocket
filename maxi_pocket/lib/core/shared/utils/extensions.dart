import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension ThemeModeExtension on String {
  MaxiPocketThemeMode get toMaxiPocketThemeMode {
    switch (this) {
      case 'light':
        return MaxiPocketThemeMode.light;
      case 'dark':
        return MaxiPocketThemeMode.dark;
      default:
        return MaxiPocketThemeMode.light;
    }
  }
}

extension MaterialThemeModeExtension on MaxiPocketThemeMode {
  ThemeMode get toThemeMode {
    switch (this) {
      case MaxiPocketThemeMode.light:
        return ThemeMode.light;
      case MaxiPocketThemeMode.dark:
        return ThemeMode.dark;
    }
  }
}
