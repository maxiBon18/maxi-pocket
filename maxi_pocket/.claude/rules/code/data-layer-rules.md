---
description: "Rules for data layer"
paths: 
    - "lib/*/data/**/*.dart"
---
# Data Layer

- Never import presentation or ux layer files.
- EVERY DTO must use `freezed` + `json_serializable` or `drift` annotations.
- EVERY datasource implementation must implement the interface defined in `data/repo/source`.
- EVERY repository implementation must implement the interface defined in `domain/services/repo`.
- In repository you MUST use only data class.