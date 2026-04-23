import 'package:maxi_pocket/core/shared/constants/widget_constants.dart' show WidgetConstants;

/// Returns an error message if [date] is null or blank, otherwise null.
String? dateValidator(String? date) {
  if (date == null || date.trim().isEmpty) {
    return WidgetConstants.addExpensesDateRequired;
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
