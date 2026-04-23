---
name: code-review
description: "Run a structured code review on Dart files. Use when asked to review code, review a PR, check code quality, or audit changes in lib/**/*.dart. Covers architecture, code quality, null safety, widgets, state management, error handling, performance, security, responsiveness, and dependencies."
disable-model-invocation: true
---

# Code Review Skill

Run a structured, 10-area code review on modified Dart files and produce a prioritized report.

- For security, dependency, and output format rules, see [reference.md](reference/reference.md).
- For review output examples, see [examples.md](examples/examples.md).

## Scope

- **Target files:** `lib/**/*.dart`
- **Exclude generated files:** skip `*.g.dart`, `*.freezed.dart`, `*.gen.dart`, `*.mocks.dart`, and files with a `// GENERATED CODE` header.

## Severity Levels

- **✅ Passed** — compliant.
- **⚠️ Warning** — suggestion, non-blocking.
- **🔴 Violation** — must fix before push.

## Instructions

### Step 1 — Identify files in scope

- Determine which `.dart` files in `lib/` are modified or under review.
- Exclude generated files (see Scope above).
- If are insicure about the file to review, ask to user a list of file and review them.
- Condition stop:
  - If all files are generated, stop and report: "All target files are generated — no review needed."
  - If no files are in scope, stop and report: "No reviewable Dart files found."

### Step 2 — Architecture & Layer Separation

- Read the project's `CLAUDE.md` § Architectural Constraints.
- Verify each file respects layer boundaries (data, domain, presentation) and dependency direction.

### Step 3 — Dart Code Quality

- Read `.claude/rules/coding-conventions.md`.
- Check naming, formatting, type annotations, immutability, and general Dart idioms.

### Step 4 — Null Safety

- Read `.claude/rules/coding-conventions.md` § Null Safety.
- Verify no unnecessary nullable types, no force-unwraps without justification, and proper null-aware operator usage.

### Step 5 — Flutter Widget Quality

- Read `.claude/rules/presentation-layer-rules.md` §§ General Principles, Page Rules, Widget Rules, Composition.
- Check widget decomposition, `const` constructors, key usage, and build method complexity.

### Step 6 — State Management (Riverpod)

- Read `.claude/rules/viewmodel-rules.md` § Riverpod State Management.
- Verify provider scoping, proper use of `ref.watch` vs `ref.read`, and state mutation patterns.

### Step 7 — Error Handling

- Read `.claude/rules/coding-conventions.md` § Error Handling.
- Additionally verify: every user-facing error produces UI feedback (dialog, snackbar, or error widget).

### Step 8 — Performance

- Read `.claude/rules/presentation-layer-rules.md` § Performance.
- Check for unnecessary rebuilds, missing `const`, expensive operations in build methods.

### Step 9 — Security

- Apply security rules from [reference.md](reference/reference.md) § Security.
- Check for hardcoded credentials, sensitive data in logs, unsanitized input, and unencrypted persisted data.

### Step 10 — Platform & Responsiveness

- Read `.claude/rules/presentation-layer-rules.md` § Responsive Design.
- Check for hardcoded dimensions, missing adaptive layouts, and platform-specific assumptions.

### Step 11 — Dependencies & Imports

- Apply dependency rules from [reference.md](reference/reference.md) § Dependencies & Imports.
- Check import order, unused dependencies, circular dependencies, and unjustified new packages.

### Step 12 — Produce report

- Generate the output following the format in [reference.md](reference/reference.md) § Output Format.
- Use [examples.md](examples/examples.md) to calibrate structure and level of detail.
- List the summary table first, then every 🔴 Violation with file, line, rule violated, and suggested fix.
- If no violations or warnings exist, state "All checks passed" and briefly list what was verified.