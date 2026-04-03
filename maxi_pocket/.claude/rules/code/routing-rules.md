---
description: "Rules for creating new app routes and navigation"
paths:
  - "lib/routes.dart"
  - "lib/core/presentation/ux/routing_service.dart"
---
# Routes

- Every new route MUST be added to `@lib/routes.dart`.
- Route constants MUST follow the format: `static const String <name>Route = '/<routeName>';`.
- Every route MUST also be added to the `routes` map where the key is the route constant and the value is the corresponding page widget.
- Navigation system: `@lib/core/presentation/ux/routing_service.dart`.
- Navigation observer: `@lib/core/shared/controllers/custom_navigator_observer.dart`.
- Always use named navigation.
