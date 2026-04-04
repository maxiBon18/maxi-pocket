import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/lifecycle_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/bottom_bar_widget.dart';

/// Standard page scaffold that every screen in MaxiPocket must use as its root.
///
/// Wraps content in a [LifecyclePage] for route-aware lifecycle callbacks, a
/// [PopScope] for back-navigation control, and a [Scaffold] with [SafeArea].
///
/// ```dart
/// MaxiPocketPage(
///   routeName: Routes.homeRoute,
///   child: HomeContent(),
/// );
/// ```
class MaxiPocketPage extends StatelessWidget {
  const MaxiPocketPage({
    required this.routeName,
    this.child,
    super.key,
    this.customOnBack,
    this.didPopNext,
    this.didPush,
    this.didPushNext,
    this.didPop,
    this.leading,
    this.actions,
    this.allowBack = true,
    this.automaticallyImplyLeading = false,
    this.resizeToAvoidBottomInset = true,
    this.extendBodyBehindAppBar = false,
    this.showAppBar = true,
    this.showLeading = false,
    this.topSafeArea = true,
    this.bottomSafeArea = true,
    this.backgroundColor,
    this.showBottomBar = true,
  });

  final Widget? child;

  /// Custom leading widget for the app bar.
  final Widget? leading;

  /// Trailing action widgets for the app bar.
  final List<Widget>? actions;

  /// Route name used by [LifecyclePage] for logging and analytics.
  final String routeName;

  final bool? showAppBar;

  /// Forwarded to [Scaffold.resizeToAvoidBottomInset].
  final bool resizeToAvoidBottomInset;

  /// Forwarded to [Scaffold.extendBodyBehindAppBar].
  final bool extendBodyBehindAppBar;

  /// When `false`, the system back gesture is blocked entirely.
  final bool allowBack;

  final bool showLeading;

  /// Forwarded to [AppBar.automaticallyImplyLeading].
  final bool automaticallyImplyLeading;

  /// Controls [SafeArea] top padding. Defaults to `true`.
  final bool? topSafeArea;

  /// Controls [SafeArea] bottom padding. Defaults to `true`.
  final bool? bottomSafeArea;

  /// Overrides the system back gesture with a custom handler.
  ///
  /// When non-null, [PopScope.canPop] becomes `false` and this callback
  /// is invoked instead.
  final VoidCallback? customOnBack;

  /// Called when the route above this one is popped, revealing this page.
  final VoidCallback? didPopNext;

  /// Called when this page's route is pushed onto the navigator.
  final VoidCallback? didPush;

  /// Called when a new route is pushed on top of this page.
  final VoidCallback? didPushNext;

  /// Called when this page's route is popped off the navigator.
  final VoidCallback? didPop;

  /// Forwarded to [Scaffold.backgroundColor].
  final Color? backgroundColor;

  final bool showBottomBar;

  @override
  Widget build(BuildContext context) {
    return LifecyclePage(
      didPopNext: didPopNext,
      didPush: didPush,
      didPushNext: didPushNext,
      didPop: didPop,
      routeName: routeName,
      child: PopScope(
        canPop: allowBack && customOnBack == null,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) {
            return;
          }
          if (customOnBack != null) customOnBack!.call();
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          // TODO(maxibon): implement app bar
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          bottomNavigationBar: showBottomBar ? const MaxiPocketBottomBarWidget() : null,
          body: SafeArea(top: topSafeArea ?? true, bottom: bottomSafeArea ?? true, child: child ?? const SizedBox()),
        ),
      ),
    );
  }
}
