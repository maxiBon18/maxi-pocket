import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/presentation/ux/routing_service.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart';

/// A widget that observes both route and app lifecycle events, providing hooks for logging and resource management.
///
/// [LifecyclePage] wraps a child widget and listens for navigation (route) changes and application lifecycle changes.
/// It uses [RouteAware] to subscribe to navigation events and [WidgetsBindingObserver] to observe app lifecycle state
/// changes.
/// Useful for logging, analytics, or managing resources based on navigation or app state.
///
/// - [routeName]: The name of the route associated with this page.
/// - [child]: The widget subtree to display.
///
/// Example usage:
/// ```dart
/// LifecyclePage(
///   routeName: '/example',
///   child: MyPage(),
/// )
/// ```
class LifecyclePage extends StatefulWidget {
  const LifecyclePage({
    required this.routeName,
    required this.child,
    this.didPushNext,
    this.didPush,
    this.didPop,
    this.didPopNext,
    super.key,
  });

  final String routeName;
  final VoidCallback? didPopNext;
  final VoidCallback? didPush;
  final VoidCallback? didPushNext;
  final VoidCallback? didPop;
  final Widget child;

  @override
  State<LifecyclePage> createState() => _LifecyclePageState();
}

class _LifecyclePageState extends State<LifecyclePage> with RouteAware, WidgetsBindingObserver {
  final RouteObserver<ModalRoute<dynamic>> _routeObserver = getDI<RoutingService>().routeObserver;
  final Logger _logger = getDI<Logger>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  /// Called when the top route has been popped off, and the current route shows up.
  @override
  void didPopNext() {
    _logger.t('didPopNext ${widget.routeName}');
    if (widget.didPopNext != null) widget.didPopNext!.call();
    super.didPopNext();
  }

  /// Called when the current route has been pushed.
  @override
  void didPush() {
    _logger.t('didPush ${widget.routeName}');
    if (widget.didPush != null) widget.didPush!.call();
    super.didPush();
  }

  /// Called when the current route has been popped off.
  @override
  void didPop() {
    _logger.t('didPop ${widget.routeName}');
    if (widget.didPop != null) widget.didPop!.call();
    super.didPop();
  }

  /// Called when a new route has been pushed, and the current route is no longer visible.
  @override
  void didPushNext() {
    _logger.t('didPushNext ${widget.routeName}');
    if (widget.didPushNext != null) widget.didPushNext!.call();
    super.didPushNext();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.detached:
        _logger.t('AppLifecycleState.detached');
      case AppLifecycleState.resumed:
        _logger.t('AppLifecycleState.resumed');
      case AppLifecycleState.inactive:
        _logger.t('AppLifecycleState.inactive');
      case AppLifecycleState.hidden:
        _logger.t('AppLifecycleState.hidden');
      case AppLifecycleState.paused:
        _logger.t('AppLifecycleState.paused');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
