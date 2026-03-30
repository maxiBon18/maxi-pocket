# MaxiPocket

![Flutter](https://img.shields.io/badge/Flutter-3.41.6-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-≥3.11.4-0175C2?logo=dart&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey)
![License](https://img.shields.io/badge/License-Proprietary-red)

Flutter mobile app for tracking and managing personal fixed expenses such as subscriptions and financing commitments.

---

## Table of Contents

1. [Screenshots / Demo](#screenshots--demo)
2. [Features](#features)
3. [Tech Stack](#tech-stack)
4. [Architecture](#architecture)
5. [Getting Started](#getting-started)
6. [Configuration / Environment](#configuration--environment)
7. [Project Structure](#project-structure)
8. [State Management](#state-management)
9. [Dependencies](#dependencies)
10. [Scripts & Commands](#scripts--commands)
11. [Testing](#testing)
12. [Contributing](#contributing)
13. [License](#license)

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

- [x] Portrait-only orientation lock
- [x] Platform-adaptive page transitions (Material on Android, Cupertino on iOS)
- [x] Unknown route handling (404 page)
- [x] App lifecycle management

---

## Tech Stack

| Category | Technology | Version |
|---|---|---|
| Framework | Flutter | 3.41.6 |
| Language | Dart | ≥ 3.11.4 |
| State Management | Riverpod | 3.2.1 |
| Dependency Injection | GetIt | 9.2.1 |
| Design System | Material Design 3 + Google Fonts | — |
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

```
lib/
├── main.dart                  # Entry point — DI bootstrap, orientation lock, ProviderScope
├── core/                      # Cross-feature infrastructure and shared UI
│   ├── data/
│   │   ├── repo/
│   │   │   └── source/dto/    # Core data-source interfaces and DTOs
│   │   └── source/            # Core data-source implementations
│   ├── domain/
│   │   ├── entities/          # Shared domain entities (e.g. Loading)
│   │   └── services/repo/     # Shared repository interfaces
│   ├── presentation/
│   │   ├── theme/             # ThemeData, colour tokens
│   │   ├── ux/
│   │   │   ├── app.dart       # MaterialApp root
│   │   │   ├── routing_service.dart
│   │   │   ├── pages/         # Shared pages (WrapperPage, NotFoundPage, LifecyclePage)
│   │   │   └── widgets/       # Shared widgets (TextField, shimmer, overlay loading…)
│   │   └── viewmodel/         # Shared ViewModels (e.g. LoadingViewModel)
│   └── shared/
│       ├── constants/         # Routes, design tokens, app/widget constants
│       ├── controllers/       # DI registration, NavigatorObserver
│       ├── exceptions/        # Cross-feature exceptions
│       ├── mixins/            # Shared mixins
│       └── utils/             # Extensions, form validator, loggers
└── home/                      # Home feature module
    ├── data/
    │   ├── repo/source/dto/   # Home data-source DTOs
    │   └── source/            # Home data-source implementations
    ├── domain/
    │   ├── entities/          # Home entities
    │   └── services/repo/     # Home repository interfaces
    ├── presentation/
    │   ├── ux/
    │   │   ├── pages/         # home_page.dart
    │   │   └── widgets/       # Home-specific widgets
    │   └── viewmodel/         # Home ViewModels
    └── shared/
        ├── constants/
        ├── controllers/       # Home DI registration
        ├── exceptions/
        ├── mixins/
        └── utils/
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
│
├── core/
│   ├── data/
│   │   ├── repo/
│   │   │   └── source/
│   │   │       └── dto/          # Core data-source interface DTOs
│   │   └── source/               # Core data-source implementations
│   ├── domain/
│   │   ├── entities/
│   │   │   └── loading.dart      # Loading state entity
│   │   └── services/
│   │       └── repo/             # Core repository interfaces
│   ├── presentation/
│   │   ├── theme/
│   │   │   └── theme.dart        # Global ThemeData
│   │   ├── viewmodel/
│   │   │   └── loading_viewmodel.dart
│   │   └── ux/
│   │       ├── app.dart          # MaxiPocketApp root widget
│   │       ├── routing_service.dart
│   │       ├── pages/
│   │       │   ├── lifecycle_page.dart
│   │       │   ├── not_found_page.dart
│   │       │   └── wrapper_page.dart  # MaxiPocketPage base page
│   │       └── widgets/
│   │           ├── custom_text_scaling.dart
│   │           ├── date_textfield_widget.dart
│   │           ├── overlay_loading_widget.dart
│   │           ├── shimmer_loading_widget.dart
│   │           └── textfield_widget.dart
│   └── shared/
│       ├── constants/
│       │   ├── app_constants.dart
│       │   ├── design_constants.dart
│       │   ├── routes.dart       # Route name constants
│       │   └── widget_constants.dart
│       ├── controllers/
│       │   ├── custom_navigator_observer.dart
│       │   └── di.dart           # GetIt dependency registration
│       ├── exceptions/
│       ├── mixins/
│       └── utils/
│           ├── extensions.dart
│           ├── form_validator.dart
│           └── loggers.dart
│
└── home/
    ├── data/
    │   ├── repo/source/dto/
    │   └── source/
    ├── domain/
    │   ├── entities/
    │   └── services/repo/
    ├── presentation/
    │   ├── ux/
    │   │   ├── pages/
    │   │   │   └── home_page.dart   # MaxiPocketHome
    │   │   └── widgets/
    │   └── viewmodel/
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

---

## Dependencies

| Package | Purpose | Version |
|---|---|---|
| `flutter_riverpod` | UI-layer Riverpod integration | ^3.3.1 |
| `riverpod` | Core Riverpod state management | ^3.2.1 |
| `get_it` | Service-locator dependency injection | ^9.2.1 |
| `google_fonts` | Google Fonts integration | ^8.0.2 |
| `collection` | Dart collection utilities (`lastWhereOrNull`, etc.) | ^1.19.1 |
| `easy_debounce` | Debounce utility for user-input handlers | ^2.0.3 |
| `intl` | Internationalisation and date/number formatting | ^0.20.2 |
| `logger` | Structured, leveled logging with pretty-print | ^2.7.0 |

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

## License

<!-- TODO: Add LICENSE file to the repository root and update this section with the chosen licence type -->

This project is proprietary. All rights reserved.
