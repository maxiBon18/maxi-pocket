---
description: "Rules for Dependency Injection with GetIt"
paths:
  - "lib/*/shared/controllers/di.dart"
---
# Dependency Injection

- Use GetIt for service registration.
- Register all feature dependencies in the feature's controller file (`lib/<feature>/shared/controllers/di.dart`).
- Register cross-feature dependencies in `lib/core/shared/controllers/di.dart`.
- Registration order: data source → repository → service / use case → ViewModel.
