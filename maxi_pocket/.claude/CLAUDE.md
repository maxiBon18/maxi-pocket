# MaxiPocket

MaxiPocket — mobile Flutter app to track and manage personal fixed expenses (subscriptions, financing).

- **Platforms:** Android, iOS.
- **Design:** Figma.

## Technology Stack

Use `pubspec.yaml` for information about Flutter packages and run `fvm flutter doctor` for information about Flutter, Dart, Android SDK and Xcode version.
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
- Choosing between multiple architectural approaches (e.g., Notifier vs AsyncNotifier, single vs multiple providers).
- Modifying shared code in `core/` that affects multiple features.
- Changing navigation structure or adding new routes.
- Changing DI registration order or scope (feature-level vs global).
- Introducing a new design pattern not already present in the codebase.
- Modifying Drift database schema (migrations have side effects).
- Writing platform-specific code (`Platform` checks, conditional imports).
- Any task where the requirement is ambiguous or has more than one valid interpretation.

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
│   │   │   └── table/    # Drift Table definitions
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
3. Data layer can use domain entity and repo implementation can import Data DTO
4. Only elements in `shared/` or `core/` may be imported across layers or features.
5. Repository **interfaces** live in `domain/repo/`. Repository **implementations** live in `data/repo/`.
6. Data source **interfaces** live in `data/repo/source/`. Data source **implementations** live in `data/source/`.
7. ViewModels communicate exclusively with the domain layer (use cases / services).
8. Local storage currently uses **SharedPreferences** only. Drift is planned but not yet added to `pubspec.yaml`.
9. All cross-layer shared code MUST reside in the feature's `shared/` folder.

## Rules Files

Detailed conventions are defined in `.claude/rules/`.
Read the relevant rule file BEFORE writing or modifying code in the corresponding area.
NEVER load all the rules — only those whose scope matches the current task.

| File                               | Scope                                                                |
| ---------------------------------- | -------------------------------------------------------------------- |
| `code/coding-conventions.md`       | Naming, style, null safety, error handling, async, language features |
| `code/presentation-layer-rules.md` | Pages, widgets, theming, responsive design, performance              |
| `code/viewmodel-rules.md`          | ViewModel layer and Riverpod state management                        |
| `code/data-layer-rules.md`         | Data layer, repository implementations, DTOs, data sources           |
| `code/domain-layer-rules.md`       | Domain layer, repository interfaces, entities, services              |
| `code/di-rules.md`                 | Dependency injection with GetIt                                      |
| `code/routing-rules.md`            | Navigation and route registration                                    |

**Additional sub-folders for logical grouping within a layer are permitted and do NOT constitute an architectural violation.**

## Common Commands

IMPORTANT: Every `dart` and `flutter` CLI command MUST use the `fvm` prefix.
Most used commands are:
- `fvm dart analyze`
- `fvm dart format lib/`

**READ THIS RULE FILE ONLY IF THE COMMAND IS DIFFERENT FROM 2 BELOW:** the full command reference, see `.claude/rules/code/cli-commands.md`.

## Subagents

Delegate these tasks to the corresponding subagent automatically:

- **Code review, PR review, code quality audit** → delegate to `code-reviewer` subagent.
- **Document code, add doc comments, generate documentation** → delegate to `doc-generator` subagent.
- **Debug, fix a bug, investigate a crash, analyze a stack trace** → delegate to `debugger` subagent.

## Skills

Available skills for explicit invocation:

| Skill              | Command               | Invocation    | Use When                                         |
| ------------------ | --------------------- | ------------- | ------------------------------------------------ |
| Dart Documentation | `/dart-documentation` | Explicit only | Writing or improving doc comments in Dart files. |
| Code Review        | `/code-review`        | Explicit only | Running a full 10-area code quality audit.       |
| Debug              | `/debug`              | Explicit only | Diagnosing and fixing a reported bug.            |
| new-feature        | `/new-feature`        | Explicit only | Create directories for new feature.              |
| Git Flow           | `/git-flow`           | Explicit only | Commit and push changes                          |

Skills marked **Explicit only** require the slash command — Claude will not auto-invoke them.
Skills marked **Auto** may be loaded by Claude when it detects relevant context.

For detailed skill procedures, see `.claude/skills/<skill-name>/SKILL.md`.