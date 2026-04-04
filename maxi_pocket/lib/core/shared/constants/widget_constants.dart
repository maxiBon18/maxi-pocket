import 'package:flutter/foundation.dart';

/// User-visible string constants for shared widgets, grouped by component.
@immutable
class WidgetConstants {
  const WidgetConstants._();

  /// Date Text Field
  static const String dateTextFieldPickDate = 'Seleziona data';

  /// Bottom Bar
  static const String bottomBarHomeLabel = 'Home';
  static const String bottomBarExpensesLabel = 'Spese';
  static const String bottomBarSettingsLabel = 'Impostazioni';

  /// Not Found Page
  static const String notFoundErrorCode = '404';
  static const String notFoundPageTitle = 'Pagina non trovata';
  static const String notFoundPageDescription =
      'La pagina che stai cercando non è disponibile. Potrebbe essere stata rimossa o spostata.';
  static const String notFoundPageButtonText = 'Torna alla home';
}
