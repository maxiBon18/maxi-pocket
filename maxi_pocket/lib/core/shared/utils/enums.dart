/// Shared enumerations for core utilities and UI.
library;

/// App-wide theme brightness choices used with `MaterialApp` theme mode and persistence.
///
/// Values map to Flutter `ThemeMode` via extensions in `extensions.dart` (for example
/// `toThemeMode`). Persist the enum [name] as a string when storing user preference.
enum MaxiPocketThemeMode { light, dark }

enum MaxiPocketExpensesType { subscription, financing }
