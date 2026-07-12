import 'package:flutter/material.dart' show TimeOfDay, Locale, WidgetsBinding;
import 'package:intl/intl.dart' show DateFormat;
import 'package:maxi_pocket/core/domain/entities/appointment_entity.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart' show WrapperCommitmentsEntity;
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/home_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';
import 'package:maxi_pocket/core/shared/constants/app_constants.dart';
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart' show WidgetConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketExpensesFrequency, MaxiPocketExpensesType;

/// Returns the device locale as `languageCode_countryCode` (or just `languageCode` if no country).
///
/// Uses [PlatformDispatcher] directly — avoids widget context dependency in modals and overlays.
String deviceLocaleString() {
  final Locale locale = WidgetsBinding.instance.platformDispatcher.locale;
  final String? country = locale.countryCode;
  return country != null && country.isNotEmpty ? '${locale.languageCode}_$country' : locale.languageCode;
}

/// Returns an error message if [date] is null or blank, otherwise null.
String? dateValidator(String? date, {bool isHour = false}) {
  if (date == null || date.trim().isEmpty) {
    return isHour ? WidgetConstants.appointmentHourRequired : WidgetConstants.addExpensesDateRequired;
  }
  return null;
}

/// Returns an error message if [amount] is null, blank, non-numeric, or ≤ 0.
String? amountValidator(String? amount) {
  if (amount == null || amount.trim().isEmpty) {
    return WidgetConstants.addExpensesAmountRequired;
  }
  final double? parsed = double.tryParse(amount);
  if (parsed == null) {
    return WidgetConstants.addExpensesAmountRequired;
  }
  if (parsed <= 0) {
    return WidgetConstants.addExpensesAmountInvalid;
  }
  return null;
}

/// Returns an error message if [financingInstallments] is null, blank, non-numeric, or ≤ 0.
String? financingInstallmentsValidator(String? financingInstallments) {
  if (financingInstallments == null || financingInstallments.trim().isEmpty) {
    return WidgetConstants.addExpensesFinancingInstallmentsRequired;
  }
  final int? parsed = int.tryParse(financingInstallments);
  if (parsed == null) {
    return WidgetConstants.addExpensesFinancingInstallmentsRequired;
  }
  if (parsed <= 0) {
    return WidgetConstants.addExpensesFinancingInstallmentsInvalid;
  }
  return null;
}

/// Returns an error message if [financingPaidInstallments] is null, blank, non-numeric, or ≤ 0.
String? financingPaidInstallmentsValidator(String? financingPaidInstallments) {
  if (financingPaidInstallments == null || financingPaidInstallments.trim().isEmpty) {
    return WidgetConstants.addExpensesFinancingPaidInstallmentsRequired;
  }
  final int? parsed = int.tryParse(financingPaidInstallments);
  if (parsed == null) {
    return WidgetConstants.addExpensesFinancingPaidInstallmentsRequired;
  }
  if (parsed < 0) {
    return WidgetConstants.addExpensesFinancingPaidInstallmentsInvalid;
  }
  return null;
}

/// Returns an error message if [name] is null or blank, otherwise null.
String? nameValidator(String? name) {
  if (name == null || name.trim().isEmpty) {
    return WidgetConstants.addExpensesNameRequired;
  }
  return null;
}

/// Returns an error message if [appointmentLocation] is null or blank, otherwise null.
String? appointmentLocationValidator(String? appointmentLocation) {
  if (appointmentLocation == null || appointmentLocation.trim().isEmpty) {
    return WidgetConstants.addExpensesAppointmentLocationRequired;
  }
  return null;
}

