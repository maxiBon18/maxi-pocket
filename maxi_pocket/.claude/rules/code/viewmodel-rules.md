---
description: "Rules for ViewModel layer and Riverpod state management"
paths:
  - "lib/*/presentation/viewmodel/**/*.dart"
---
# ViewModel

- One ViewModel per file. File name: `<n>_viewmodel.dart`.
- ViewModel communicates only with domain layer (use cases / services).
- Never import data layer or Firebase-specific code.

## Riverpod State Management

- One provider per file.
- Providers scoped appropriately (feature-level vs global).
- `AsyncValue` used for all async states (loading / error / data) except `lib/core/presentation/viewmodel/loading_viewmodel.dart`.
- `ref.watch` inside `build()` for reactive UI. `ref.read` only inside callbacks and event handlers.
- `autoDispose` used when the provider should not outlive its consumer.
- No direct state mutation — use Notifier methods exclusively.
- ALWAYS use loading, error, and success states when using `FutureProvider`, `StreamProvider`, or `AsyncNotifierProvider`.
- Provider observation is handled by `@lib/core/shared/utils/loggers.dart`.
