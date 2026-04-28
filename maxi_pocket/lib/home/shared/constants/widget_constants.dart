import 'package:flutter/foundation.dart';

/// User-visible string constants for the home feature widgets.
@immutable
class HomeWidgetConstants {
  const HomeWidgetConstants._();

  /// App bar title on the home page.
  static const String homePageTitle = 'Home';

  /// App bar subtitle on the home page.
  static const String homePageSubtitle = 'Recap settimanale';

  /// Label for the weekly summary card.
  static const String weeklyCardTitle = 'Settimanale';

  /// Subtitle shown below the weekly card amount.
  static const String weeklyCardSubtitle = 'Prossimi 7 giorni';

  /// Amount displayed on summary cards when data cannot be loaded.
  static const String weeklyCardAmountErrorPlaceholder = '0.00 €';

  /// Label for the monthly summary card.
  static const String monthlyCardTitle = 'Mensile';

  /// Subtitle shown below the monthly card amount.
  static const String monthlyCardSubtitle = 'Totale mese corrente';

  /// Section header for the upcoming-expenses list.
  static const String weeklyRecapTitle = 'In questa settimana';

  /// Prefix prepended to the expense count in the section header.
  static const String expenses = 'Spese: ';

  /// Section header count shown when data cannot be loaded.
  static const String expensesErrorPlaceholder = '0 spese';

  /// Template for the next-payment label shown on expense tiles.
  static const String nextExpenses = 'Prossimo Pagamento: \${nextPaymentDate}';

  // TODO: replace with ViewModel-provided data.
  static const String expenseTitlePlaceholder = 'Netflix';
  static const String expenseAmountPlaceholder = '\$100';
  static const String expenseTypePlaceholder = 'Subscription';

  /// Title shown in the full-screen error state on the home page.
  static const String errorPlaceholderTitle = 'Oops!';

  /// Description shown below the error title on the home page.
  static const String errorPlaceholderDescription = 'Qualcosa è andato storto, riprova più tardi.';

  /// Message shown in the empty-state view when there are no expenses to display.
  static const String emptyDataTitle = 'Non ci sono spese da mostrare';
}
