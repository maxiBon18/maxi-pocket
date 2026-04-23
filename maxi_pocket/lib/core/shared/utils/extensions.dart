import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/appointment_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/expense_db_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/financing_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/subscription_dto.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode, MaxiPocketExpensesFrequency;
import 'package:maxi_pocket/core/domain/entities/appointment_entity.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart';
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';

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
  /// to the last valid day of that month (e.g. 31 Jan → 28/29 Feb).
  /// For annual frequency, advances by one year keeping the same month and day.
  DateTime nextPaymentDate(MaxiPocketExpensesFrequency frequency) {
    final int nextY = month == 12 ? year + 1 : year;
    final int nextM = month == 12 ? 1 : month + 1;
    final int lastDayNextMonth = DateTime(nextY, nextM + 1, 0).day;
    final int clampedDay = day > lastDayNextMonth ? lastDayNextMonth : day;

    switch (frequency) {
      case MaxiPocketExpensesFrequency.monthly:
        return DateTime(nextY, nextM, clampedDay);

      case MaxiPocketExpensesFrequency.annual:
        return DateTime(nextY, month, day);
    }
  }
}

/// Converts [ExpenseCommitmentEntity] to its Drift-compatible DTO.
extension ExpenseCommitmentEntityExtension on ExpenseCommitmentEntity {
  /// Maps this entity to an [ExpenseDbDto] for database persistence.
  ExpenseDbDto toDto() => ExpenseDbDto(name: name, eventDate: eventDate, eventType: eventType);
}

/// Converts [AppointmentEntity] to its Drift-compatible DTO.
extension AppointmentEntityExtension on AppointmentEntity {
  /// Maps this entity to an [AppointmentDto] for database persistence.
  AppointmentDto toDto() => AppointmentDto(expense: commitmentEntity.toDto(), location: location);
}

/// Converts [SubscriptionEntity] to its Drift-compatible DTO.
extension SubscriptionEntityExtension on SubscriptionEntity {
  /// Maps this entity to a [SubscriptionDto] for database persistence.
  SubscriptionDto toDto() => SubscriptionDto(expense: commitmentEntity.toDto(), amount: amount, frequency: frequency);
}

/// Converts [FinancingEntity] to its Drift-compatible DTO.
extension FinancingEntityExtension on FinancingEntity {
  /// Maps this entity to a [FinancingDto] for database persistence.
  FinancingDto toDto() => FinancingDto(
    expense: commitmentEntity.toDto(),
    amount: amount,
    numberOfInstallments: numberOfInstallments,
    numberOfPaidInstallments: numberOfPaidInstallments,
  );
}
