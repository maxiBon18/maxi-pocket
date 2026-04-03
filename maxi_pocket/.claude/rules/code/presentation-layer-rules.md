---
description: "Rules for pages, widgets, theming, and responsive UI"
paths:
  - "lib/*/presentation/ux/**/*.dart"
---
# UI Guidelines

Naming conventions and code quality rules are defined in `coding-conventions.md`.

## General Principles

- UI layer MUST NOT contain business logic. Delegate to ViewModels.
- Prefer `StatelessWidget` over `StatefulWidget` when no local mutable state is needed.
- Use `const` constructors on all widgets and static child trees.

## Page Rules

- Page file name: `<feature_name>_page.dart`.
- Page widget class name MUST start with `MaxiPocket` (e.g., `MaxiPocketHomePage`).
- Every page MUST use `MaxiPocketPage` as its root widget.

## Widget Rules

- Widget class name MUST start with `MaxiPocket` (e.g., `MaxiPocketBalanceCard`).
- Feature-specific widgets reside in the feature's `presentation/ux/widgets/` folder.
- Shared widgets used by 2+ features reside in `lib/core/presentation/ux/widgets/`.
- Use small, private `Widget` classes instead of private helper methods returning a `Widget`.

## Composition

- Keep `build()` methods ≤ 30 lines.
- If `build()` exceeds 30 lines, extract sub-widgets into dedicated files with a single visual responsibility.
- No business logic inside `build()`, `initState()`, or `dispose()`.
- `Key` parameter required on widgets used inside lists or conditional rendering.

## Performance

- Use `ListView.builder` or `SliverList` for lists exceeding ~10 items.
- Use `const` constructors in `build()` to reduce rebuilds.
- No expensive operations (network calls, heavy computation) inside `build()`.
- Use `Isolate.run()` (or `compute()`) for CPU-intensive work.
- No repeated `MediaQuery.of(context)` calls — cache in a local variable.
- Dispose controllers, streams, and subscriptions in `dispose()`.
- No unnecessary `setState()` or provider rebuilds.
- Images use caching (`CachedNetworkImage` or equivalent).
- No full widget tree rebuilds — use `const`, `select()`, or granular providers.
- Animations use `AnimatedBuilder` or `AnimatedWidget`, not parent rebuilds.

## Style and Theme

- No hardcoded colors, text, or text styles in widget code.
- All colors defined in `lib/core/presentation/ux/theme/color.dart`.
- All theme components defined in `lib/core/presentation/ux/theme/theme.dart`.
- Generalize design tokens in `ThemeData`. When insufficient, create a custom widget.

## Responsive Design

- No fixed pixel widths on layout containers. Use `Expanded`, `Flexible`, `FractionallySizedBox`, `LayoutBuilder`.
- Handle safe areas with `SafeArea` or `MediaQuery.padding`.
- Handle keyboard overflow on form pages with `SingleChildScrollView` or `resizeToAvoidBottomInset`.
- Text MUST scale with system font size settings (`MediaQuery.textScalerOf(context)`, NOT deprecated `textScaleFactor`).
- Platform-specific code MUST use `Platform` checks or conditional imports.
