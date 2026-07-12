import 'package:flutter/foundation.dart';

/// User-visible string constants for the home feature widgets.
@immutable
class HomeWidgetConstants {
  const HomeWidgetConstants._();

  /// App bar title on the home page.
  static const String homePageTitle = 'Home';

  /// App bar subtitle on the home page.
  static const String homePageSubtitle = 'Recap Mensile';

  /// Label for the monthly total summary card.
  static const String totalAmountCardTitle = 'Totale';

  /// Subtitle shown below the monthly total card amount.
  static const String totalAmountCardSubtitle = 'Totale delle spese';

  /// Amount displayed on summary cards when data cannot be loaded.
  static const String weeklyCardAmountErrorPlaceholder = '0.00 €';

  /// Label for the monthly summary card.
  static const String monthlyCardTitle = 'Mensile';

  /// Subtitle shown below the monthly card amount.
  static const String monthlyCardSubtitle = 'Totale mese corrente';

  /// Section header for the upcoming-expenses list.
  static const String monthlyRecapTitle = 'In questo mese';

  /// Prefix prepended to the expense count in the section header.
  static const String events = 'Eventi: ';

  /// Section header count shown when data cannot be loaded.
  static const String expensesErrorPlaceholder = '0 spese';

  /// Template for the next-payment label shown on expense tiles.
  static const String nextExpenses = 'Prossimo Pagamento: \${nextPaymentDate}';

  /// Title shown in the full-screen error state on the home page.
  static const String errorPlaceholderTitle = 'Oops!';

  /// Description shown below the error title on the home page.
  static const String errorPlaceholderDescription = 'Qualcosa è andato storto, riprova più tardi.';

  /// Message shown in the empty-state view when there are no expenses to display.
  static const String emptyDataTitle = 'Non ci sono eventi da mostrare';

  /// Message shown in the empty-state view when there are no appointments to display.
  static const String emptyAppointmentsTitle = 'Non ci sono appuntamenti da mostrare';
}
