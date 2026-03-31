import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/not_found_page.dart';
import 'package:maxi_pocket/core/shared/controllers/custom_navigator_observer.dart';

/// Generates platform-aware routes and exposes navigation observers.
///
/// The route builder map is injected at construction time so that this class
/// remains independent of any specific feature. On iOS it produces
/// [CupertinoPageRoute]; on all other platforms it falls back to
/// [MaterialPageRoute].
///
/// ```dart
/// final service = RoutingService(observer, routes);
/// MaterialApp(
///   onGenerateRoute: service.onGenerateRoute,
///   onUnknownRoute: service.onUnknownRoute,
///   navigatorObservers: [service.navigatorObserver, service.routeObserver],
/// );
/// ```
class RoutingService {
  final MaxiPocketNavigatorObserver _navigatorObserver;
  final Map<String, WidgetBuilder> _routes;
  final RouteObserver<ModalRoute<dynamic>> _routeObserver = RouteObserver<ModalRoute<dynamic>>();

  RoutingService(this._navigatorObserver, this._routes);

  /// Observer that pages subscribe to for [RouteAware] lifecycle callbacks.
  RouteObserver<ModalRoute<dynamic>> get routeObserver => _routeObserver;

  /// Observer that tracks the full navigation stack and logs push/pop events.
  MaxiPocketNavigatorObserver get navigatorObserver => _navigatorObserver;

  /// Returns a platform-specific [Route] wrapping [builder].
  Route<dynamic> _buildPlatformRoute(RouteSettings settings, WidgetBuilder builder) {
    return switch (defaultTargetPlatform) {
      TargetPlatform.iOS => CupertinoPageRoute(settings: settings, builder: builder),
      _ => MaterialPageRoute(settings: settings, builder: builder),
    };
  }

  /// Resolves [routeSettings] against the injected route map.
  ///
  /// Falls back to [MaxiPocketNotFoundPage] when no matching route is found.
  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    final WidgetBuilder? pageBuilder = _routes[routeSettings.name];
    if (pageBuilder != null) {
      return _buildPlatformRoute(routeSettings, pageBuilder);
    }
    return _buildPlatformRoute(routeSettings, (BuildContext context) => const MaxiPocketNotFoundPage());
  }

  /// Fallback used by [MaterialApp.onUnknownRoute].
  ///
  /// Always renders [MaxiPocketNotFoundPage].
  Route<dynamic> onUnknownRoute(RouteSettings routeSettings) {
    return _buildPlatformRoute(routeSettings, (BuildContext context) => const MaxiPocketNotFoundPage());
  }

  /// Returns the named-route arguments for [routeName] if present.
  ///
  /// Searches the navigation stack for the most recent route matching
  /// [routeName] and returns its arguments when they are a
  /// `Map<String, dynamic>`. Returns `null` when the route is not active
  /// or carries no arguments.
  Map<String, dynamic>? getArgumentsForRoute(String routeName) {
    final Route<dynamic>? matchingRoute = _navigatorObserver.routesStack.lastWhereOrNull(
      (Route<dynamic> route) => route.settings.name == routeName,
    );

    if (matchingRoute != null && matchingRoute.settings.arguments is Map<String, dynamic>) {
      return matchingRoute.settings.arguments as Map<String, dynamic>;
    }

    return null;
  }
}
