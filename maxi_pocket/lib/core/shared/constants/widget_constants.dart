import 'package:flutter/foundation.dart';
import 'package:maxi_pocket/routes.dart' show Routes;

/// User-visible string constants for shared widgets, grouped by component.
@immutable
class WidgetConstants {
  const WidgetConstants._();

  /// Date Text Field
  static const String dateTextFieldPickDate = 'Seleziona data';

  /// Bottom Bar
  static const String bottomBarHomeLabel = 'Home';
  static const String bottomBarExpensesLabel = 'Spese';
  static const String bottomBarAppointmentLabel = 'Appuntamenti';
  static const String bottomBarSettingsLabel = 'Impostazioni';

  /// Not Found Page
  static const String notFoundErrorCode = '404';
  static const String notFoundPageTitle = 'Pagina non trovata';
  static const String notFoundPageDescription =
      'La pagina che stai cercando non è disponibile. Potrebbe essere stata rimossa o spostata.';
  static const String notFoundPageButtonText = 'Torna alla home';

  /// Currency Symbol
  static const String currencySymbol = '€';

  /// Floating Action Button
  static const String floatingActionButtonTooltip = 'Aggiungi spesa';

  // Bottom Bar
  static const Map<int, String> tabRoutes = {
    0: Routes.homeRoute,
    1: Routes.expensesRoute,
    2: Routes.appointmentsRoute,
    3: Routes.settingsRoute,
  };

  /// Add Expenses
  static const String addExpensesTitle = 'Aggiungi Spesa';
  static const String addExpensesName = 'Nome';
  static const String addExpensesAmount = 'Importo';
  static const String addExpensesCategory = 'Categoria';
  static const String addExpensesFrequency = 'Tipologia';
  static const String addExpensesDate = 'Prossima Data di Pagamento';
  static const String addExpensesButton = 'Aggiungi';
  static const String addExpensesNameRequired = 'Nome è obbligatorio';
  static const String addExpensesAmountRequired = 'Importo è obbligatorio';
  static const String addExpensesAmountInvalid = 'Importo non valido';
  static const String addExpensesDateRequired = 'Data è obbligatoria';

  /// Add Expenses — Type selector
  static const String addExpensesTypeLabel = 'Tipo';
  static const String addExpensesTypeSubscription = 'Abbonamento';
  static const String addExpensesTypeFinancing = 'Finanziamento';

  /// Add Expenses — Frequency selector
  static const String addExpensesFrequencyLabel = 'Frequenza';
  static const String addExpensesFrequencyWeekly = 'Settimanale';
  static const String addExpensesFrequencyMonthly = 'Mensile';

  static const String activeNumberExpenses = '\${activeNumberExpenses} attive';

  /// Expense tile placeholders — replaced by ViewModel data once wired.
  static const String expenseTitlePlaceholder = 'Netflix';
  static const String expenseTypePlaceholder = 'Subscription';
  static const String nextExpenses = 'Prossimo Pagamento: \${nextPaymentDate}';
  static const double expenseAmountPlaceholder = 100.0;

  /// Appointments
  static const String activeNumberAppointments = 'Appuntamenti futuri';
  static const String nextAppointment = 'Prossimo Appuntamento: \${nextAppointmentDate}';
  static const String appointmentType = 'Appuntamento';
}
