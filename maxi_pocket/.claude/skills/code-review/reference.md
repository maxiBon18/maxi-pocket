# Code Review — Reference

## Security

These rules are evaluated directly by the skill (not delegated to an external rule file):

- No credentials, API keys, or secrets in the codebase.
- No sensitive data in logs or print statements (`print()`, `debugPrint()`, `log()`).
- User input validated and sanitized before processing.
- Sensitive persisted data uses encryption (e.g., `flutter_secure_storage`), not plain text (`SharedPreferences`).

## Dependencies & Imports

These rules are evaluated directly by the skill:

- No unused dependencies in `pubspec.yaml`.
- Import order: `dart:` → `package:flutter/` → `package:` (third-party) → project relative imports.
- Prefer relative imports within the same feature.
- No circular dependencies between features.
- New packages must be justified (maintenance status, pub.dev popularity, null safety support).

## External Rule Files

The following project rule files contain the authoritative standards for their respective review areas. Read each file at the step that references it:

| Review Area      | Rule File                                   | Section                                                      |
| ---------------- | ------------------------------------------- | ------------------------------------------------------------ |
| Architecture     | `CLAUDE.md`                                 | § Architectural Constraints                                  |
| Code Quality     | `.claude/rules/coding-conventions.md`       | Full file                                                    |
| Null Safety      | `.claude/rules/coding-conventions.md`       | § Null Safety                                                |
| Widget Quality   | `.claude/rules/presentation-layer-rules.md` | §§ General Principles, Page Rules, Widget Rules, Composition |
| State Management | `.claude/rules/viewmodel-rules.md`          | § Riverpod State Management                                  |
| Error Handling   | `.claude/rules/coding-conventions.md`       | § Error Handling                                             |
| Performance      | `.claude/rules/presentation-layer-rules.md` | § Performance                                                |
| Responsiveness   | `.claude/rules/presentation-layer-rules.md` | § Responsive Design                                          |

## Output Format

### Summary Table

Produce this table first:

| Area             | Result    | Issues            |
| ---------------- | --------- | ----------------- |
| Architecture     | ✅ / ⚠️ / 🔴 | Brief description |
| Code Quality     | ✅ / ⚠️ / 🔴 | Brief description |
| Null Safety      | ✅ / ⚠️ / 🔴 | Brief description |
| Widget Quality   | ✅ / ⚠️ / 🔴 | Brief description |
| State Management | ✅ / ⚠️ / 🔴 | Brief description |
| Error Handling   | ✅ / ⚠️ / 🔴 | Brief description |
| Performance      | ✅ / ⚠️ / 🔴 | Brief description |
| Security         | ✅ / ⚠️ / 🔴 | Brief description |
| Responsiveness   | ✅ / ⚠️ / 🔴 | Brief description |
| Dependencies     | ✅ / ⚠️ / 🔴 | Brief description |

### Violation Detail

After the summary table, list every 🔴 Violation:

- **File and line** (or range).
- **Rule violated** (reference the source rule file and section).
- **Suggested fix** (concrete, actionable).

Then list every ⚠️ Warning with the same structure.