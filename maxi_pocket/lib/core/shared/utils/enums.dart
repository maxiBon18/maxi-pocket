/// Shared enumerations for core utilities and UI.
library;

/// App-wide theme brightness choices used with `MaterialApp` theme mode and persistence.
///
/// Values map to Flutter `ThemeMode` via extensions in `extensions.dart` (for example
/// `toThemeMode`). Persist the enum [name] as a string when storing user preference.
enum MaxiPocketThemeMode { light, dark }

/// Expense category used to filter and route commitment records.
enum MaxiPocketExpensesType {
  /// A recurring service charge billed at a fixed interval.
  subscription,

  /// A purchase paid in regular instalments.
  financing,

  /// A scheduled event or service booking with a location.
  appointments,

  /// Sentinel value that matches every expense category.
  all,
}

/// Billing cycle for subscriptions and financing payments.
enum MaxiPocketExpensesFrequency {
  /// Charged once per year.
  annual,

  /// Charged once per month.
  monthly,
}

/// Visual style applied to an in-app alert dialog.
enum MaxiPocketDialogType {
  /// Dialog signals a failed or invalid operation.
  error,

  /// Dialog confirms a successful operation.
  success,

  /// Dialog presents neutral informational content.
  info,
}
