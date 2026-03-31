# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

> Current app version: `0.1.0+1`. No release tags have been created yet.
> Once this version is released, tag it with `git tag v0.1.0` and finalize this entry.

### Added

- Light and dark `ThemeData` definitions for the app, including input decoration styles to keep form fields consistent across themes. ([`ca9302d`](https://github.com/maxiBon18/maxi-pocket/commit/ca9302d))
- Material 3 theme with colour and typography tokens under `core/presentation/theme/`. ([`45be359`](https://github.com/maxiBon18/maxi-pocket/commit/45be359))
- `google_fonts` integration and asset registration (`assets/images/`, `assets/icons/`, `assets/fonts/`). ([`45be359`](https://github.com/maxiBon18/maxi-pocket/commit/45be359))
- Flutter code generation enabled (`flutter.generate: true`) and UIKit scene migration flag configured. ([`45be359`](https://github.com/maxiBon18/maxi-pocket/commit/45be359))
- CocoaPods `Podfile` and `xcconfig` includes for iOS dependency management. ([`45be359`](https://github.com/maxiBon18/maxi-pocket/commit/45be359))
- Initial Flutter project scaffold: entry point, `ProviderScope`, `GetIt` DI, `RoutingService`, portrait-only orientation lock, and platform-adaptive page transitions. ([`7829df2`](https://github.com/maxiBon18/maxi-pocket/commit/7829df2))
- `core/` infrastructure: `LoadingViewModel`, `WrapperPage`, `NotFoundPage`, `LifecyclePage`, shared widgets (`TextFieldWidget`, `ShimmerLoadingWidget`, `OverlayLoadingWidget`, `DateTextFieldWidget`, `CustomTextScaling`). ([`7829df2`](https://github.com/maxiBon18/maxi-pocket/commit/7829df2))
- `home/` feature module skeleton with full Clean Architecture layer structure (`data/`, `domain/`, `presentation/`, `shared/`). ([`7829df2`](https://github.com/maxiBon18/maxi-pocket/commit/7829df2))
- Route constants (`Routes`) and `RoutingService` with named-route arguments retrieval. ([`7829df2`](https://github.com/maxiBon18/maxi-pocket/commit/7829df2))
- `MaxiPocketNavigatorObserver` for route stack tracking. ([`7829df2`](https://github.com/maxiBon18/maxi-pocket/commit/7829df2))
- `ProviderLogger` observer registered in debug mode for Riverpod state tracing. ([`7829df2`](https://github.com/maxiBon18/maxi-pocket/commit/7829df2))
- `extensions.dart` and `loggers.dart` utilities in `core/shared/utils/`. ([`7829df2`](https://github.com/maxiBon18/maxi-pocket/commit/7829df2))
- Core bootstrap and shared UI: GetIt DI, injectable `RoutingService` with platform-adaptive transitions, portrait-only orientation lock via `SystemChrome`, shared pages and inputs (`MaxiPocketPage`, `LifecyclePage`, text fields, shimmer/overlay loading), `LoadingViewModel` with throttled overlay, and home shell (`MaxiPocketHome`). ([`e4a1306`](https://github.com/maxiBon18/maxi-pocket/commit/e4a1306))
- Project documentation: `CHANGELOG.md`, expanded `README.md`, and Cursor skills for README/changelog generation. ([`e4a1306`](https://github.com/maxiBon18/maxi-pocket/commit/e4a1306))
- Branding: `flutter_launcher_icons` (Android adaptive icons and iOS), splash/launch image assets, Android launch themes, application label **Maxi Pocket**, and `pubspec` asset registration; dependency setup ordered so `Logger` is registered before the portrait orientation lock runs. ([`c0749b4`](https://github.com/maxiBon18/maxi-pocket/commit/c0749b4))
- VS Code workspace settings for XML and Dart editors. ([`c0749b4`](https://github.com/maxiBon18/maxi-pocket/commit/c0749b4))

### Changed

- Modularised Cursor rules: extracted coding conventions, Dart best practices, UI guidelines, ViewModel rules, DI rules, data-layer rules, routing rules, and testing rules into dedicated `.mdc` files. ([`044e34c`](https://github.com/maxiBon18/maxi-pocket/commit/044e34c))
- Renamed `application` layer to `presentation` across all Cursor rules and scaffold scripts to align with the MVVM architecture naming. ([`044e34c`](https://github.com/maxiBon18/maxi-pocket/commit/044e34c))
- Updated `.gitignore` and clean-architecture scaffold script to reflect the new `presentation` layer naming and folder structure. ([`044e34c`](https://github.com/maxiBon18/maxi-pocket/commit/044e34c))

---

[Unreleased]: https://github.com/maxiBon18/maxi-pocket/commits/main
