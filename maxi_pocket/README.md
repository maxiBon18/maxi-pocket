# MaxiPocket

![Flutter](https://img.shields.io/badge/Flutter-3.41.6-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-≥3.11.4-0175C2?logo=dart&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey)
![License](https://img.shields.io/badge/License-Proprietary-red)

## Description

Flutter mobile app for managing fixed expenses, such as subscriptions and financing.

---

## Table of Contents

1. [Description](#description)
2. [Screenshots / Demo](#screenshots--demo)
3. [Features](#features)
4. [Tech Stack](#tech-stack)
5. [Architecture](#architecture)
6. [Getting Started](#getting-started)
7. [Configuration / Environment](#configuration--environment)
8. [Project Structure](#project-structure)
9. [State Management](#state-management)
10. [Dependencies](#dependencies)
11. [Scripts & Commands](#scripts--commands)
12. [Testing](#testing)
13. [Contributing](#contributing)
14. [Changelog](#changelog)
15. [License](#license)

---

## Screenshots / Demo

| Android | iOS |
|---------|-----|
| <!-- TODO: Add Android screenshot after first UI milestone --> | <!-- TODO: Add iOS screenshot after first UI milestone --> |

---

## Features

### Expense Management

- [x] Home dashboard
- [ ] View all fixed expenses
- [ ] Manage subscription expenses
- [ ] Manage financing expenses

### App

- [x] Branded splash screen with timed navigation to home
- [x] Portrait-only orientation lock
- [x] Platform-adaptive page transitions (Material on Android, Cupertino on iOS)
- [x] Centralised routing via `lib/routes.dart` and injected `RoutingService`
- [x] Unknown route handling (404 page)
- [x] App lifecycle management
- [x] Launcher icons configured for Android and iOS (`flutter_launcher_icons`)
- [x] Core local preferences layer (`shared_preferences`: async API + optional in-memory cache with allow-listed keys)

---

## Tech Stack

| Category | Technology | Version |
|---|---|---|
| Framework | Flutter | 3.41.6 |
| Language | Dart | ≥ 3.11.4 |
| State Management | Riverpod | 3.2.1 |
| Dependency Injection | GetIt | 9.2.1 |
| Local storage | shared_preferences | 2.5.5 |
| Design System | Material Design 3 + Google Fonts | — |
| Vector assets | flutter_svg | 2.2.4 |
| Linting | flutter_lints | 6.0.0 |
| Version Manager | FVM | latest |

**Supported Platforms:**

- Android (portrait mode)
- iOS (portrait mode)

<!-- TODO: Confirm minimum OS versions (e.g. Android API 24 / iOS 15.0) after platform configuration is finalised -->

---

## Architecture

Clean Architecture with **MVVM** pattern and a **feature-first** folder layout.

Dependency direction is strictly inward: `presentation → domain ← data`. Domain never imports from presentation or data layers.

**Routing:** Route name constants and the `Map<String, WidgetBuilder>` used by `MaterialApp` live in `lib/routes.dart`, so feature pages can be registered without placing feature imports inside `core/`. `RoutingService` receives that map from GetIt at startup (`RoutingService(observer, Routes.routes)`).

**Local preferences:** The data layer wraps the `shared_preferences` plugin behind source interfaces (`SharedPrefAsyncSource`, `SharedPrefWithCacheSource` in `core/data/repo/source/`), repository implementations (`shared_pref_repo_impl.dart`), and domain-facing services (`SharedPrefAsyncService`, `SharedPrefWithCacheService` in `core/domain/services/`). Repository contracts live in `core/domain/services/repo/shared_pref_repo.dart`. Implementations use `SharedPreferencesAsync` for fully async I/O and `SharedPreferencesWithCache` for synchronous reads from an in-memory cache once opened. ViewModels and use cases depend on the services or repository abstractions—not on `shared_preferences` types directly.

**Composition root:** GetIt registers the async stack: `SharedPrefAsyncSource` → `SharedPrefAsyncRepo` → `SharedPrefAsyncService`. `SharedPreferencesWithCache` is created asynchronously with `SharedPreferencesWithCacheOptions(allowList: CacheKeys.allKeys)` from `core/shared/constants/cache_constants.dart`; add keys to `CacheKeys.allKeys` before using the cached API.

```
lib/
├── main.dart                  # Entry point — DI bootstrap, orientation lock, ProviderScope
├── routes.dart                # Route names + builder map (features referenced here, not from core)
├── core/                      # Cross-feature infrastructure and shared UI
│   ├── data/
│   │   ├── repo/
│   │   │   ├── shared_pref_repo_impl.dart
│   │   │   └── source/
│   │   │       ├── dto/       # Core data-source DTOs (when used)
│   │   │       └── shared_pref_source.dart
│   │   └── source/
│   │       └── shared_pref_source_impl.dart
│   ├── domain/
│   │   ├── entities/          # Shared domain entities (e.g. Loading)
│   │   └── services/
│   │       ├── shared_pref_service.dart
│   │       └── repo/          # Shared repository interfaces (e.g. shared_pref_repo.dart)
│   ├── presentation/
│   │   ├── theme/             # ThemeData, colour tokens
│   │   ├── ux/
│   │   │   ├── app.dart       # MaterialApp root
│   │   │   ├── routing_service.dart
│   │   │   ├── pages/         # Shared pages (WrapperPage, NotFoundPage, LifecyclePage)
│   │   │   └── widgets/       # Shared widgets (TextField, image, shimmer, overlay loading…)
│   │   └── viewmodel/         # Shared ViewModels (e.g. LoadingViewModel)
│   └── shared/
│       ├── constants/         # App, design, widget, cache allow-list (`cache_constants.dart`)
│       ├── controllers/       # DI registration, NavigatorObserver
│       ├── exceptions/        # Cross-feature exceptions
│       ├── mixins/            # Shared mixins
│       └── utils/             # Extensions, loggers
├── splashscreen/              # Splash feature (presentation + shared in use)
│   ├── presentation/ux/pages/ # MaxiPocketSplashPage
│   └── shared/                # Splash assets/design constants, time utils
└── home/                      # Home feature module
    ├── data/ …                # Layer folders scaffolded for future use
    ├── domain/ …
    ├── presentation/ux/pages/ # MaxiPocketHomePage
    └── shared/ …
```

### Layer Responsibilities

| Layer | Responsibility |
|---|---|
| `data/` | Repository implementations, data-source implementations, DTOs |
| `domain/` | Entities, repository interfaces, use cases / services |
| `presentation/` | ViewModels (MVVM), pages, widgets |
| `shared/` | Constants, utilities, mixins, and exceptions shared between layers |
| `core/` | Cross-feature infrastructure, shared widgets, and theme |

---

## Getting Started

### Prerequisites

| Tool | Minimum Version | Install |
|---|---|---|
| FVM | latest | `dart pub global activate fvm` |
| Flutter (via FVM) | 3.41.6 | `fvm install` |
| Android SDK | 36.1.0 | Android Studio |
| Xcode | 26.4 | Mac App Store |
| CocoaPods | latest | `sudo gem install cocoapods` |

### Setup

```bash
# 1. Clone the repository
git clone <repository-url>
cd maxi-pocket/maxi_pocket

# 2. Install the pinned Flutter version
fvm install

# 3. Install Dart/Flutter dependencies
fvm flutter pub get

# 4. Install iOS CocoaPods dependencies (macOS only)
cd ios && pod install && cd ..

# 5. Run the app
fvm flutter run
```

---

## Configuration / Environment

<!-- TODO: Document environment configuration (dev / staging / prod) once Firebase and/or .env setup is in place -->

### Firebase

<!-- TODO: Add Firebase setup instructions after `firebase.json`, `google-services.json`, and `GoogleService-Info.plist` are configured -->

### App icons

Launcher icons are generated with [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons). Configuration lives under the `flutter_launcher_icons:` key in `pubspec.yaml` (image paths and adaptive icon colours). After changing assets, regenerate icons (see [Scripts & Commands](#scripts--commands)).

### Shared preferences cache allow-list

`SharedPreferencesWithCache` is configured with `SharedPreferencesWithCacheOptions(allowList: CacheKeys.allKeys)` in `core/shared/constants/cache_constants.dart`. Only keys listed in `CacheKeys.allKeys` participate in the cached API; extend that set when you introduce new persisted keys that must be readable synchronously from the cache.

### Gitignored Files

The following are excluded from version control:

- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `.env` files
- `build/`

---

## Project Structure

<details>
<summary>Full annotated <code>/lib</code> tree</summary>

```
lib/
├── main.dart
├── routes.dart                    # Routes + WidgetBuilder map; initial = splash → home
│
├── core/
│   ├── data/
│   │   ├── repo/
│   │   │   ├── shared_pref_repo_impl.dart
│   │   │   └── source/
│   │   │       ├── dto/
│   │   │       └── shared_pref_source.dart
│   │   └── source/
│   │       └── shared_pref_source_impl.dart
│   ├── domain/
│   │   ├── entities/
│   │   │   └── loading.dart
│   │   └── services/
│   │       ├── shared_pref_service.dart
│   │       └── repo/
│   │           └── shared_pref_repo.dart
│   ├── presentation/
│   │   ├── theme/
│   │   │   └── theme.dart
│   │   ├── viewmodel/
│   │   │   └── loading_viewmodel.dart
│   │   └── ux/
│   │       ├── app.dart
│   │       ├── routing_service.dart
│   │       ├── pages/
│   │       │   ├── lifecycle_page.dart
│   │       │   ├── not_found_page.dart
│   │       │   └── wrapper_page.dart
│   │       └── widgets/
│   │           ├── custom_text_scaling.dart
│   │           ├── date_textfield_widget.dart
│   │           ├── image_widget.dart
│   │           ├── overlay_loading_widget.dart
│   │           ├── shimmer_loading_widget.dart
│   │           └── textfield_widget.dart
│   └── shared/
│       ├── constants/
│       │   ├── app_constants.dart
│       │   ├── cache_constants.dart
│       │   ├── design_constants.dart
│       │   └── widget_constants.dart
│       ├── controllers/
│       │   ├── custom_navigator_observer.dart
│       │   └── di.dart          # SharedPreferences + routing registration
│       ├── exceptions/
│       ├── mixins/
│       └── utils/
│           ├── extensions.dart
│           └── loggers.dart
│
├── splashscreen/
│   ├── data/ …                    # Scaffolded layers (no Dart sources yet)
│   ├── domain/ …
│   ├── presentation/
│   │   └── ux/
│   │       └── pages/
│   │           └── splash_page.dart
│   └── shared/
│       ├── constants/
│       │   ├── assets_constants.dart
│       │   └── design_constants.dart
│       └── utils/
│           └── time_utils.dart
│
└── home/
    ├── data/ …
    ├── domain/ …
    ├── presentation/
    │   └── ux/
    │       ├── pages/
    │       │   └── home_page.dart
    │       └── widgets/
    └── shared/
        ├── constants/
        ├── controllers/
        ├── exceptions/
        ├── mixins/
        └── utils/
```

</details>

---

## State Management

MaxiPocket uses **Riverpod** (`flutter_riverpod` + `riverpod`) for reactive state management.

### Key patterns

| Pattern | Usage |
|---|---|
| `ProviderScope` | Root of the widget tree; scopes all providers |
| `Notifier` / `AsyncNotifier` | ViewModels that encapsulate state and business-logic calls |
| `AsyncValue<T>` | Uniform loading / error / data representation for async operations |
| `ref.watch` | Inside `build()` for reactive UI rebuilds |
| `ref.read` | Inside callbacks and event handlers only |
| `autoDispose` | Applied to providers that must not outlive their consumer |

In debug mode a `ProviderLogger` observer is registered to log all provider state changes.

See `.cursor/rules/review/code-review.mdc` § 5 for the full Riverpod review checklist.

### Local persistence

Cross-cutting key-value storage uses the domain `SharedPrefAsyncService` (backed by `SharedPrefAsyncRepo` and `SharedPreferencesAsync`). Prefer injecting that service from GetIt in ViewModels or use cases rather than calling `shared_preferences` from widgets. Cached reads (`SharedPrefWithCacheRepo` / `SharedPrefWithCacheService`) are available for composition roots that wire `SharedPreferencesWithCache`; ensure `CacheKeys.allKeys` includes every key you read through the cache.

---

## Dependencies

| Package | Purpose | Version |
|---|---|---|
| `flutter_riverpod` | UI-layer Riverpod integration | ^3.3.1 |
| `riverpod` | Core Riverpod state management | ^3.2.1 |
| `get_it` | Service-locator dependency injection | ^9.2.1 |
| `google_fonts` | Google Fonts integration | ^8.0.2 |
| `flutter_svg` | SVG rendering (splash branding, icons) | ^2.2.4 |
| `flutter_launcher_icons` | Launcher icon generation (configured in `pubspec.yaml`) | ^0.14.4 |
| `collection` | Dart collection utilities (`lastWhereOrNull`, etc.) | ^1.19.1 |
| `easy_debounce` | Debounce utility for user-input handlers | ^2.0.3 |
| `intl` | Internationalisation and date/number formatting | ^0.20.2 |
| `logger` | Structured, leveled logging with pretty-print | ^2.7.0 |
| `shared_preferences` | Local key-value persistence (`SharedPreferencesAsync`, optional `SharedPreferencesWithCache`) | ^2.5.5 |

---

## Scripts & Commands

| Task | Command |
|---|---|
| Install dependencies | `fvm flutter pub get` |
| Run (debug) | `fvm flutter run` |
| Run on specific device | `fvm flutter run -d <device-id>` |
| Build Android APK (release) | `fvm flutter build apk --release` |
| Build Android App Bundle | `fvm flutter build appbundle --release` |
| Build iOS (release) | `fvm flutter build ios --release` |
| Regenerate launcher icons | `fvm dart run flutter_launcher_icons` |
| Analyse code | `fvm flutter analyze` |
| Format code | `fvm dart format lib` |
| Run tests | `fvm flutter test` |
| Clean build artefacts | `fvm flutter clean` |
| List available devices | `fvm flutter devices` |

---

## Testing

### Strategy

| Type | Scope | Location |
|---|---|---|
| Unit | Domain services, ViewModels, utilities | `test/<feature>/domain/` |
| Widget | Individual UI components | `test/<feature>/presentation/` |
| Integration | Full user flows end-to-end | `test/integration/` |

### Running Tests

```bash
# Run all tests
fvm flutter test

# Run a specific test file
fvm flutter test test/path/to/test_file.dart

# Run with coverage
fvm flutter test --coverage
```

<!-- TODO: Add test folder and initial unit tests. Mirror the /lib feature-first structure under /test -->

Linting rules are defined via `analysis_options.yaml` (extends `package:flutter_lints/flutter.yaml`).

---

## Contributing

### Branch Naming

```
feature/<short-description>
fix/<short-description>
chore/<short-description>
docs/<short-description>
```

### Commit Messages

This project follows [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(scope): <short summary>

feat(home): add expense summary card
fix(routing): handle null route arguments
chore(deps): upgrade flutter_riverpod to 3.3.1
```

Commit message linting is enforced via `commitlint.config.js`.

### Pull Request Process

1. Branch off `main` (or the relevant base branch).
2. Keep PRs focused — one feature or fix per PR.
3. Ensure `fvm flutter analyze` and `fvm flutter test` pass locally before opening a PR.
4. Request review from at least one team member.
5. Apply all `.cursor/rules/review/code-review.mdc` checks before requesting review.

---

## Changelog

Version history is recorded in [`CHANGELOG.md`](CHANGELOG.md) using [Keep a Changelog](https://keepachangelog.com/) and Semantic Versioning.

---

## License

<!-- TODO: Add LICENSE file to the repository root and update this section with the chosen licence type -->

This project is proprietary. All rights reserved.
