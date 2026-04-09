import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;

/// Convenience accessors on [BuildContext].
extension BuildContextExtension on BuildContext {
  /// Shorthand for [Theme.of(context).textTheme].
  TextTheme get textTheme => Theme.of(this).textTheme;
}

/// Parses a persisted theme-mode string into [MaxiPocketThemeMode].
extension ThemeModeExtension on String {
  /// Converts a stored string value to [MaxiPocketThemeMode].
  ///
  /// Falls back to [MaxiPocketThemeMode.light] for any unrecognised value,
  /// so a corrupted or missing preference never leaves the app in a broken state.
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

/// Maps [MaxiPocketThemeMode] to Flutter's [ThemeMode] for use in [MaterialApp].
extension MaterialThemeModeExtension on MaxiPocketThemeMode {
  /// Converts this value to the equivalent [ThemeMode].
  ThemeMode get toThemeMode {
    switch (this) {
      case MaxiPocketThemeMode.light:
        return ThemeMode.light;
      case MaxiPocketThemeMode.dark:
        return ThemeMode.dark;
    }
  }
}

/// Responsive sizing helpers for screen-dimension doubles.
extension DoubleExtension on double {
  double responsiveHeight(double componentHeight) => this * componentHeight / DesignConstants.appHeightByDesign;
  double responsiveWidth(double componentWidth) => this * componentWidth / DesignConstants.appWidthByDesign;
}
