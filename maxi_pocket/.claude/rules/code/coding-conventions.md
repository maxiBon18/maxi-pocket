---
description: "Naming, style, code quality, null safety, and error handling conventions for all Dart code"
paths:
  - "lib/**/*.dart"
---
# Coding Conventions

## Language

- All code (identifiers, comments, documentation) MUST be written in English.

## Naming

| Element            | Convention                       | Example                               |
| ------------------ | -------------------------------- | ------------------------------------- |
| Files              | `snake_case` with type suffix    | `home_page.dart`, `payment_dto.dart`  |
| Classes            | `PascalCase`                     | `SubscriptionEntity`                  |
| Variables, methods | `camelCase`                      | `totalAmount`, `fetchSubscriptions()` |
| Private members    | `_` prefix                       | `_controller`, `_calculateTotal()`    |
| Booleans           | `is`/`has`/`should`/`can` prefix | `isActive`, `hasExpired`, `canDelete` |

### File Naming by Type

- Pages: `<feature>_page.dart`
- Widgets: `<name>_widget.dart`
- DTOs: `<name>_dto.dart`
- Entities: `<name>_entity.dart`
- ViewModels: `<name>_viewmodel.dart`
- Services: `<name>_service.dart`
- Repository interfaces: `<name>_repository.dart`
- Repository implementations: `<name>_repository_impl.dart`
- Data source interfaces: `<name>_source.dart`
- Data source implementations: `<name>_source_impl.dart`

## Code Quality

- Max line length: **120 characters**.
- No `dynamic` types unless strictly necessary — prefer strong typing.
- No `as` casting without a prior `is` check.
- No unused imports, variables, or parameters.
- No deprecated API usage.
- `const` constructors wherever possible.
- `final` for variables that are never reassigned.
- `late` only when initialization is guaranteed before access.
- `@immutable` on every class where all fields are final.
- No hardcoded or magic values — store in the feature's `shared/constants/` folder.
- Functions: single-purpose, ≤30 lines.
- Prefer functional and declarative patterns over imperative style.
- Favor composition over inheritance.
- Prefer immutable data structures.

## Async

- Use `async`/`await` for asynchronous operations, `Stream` for event sequences.
- Every async call MUST have error handling (see § Error Handling).

## Language Features

- Use pattern matching (`switch` expressions, destructuring) where it simplifies logic.
- Use records to return multiple values when a full class is excessive.
- Prefer exhaustive `switch` expressions. Do NOT use `break` in switch expressions.
- Use `=>` for single-expression functions and getters.

## Null Safety

- No unnecessary `!` (bang operator) — handle null cases explicitly.
- No `?.` chains longer than 2 levels — extract into named variables.
- Provide default values where `null` is not a valid state.
- Nullable return types MUST be intentional and documented with a comment.

## Error Handling

- No `catchError` — use `try/catch`.
- Prefer specifying the exception type in `catch` blocks. Bare `catch (e)` is acceptable when the type is unknown.
- No empty `catch` blocks — at minimum, log the error.
- Define custom exceptions for domain-specific error conditions.
