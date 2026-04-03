---
description: "Code review checklist — activated on review requests"
paths:
  - "lib/**/*.dart"
---
# Code Review

When asked to review code, analyze ALL of the following areas on every modified file.
Report each check as:

- **✅ Passed** — compliant
- **⚠️ Warning** — suggestion, non-blocking
- **🔴 Violation** — must fix before push

---

## 1. Architecture & Layer Separation

> Enforce constraints defined in `CLAUDE.md` § Architectural Constraints.

## 2. Dart Code Quality

> Enforce all rules in `coding-conventions.md`.

## 3. Null Safety

> Enforce null safety rules in `coding-conventions.md` § Null Safety.

## 4. Flutter Widget Quality

> Enforce all rules in `presentation-layer-rules.md` §§ General Principles, Page Rules, Widget Rules, Composition.

## 5. State Management (Riverpod)

> Enforce all rules in `viewmodel-rules.md` § Riverpod State Management.

## 6. Error Handling

> Enforce error handling rules in `coding-conventions.md` § Error Handling.

Additionally verify:
- User-facing errors produce UI feedback (dialog, snackbar, or error widget).

## 7. Performance

> Enforce performance rules in `presentation-layer-rules.md` § Performance.

## 8. Security

- No credentials, API keys, or secrets in the codebase.
- No sensitive data in logs or print statements.
- User input validated and sanitized before processing.
- Sensitive persisted data uses encryption, not plain text.

## 9. Platform & Responsiveness

> Enforce responsive rules in `presentation-layer-rules.md` § Responsive Design.

## 10. Dependencies & Imports

- No unused dependencies in `pubspec.yaml`.
- Import order: `dart:` → `package:flutter/` → `package:` (third-party) → project relative imports.
- Prefer relative imports within the same feature.
- No circular dependencies between features.
- New packages must be justified (maintenance, popularity, null safety).

---

## Output Summary

After the review, provide a summary table:

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

Then list every 🔴 Violation with:
- **File and line** (or range)
- **Rule violated** (reference the source rule file)
- **Suggested fix**
