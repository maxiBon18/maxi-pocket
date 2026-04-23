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

  // Button Strings
  static const String buttonOk = 'OK';
  static const String buttonCancel = 'Annulla';
  static const String buttonDelete = 'Elimina';
  static const String buttonEdit = 'Modifica';
  static const String buttonSave = 'Salva';
  static const String buttonAdd = 'Aggiungi';
  static const String buttonRemove = 'Rimuovi';
  static const String buttonClose = 'Chiudi';

  // Bottom Bar
  static const Map<int, String> tabRoutes = <int, String>{
    0: Routes.homeRoute,
    1: Routes.expensesRoute,
    2: Routes.appointmentsRoute,
    3: Routes.settingsRoute,
  };

  /// Add Expenses & add appointment
  static const String addNewTitle = 'Aggiungi nuovo';
  static const String addExpensesName = 'Nome';
  static const String addExpensesAmount = 'Importo';
  static const String addExpensesFinancingInstallments = 'Numero di rate';
  static const String addExpensesFinancingPaidInstallments = 'Numero di rate pagate';
  static const String addExpensesAppointmentLocation = 'Luogo';
  static const String addExpensesCategory = 'Categoria';
  static const String addExpensesFrequency = 'Tipologia';
  static const String addExpensesDate = 'Data inizio pagamento';
  static const String appointmentDate = 'Data';
  static const String addExpensesButton = 'Aggiungi';
  static const String addExpensesNameRequired = 'Nome è obbligatorio';
  static const String addExpensesAmountRequired = 'Importo è obbligatorio';
  static const String addExpensesAmountInvalid = 'Importo non valido';
  static const String addExpensesDateRequired = 'Data è obbligatoria';
  static const String addExpensesFinancingInstallmentsRequired = 'Numero di rate è obbligatorio';
  static const String addExpensesFinancingInstallmentsInvalid = 'Numero di rate non valido';
  static const String addExpensesFinancingPaidInstallmentsRequired = 'Numero di rate pagate è obbligatorio';
  static const String addExpensesFinancingPaidInstallmentsInvalid = 'Numero di rate pagate non valido';
  static const String addExpensesAppointmentLocationRequired = 'Il luogo dell\'appuntamento è obbligatorio';
  static const String addExpensesErrorTitle = 'Ops!';
  static const String addExpensesErrorSubTitle = 'Qualcosa è andato storto. Riprova più tardi.';

  /// Add Expenses — Type selector
  static const String addExpensesTypeLabel = 'Tipo';
  static const String addExpensesTypeSubscription = 'Abbonamento';
  static const String addExpensesTypeFinancing = 'Finanziamento';
  static const String addExpensesTypeAppointments = 'Appuntamento';

  /// Add Expenses — Frequency selector
  static const String addExpensesFrequencyLabel = 'Frequenza';
  static const String addExpensesFrequencyWeekly = 'Annuale';
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
