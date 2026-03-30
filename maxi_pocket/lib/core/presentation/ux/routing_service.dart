import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/not_found_page.dart';
import 'package:maxi_pocket/core/shared/constants/routes.dart' show Routes;
import 'package:maxi_pocket/core/shared/controllers/custom_navigator_observer.dart';
import 'package:maxi_pocket/home/presentation/ux/pages/home_page.dart';

/// Handles route generation and navigation observation for the application.
///
/// [RoutingService] owns the route builder registry, wraps platform-specific
/// page transitions, and exposes both a [RouteObserver] and a
/// [MaxiPocketNavigatorObserver] for use in [MaterialApp].
class RoutingService {
  final MaxiPocketNavigatorObserver _navigatorObserver;

  final RouteObserver<ModalRoute<dynamic>> _routeObserver = RouteObserver<ModalRoute<dynamic>>();

  static final Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
    Routes.initialRoute: (BuildContext context) => const MaxiPocketHome(),
  };

  RoutingService(this._navigatorObserver);

  RouteObserver<ModalRoute<dynamic>> get routeObserver => _routeObserver;

  MaxiPocketNavigatorObserver get navigatorObserver => _navigatorObserver;

  Route<dynamic> _buildPlatformRoute(RouteSettings settings, WidgetBuilder builder) {
    return switch (defaultTargetPlatform) {
      TargetPlatform.iOS => CupertinoPageRoute(settings: settings, builder: builder),
      _ => MaterialPageRoute(settings: settings, builder: builder),
    };
  }

  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    final WidgetBuilder? pageBuilder = _routes[routeSettings.name];
    if (pageBuilder != null) {
      return _buildPlatformRoute(routeSettings, pageBuilder);
    }
    return _buildPlatformRoute(routeSettings, (BuildContext context) => const MaxiPocketNotFoundPage());
  }

  Route<dynamic> onUnknownRoute(RouteSettings routeSettings) {
    return _buildPlatformRoute(routeSettings, (BuildContext context) => const MaxiPocketNotFoundPage());
  }

  /// Returns the named-route arguments for [routeName] if present.
  ///
  /// Returns `null` when the route is not active or carries no arguments.
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
