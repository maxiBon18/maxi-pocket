---
description: "Rules for domain layer: entities, services, and repository interfaces"
paths:
  - "lib/*/domain/**/*.dart"
---
# Domain Layer

- Never import presentation or data layer files.
- Every entity MUST reside in `lib/<feature>/domain/entities/`.
- Entities are the only domain objects that may be used in the presentation layer and services.
- Every repository interface MUST be defined in `domain/services/repo/`.
- Every service MUST be defined and implemented in `domain/services/`.
- Business logic MUST reside in services or ViewModels — never in the data or presentation layer.
