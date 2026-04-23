---
paths:
  - "**/*.dart"
  - "pubspec.yaml"
  - "pubspec.lock"
  - "*.sh"
---

# CLI Commands

Every `dart` and `flutter` command MUST use the `fvm` prefix.

## Run & Build

- `fvm flutter run`
- `fvm flutter build apk`
- `fvm flutter build ios`

## Analysis & Formatting

- `fvm dart analyze`
- `fvm dart format lib/`

## Testing

- `fvm flutter test`
- `fvm flutter test test/<path_to_test>.dart`

## Dependencies

- `fvm flutter pub get`
- `fvm flutter pub add <package_name>`
- `fvm flutter pub add dev:<package_name>`
- `fvm dart pub remove <package_name>`

## Code Generation

- `fvm dart run build_runner build --delete-conflicting-outputs`