/// Builds a flat list of [WrapperCommitmentsEntity] from the appointments snapshot for display in the list widget.
List<WrapperCommitmentsEntity> getAppointmentsWrapperCommitments(List<AppointmentEntity> appointments) {
  final List<WrapperCommitmentsEntity> wrapperCommitments = <WrapperCommitmentsEntity>[];
  if (appointments.isEmpty) return wrapperCommitments;

  wrapperCommitments.addAll(
    appointments.map(
      (AppointmentEntity entity) => WrapperCommitmentsEntity(
        type: MaxiPocketExpensesType.appointments,
        commitments: entity,
        nextPaymentDate: entity.commitmentEntity.eventDate,
        frequency: MaxiPocketExpensesFrequency.monthly,
      ),
    ),
  );

  return wrapperCommitments;
}

/// Builds a flat list of [WrapperCommitmentsEntity] from the home snapshot for display in the list widget.
List<WrapperCommitmentsEntity> getHomeWrapperCommitments(HomeEntity? homeEntity, MaxiPocketExpensesType expensesType) {
  final List<WrapperCommitmentsEntity> wrapperCommitments = <WrapperCommitmentsEntity>[];
  if (homeEntity == null) return wrapperCommitments;

  final bool includeSubscriptions =
      expensesType == MaxiPocketExpensesType.subscription || expensesType == MaxiPocketExpensesType.all;
  final bool includeFinancings =
      expensesType == MaxiPocketExpensesType.financing || expensesType == MaxiPocketExpensesType.all;
  final bool includeAppointments =
      expensesType == MaxiPocketExpensesType.appointments || expensesType == MaxiPocketExpensesType.all;

  if (includeSubscriptions && homeEntity.subscriptionEntity.isNotEmpty) {
    wrapperCommitments.addAll(
      homeEntity.subscriptionEntity.map(
        (SubscriptionEntity entity) => WrapperCommitmentsEntity(
          type: MaxiPocketExpensesType.subscription,
          commitments: entity,
          nextPaymentDate: entity.nextPaymentDate ?? entity.commitmentEntity.eventDate,
          frequency: entity.frequency,
        ),
      ),
    );
  }

  if (includeFinancings && homeEntity.financingEntity.isNotEmpty) {
    wrapperCommitments.addAll(
      homeEntity.financingEntity.map(
        (FinancingEntity entity) => WrapperCommitmentsEntity(
          type: MaxiPocketExpensesType.financing,
          commitments: entity,
          nextPaymentDate: entity.nextPaymentDate ?? entity.commitmentEntity.eventDate,
          frequency: MaxiPocketExpensesFrequency.monthly,
        ),
      ),
    );
  }

  if (includeAppointments && homeEntity.appointmentEntity != null) {
    wrapperCommitments.addAll(getAppointmentsWrapperCommitments(homeEntity.appointmentEntity!));
  }

  wrapperCommitments.sort(
    (WrapperCommitmentsEntity a, WrapperCommitmentsEntity b) => a.nextPaymentDate.compareTo(b.nextPaymentDate),
  );

  return wrapperCommitments;
}

/// Filters [wrapperCommitments] to those matching [frequency].
///
/// Used by the tab-bar widget to split a combined list into monthly and annual
/// sub-lists without duplicating domain logic in the UI layer.
List<WrapperCommitmentsEntity> getSpecificFrequencyWrapperCommitments(
  List<WrapperCommitmentsEntity> wrapperCommitments,
  MaxiPocketExpensesFrequency frequency,
) => wrapperCommitments.where((WrapperCommitmentsEntity entity) => entity.frequency == frequency).toList();

/// Parses [input] as an `HH:mm`-style time string formatted for [locale].
///
/// Falls back to `languageCode_countryCode` from [AppConstants] when [locale]
/// is not given. Returns `null` if [input] doesn't match the expected format.
TimeOfDay? parseLocalizedTime(String input, {String? locale}) {
  try {
    final String localeString = locale ?? '${AppConstants.languageCode}_${AppConstants.countryCode}';
    final DateTime dt = DateFormat.Hm(localeString).parse(input);
    return TimeOfDay(hour: dt.hour, minute: dt.minute);
  } on FormatException {
    return null;
  }
}
