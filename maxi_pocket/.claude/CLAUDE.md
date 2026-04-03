# MaxiPocket

MaxiPocket — mobile Flutter app to track and manage personal fixed expenses (subscriptions, financing).

- **Platforms:** Android, iOS.
- **Design:** Figma.

## Technology Stack

| Technology  | Version              |
| ----------- | -------------------- |
| Flutter     | See `.fvmrc`         |
| Dart SDK    | Bundled with Flutter |
| Android SDK | Latest stable        |
| Xcode       | Latest stable        |
| FVM         | Latest               |
| Firebase    | See `pubspec.yaml`   |

Use `pubspec.yaml` for information about Flutter packages and run `fvm flutter doctor` for information about Android SDK and Xcode version.
Use `fvm --version` for version information about FVM.

## Agent Behavioral Rules

### Before Writing Code

1. Read the relevant rule files from `.claude/rules/` for the area you are working in.
2. Read existing code in the target feature to understand current patterns, naming, and structure.
3. If the task is ambiguous or involves architectural decisions, ask the developer before proceeding.

### When Writing Code

- Follow all conventions defined in the rules files. Do NOT invent alternative patterns.
- Place new files in the correct directory according to the feature directory structure below.
- Run `fvm dart analyze` after making changes to verify there are no analysis errors.
- Run `fvm dart format lib/` after making changes.
- When generating code, run `fvm dart run build_runner build --delete-conflicting-outputs` after modifying annotated classes.

### Prohibited Actions

- NEVER delete files unless explicitly instructed.
- NEVER refactor or rename existing code unless explicitly asked.
- NEVER change `pubspec.yaml` dependencies without developer approval.
- NEVER commit credentials, API keys, or secrets.
- NEVER use bare `flutter` or `dart` commands without the `fvm` prefix.

### When to Ask the Developer

ALWAYS stop and ask for confirmation before:

- Creating a new feature module or top-level directory.
- Adding, removing, or upgrading a dependency in `pubspec.yaml`.
- Choosing between multiple architectural approaches (e.g., Notifier vs AsyncNotifier, single vs multiple providers).
- Modifying shared code in `core/` that affects multiple features.
- Changing navigation structure or adding new routes.
- Changing DI registration order or scope (feature-level vs global).
- Introducing a new design pattern not already present in the codebase.
- Modifying Drift database schema (migrations have side effects).
- Writing platform-specific code (`Platform` checks, conditional imports).
- Any task where the requirement is ambiguous or has more than one valid interpretation.

<!-- Add new "ask first" rules here as you discover autonomous decisions that should have been confirmed. -->

## Architecture

Clean Architecture with **MVVM** pattern and **feature-first** approach.

`/lib` contains:

- **`core/`** — shared infrastructure, utilities, and UI components used across features.
- **`<feature>/`** — self-contained feature modules.

### Feature Directory Structure

```
<feature>/
├── data/
│   ├── source/
│   │   ├── dto/          # Concrete DTO implementations
│   │   └── *.dart        # Concrete data source implementations
│   └── repo/
│       └── *.dart        # Concrete repository implementations
├── domain/
│   ├── entities/         # Feature entities and entity interfaces
│   ├── services/         # Use cases and domain services
│   └── repo/             # Repository interfaces
│       ├── source/       # Data source interfaces
│       └── dto/          # DTO interfaces
├── presentation/
│   ├── viewmodel/        # Feature ViewModels (Riverpod Notifiers)
│   └── ux/
│       ├── pages/        # Page widgets
│       └── widgets/      # Reusable feature widgets
└── shared/
    ├── mixins/
    ├── exceptions/
    ├── controllers/      # DI and general feature controllers
    ├── constants/
    └── utils/
```

**Additional sub-folders for logical grouping within a layer are permitted and do NOT constitute an architectural violation.**

## Architectural Constraints

1. Apply SOLID principles throughout the codebase.
2. **Dependency direction is strictly inward:** presentation → domain ← data. Domain MUST NOT import presentation or data. Data MUST NOT import presentation.
3. Only elements in `shared/` or `core/` may be imported across layers or features.
4. Repository **interfaces** live in `domain/repo/`. Repository **implementations** live in `data/repo/`.
5. Data source **interfaces** live in `data/repo/source/`. Data source **implementations** live in `data/source/`.
6. ViewModels communicate exclusively with the domain layer (use cases / services).
7. Local storage uses **Drift** and **SharedPreferences**.
8. All cross-layer shared code MUST reside in the feature's `shared/` folder.

## Rules Files

Detailed conventions are defined in `.claude/rules/`.
Read the relevant rule file BEFORE writing or modifying code in the corresponding area.
NEVER load all the rules — only those whose scope matches the current task.

| File                          | Scope                                                                |
| ----------------------------- | -------------------------------------------------------------------- |
| `coding-conventions.md`       | Naming, style, null safety, error handling, async, language features |
| `presentation-layer-rules.md` | Pages, widgets, theming, responsive design, performance              |
| `viewmodel-rules.md`          | ViewModel layer and Riverpod state management                        |
| `data-layer-rules.md`         | Data layer, repository implementations, DTOs, data sources           |
| `domain-layer-rules.md`       | Domain layer, repository interfaces, entities, services              |
| `di-rules.md`                 | Dependency injection with GetIt                                      |
| `routing-rules.md`            | Navigation and route registration                                    |
| `testing-rules.md`            | Unit, widget, and integration testing                                |
| `documentation.md`            | Code documentation and commenting style                              |
| `code-review.md`              | Code review checklist                                                |

## Common Commands

IMPORTANT: Every `dart` and `flutter` CLI command MUST use `fvm`.

```bash
# Run
fvm flutter run

# Build
fvm flutter build apk
fvm flutter build ios

# Analyze
fvm dart analyze

# Format
fvm dart format lib/

# Test
fvm flutter test

# Test (single file)
fvm flutter test test/<path_to_test>.dart

# Dependencies
fvm flutter pub get
fvm flutter pub add <package_name>
fvm flutter pub add dev:<package_name>
fvm dart pub remove <package_name>

# Code generation (Drift, Freezed, etc.)
fvm dart run build_runner build --delete-conflicting-outputs
```

## CLAUDE.md Maintenance Process

### After Every Session

1. Run `git diff` to review all changes Claude Code made.
2. For each change, ask yourself:
   - Did it follow the existing patterns in the codebase?
   - Did it place files in the correct directory?
   - Did it modify anything I didn't ask for?
   - Would I have made a different decision?

3. Classify each unwanted autonomous decision:

   | Classification        | Action                                                        |
   | --------------------- | ------------------------------------------------------------- |
   | **Should have asked** | Add to `### When to Ask the Developer` in CLAUDE.md           |
   | **Should never do**   | Add to `### Prohibited Actions` in CLAUDE.md                  |
   | **Did it wrong**      | Add or clarify the rule in the relevant `.claude/rules/` file |
   | **Did it right**      | No action needed — the current rules are sufficient           |

4. Commit the CLAUDE.md update in the same session so the next session benefits immediately.

### Monthly Review

1. Re-read the full CLAUDE.md. Remove rules that are no longer relevant.
2. Check that the Rules Files table still matches the actual filenames in `.claude/rules/`.
3. Check that the Feature Directory Structure still matches the actual project structure.
4. If the "When to Ask" list has grown beyond 15 items, look for patterns you can consolidate into a single broader rule.
