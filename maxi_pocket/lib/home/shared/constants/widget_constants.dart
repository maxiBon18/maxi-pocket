import 'package:flutter/foundation.dart';

@immutable
class HomeWidgetConstants {
  const HomeWidgetConstants._();

  static const String homePageTitle = 'Home';
  static const String homePageSubtitle = 'Recap settimanale';
  static const String weeklyCardTitle = 'Settimanale';
  static const String weeklyCardSubtitle = 'Prossimi 7 giorni';
  // TODO: replace with ViewModel-provided amount.
  static const String weeklyCardAmountPlaceholder = '\$208.96';
  static const String monthlyCardTitle = 'Mensile';
  static const String monthlyCardSubtitle = 'Totale mensile';
  // TODO: replace with ViewModel-provided amount.
  static const String monthlyCardAmountPlaceholder = '\$0.00';
  static const String weeklyRecapTitle = 'In questa settimana';
  static const String expenses = '\${expensesNumber} spese';
  static const String nextExpenses = 'Prossimo Pagamento: \${nextPaymentDate}';
  // TODO: replace with ViewModel-provided data.
  static const String expenseTitlePlaceholder = 'Netflix';
  static const String expenseAmountPlaceholder = '\$100';
  static const String expenseTypePlaceholder = 'Subscription';
}
