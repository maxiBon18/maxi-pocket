import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart' show getDI;

/// [NavigatorObserver] that maintains a live stack of active routes and logs every navigation event.
///
/// Registered with the root [MaterialApp] navigator so that the current back-stack
/// is inspectable at any time via [routesStack].
class MaxiPocketNavigatorObserver extends NavigatorObserver {
  final Logger _logger = getDI<Logger>();

  final List<Route<dynamic>> _routesStack = <Route<dynamic>>[];

  MaxiPocketNavigatorObserver();

  /// Ordered list of routes currently on the navigation stack, with the most recently pushed route last.
  List<Route<dynamic>> get routesStack => _routesStack;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _logger.t(
      'Custom Navigator Class => didPush from ${previousRoute?.settings.name} to ${route.settings.name}',
    );
    _routesStack.add(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _logger.t(
      'Custom Navigator Class => didPop from ${route.settings.name} to ${previousRoute?.settings.name}',
    );
    _routesStack.remove(route);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _logger.t(
      'Custom Navigator Class => didRemove from ${previousRoute?.settings.name} to ${route.settings.name}',
    );
    _routesStack.remove(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _logger.t(
      'Custom Navigator Class => didReplace from ${oldRoute?.settings.name} to ${newRoute?.settings.name}',
    );
    if (oldRoute != null) _routesStack.remove(oldRoute);
    if (newRoute != null) _routesStack.add(newRoute);
  }

  @override
  void didChangeTop(Route<dynamic> topRoute, Route<dynamic>? previousTopRoute) {
    super.didChangeTop(topRoute, previousTopRoute);
    _logger.t(
      'Custom Navigator Class => didChangeTop from ${previousTopRoute?.settings.name} to ${topRoute.settings.name}',
    );
  }

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    super.didStartUserGesture(route, previousRoute);
    _logger.t(
      'Custom Navigator Class => didStartUserGesture from ${previousRoute?.settings.name} to ${route.settings.name}',
    );
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    _logger.t('Custom Navigator Class => stopUserGesture');
  }
}
