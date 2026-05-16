import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/presentation/ux/routing_service.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart';

/// Wraps a child widget with [RouteAware] and [WidgetsBindingObserver] hooks for route and app lifecycle events.
///
/// Callers supply optional [VoidCallback]s for each navigation and lifecycle transition;
/// unhandled events are logged at trace level via the app [Logger].
class LifecyclePage extends StatefulWidget {
  const LifecyclePage({
    required this.routeName,
    required this.child,
    this.didPushNext,
    this.didPush,
    this.didPop,
    this.didPopNext,
    this.onDetached,
    this.onResumed,
    this.onInactive,
    this.onHidden,
    this.onPaused,
    super.key,
  });

  /// Named route this widget is associated with, used in trace logs.
  final String routeName;

  /// Called when the route below this one has been popped and this route is visible again.
  final VoidCallback? didPopNext;

  /// Called when this route has been pushed onto the navigator.
  final VoidCallback? didPush;

  /// Called when a new route is pushed on top of this one, hiding it.
  final VoidCallback? didPushNext;

  /// Called when this route is popped off the navigator.
  final VoidCallback? didPop;

  /// Called when the app is detached from the UI engine.
  final VoidCallback? onDetached;

  /// Called when the app returns to the foreground and regains focus.
  final VoidCallback? onResumed;

  /// Called when the app loses focus but remains visible (e.g. notification shade open).
  final VoidCallback? onInactive;

  /// Called when the app is hidden but not yet paused (applicable on some platforms).
  final VoidCallback? onHidden;

  /// Called when the app is paused (moved to background).
  final VoidCallback? onPaused;

  /// Widget subtree rendered by this lifecycle wrapper.
  final Widget child;

  @override
  State<LifecyclePage> createState() => _LifecyclePageState();
}

class _LifecyclePageState extends State<LifecyclePage>
    with RouteAware, WidgetsBindingObserver {
  final RouteObserver<ModalRoute<dynamic>> _routeObserver =
      getDI<RoutingService>().routeObserver;
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
    final ModalRoute<dynamic>? route = ModalRoute.of(context);
    if (route != null) _routeObserver.subscribe(this, route);
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
        if (widget.onDetached != null) widget.onDetached!.call();
      case AppLifecycleState.resumed:
        _logger.t('AppLifecycleState.resumed');
        if (widget.onResumed != null) widget.onResumed!.call();
      case AppLifecycleState.inactive:
        _logger.t('AppLifecycleState.inactive');
        if (widget.onInactive != null) widget.onInactive!.call();
      case AppLifecycleState.hidden:
        _logger.t('AppLifecycleState.hidden');
        if (widget.onHidden != null) widget.onHidden!.call();
      case AppLifecycleState.paused:
        _logger.t('AppLifecycleState.paused');
        if (widget.onPaused != null) widget.onPaused!.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
