import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maxi_pocket/core/shared/constants/app_constants.dart' show AppConstants;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode, MaxiPocketExpensesFrequency;
import 'package:maxi_pocket/core/shared/utils/loggers.dart' show customDebugPrint;

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
  /// Scales [componentHeight] relative to the design canvas height.
  double responsiveHeight(double componentHeight) => this * componentHeight / DesignConstants.appHeightByDesign;

  /// Scales [componentWidth] relative to the design canvas width.
  double responsiveWidth(double componentWidth) => this * componentWidth / DesignConstants.appWidthByDesign;
}

/// Payment scheduling helpers for [DateTime].
extension DateTimeExtension on DateTime {
  /// Returns the next billing date based on [frequency].
  ///
  /// For monthly frequency, advances by one calendar month and clamps the day
  /// to the last valid day of that month (e.g. 31 Jan -> 28/29 Feb).
  /// For annual frequency, advances by one year keeping the same month and day.
  DateTime nextPaymentDate(MaxiPocketExpensesFrequency frequency) {
    switch (frequency) {
      case MaxiPocketExpensesFrequency.monthly:
        final int nextY = month == 12 ? year + 1 : year;
        final int nextM = month == 12 ? 1 : month + 1;
        final int lastDayNextMonth = DateTime(nextY, nextM + 1, 0).day;
        final int clampedDay = day > lastDayNextMonth ? lastDayNextMonth : day;
        return DateTime(nextY, nextM, clampedDay);

      case MaxiPocketExpensesFrequency.annual:
        final int nextY = year + 1;

        // For february case
        final int lastDayNextMonth = DateTime(nextY, month, 0).day;
        final int clampedDay = day > lastDayNextMonth ? lastDayNextMonth : day;
        return DateTime(nextY, month, clampedDay);
    }
  }
}

/// Formats a nullable [DateTime] for display.
extension DateFromDateTimeExtensions on DateTime? {
  /// Returns this date formatted as `dd/MM/yyyy`, falling back to today when null or unparseable.
  String formattedDate() {
    const String format = 'dd/MM/yyyy';
    try {
      return DateFormat(format).format(this ?? DateTime.now());
    } catch (e, st) {
      customDebugPrint('[DateFromDateTimeExtensions] formattedDate failed: $e\n$st');
      return DateFormat(format).format(DateTime.now());
    }
  }
}

/// Parses a display-formatted date string back into [DateTime].
extension DateFromStringExtensions on String {
  /// Attempts to parse this string as ISO-8601, then as a locale date.
  ///
  /// Falls back to [DateTime.now] when both attempts fail, so the form never
  /// produces an invalid date even if the stored value is corrupt.
  DateTime parseFromStringDate() {
    try {
      return DateTime.parse(this);
    } catch (_) {
      try {
        return DateFormat.yMd(AppConstants.languageCode).parse(this);
      } catch (e, st) {
        customDebugPrint('[DateFromStringExtensions] parseFromStringDate failed: $e\n$st');
        return DateTime.now();
      }
    }
  }
}
