import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/lifecycle_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/bottom_bar_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/fab_widget.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart' show themeProvider;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show DoubleExtension;
import 'package:maxi_pocket/core/shared/utils/methods.dart' show getShadowsColor;

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
class MaxiPocketPage extends ConsumerWidget {
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
    this.showLeading = true,
    this.leadingIsBackButton = true,
    this.allowBack = true,
    this.actions,
    this.automaticallyImplyLeading = false,
    this.resizeToAvoidBottomInset = true,
    this.extendBodyBehindAppBar = false,
    this.title,
    this.showAppBar = true,
    this.showBottomBar = true,
    this.topSafeArea = true,
    this.bottomSafeArea = true,
    this.backgroundColor,
    this.showFloatingActionButton = false,
  });

  final Widget? child;

  /// Custom leading widget for the app bar.
  final Widget? leading;

  /// Trailing action widgets for the app bar.
  final List<Widget>? actions;

  /// Route name used by [LifecyclePage] for logging and analytics.
  final String routeName;

  final bool showAppBar;

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
  final bool topSafeArea;

  /// Controls [SafeArea] bottom padding. Defaults to `true`.
  final bool bottomSafeArea;

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

  final Widget? title;

  final bool leadingIsBackButton;

  final bool showFloatingActionButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    final double screenHeight = MediaQuery.of(context).size.height;
    return LifecyclePage(
      didPopNext: didPopNext,
      didPush: didPush,
      didPushNext: didPushNext,
      didPop: didPop,
      routeName: routeName,
      child: PopScope(
        canPop: allowBack && customOnBack == null,
        onPopInvokedWithResult: (bool didPop, Object? result) {
          if (didPop) return;
          customOnBack?.call();
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          appBar: showAppBar
              ? _MaxiPocketAppBarWidget(
                  screenHeight: screenHeight,
                  themeMode: themeMode,
                  showLeading: showLeading,
                  leadingIsBackButton: leadingIsBackButton,
                  customOnBack: customOnBack,
                  leading: leading,
                  actions: actions,
                  title: title,
                  automaticallyImplyLeading: automaticallyImplyLeading,
                )
              : null,
          floatingActionButton: showFloatingActionButton ? const MaxiPocketFloatingActionButtonWidget() : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          bottomNavigationBar: showBottomBar ? const MaxiPocketBottomBarWidget() : null,
          body: SafeArea(top: topSafeArea, bottom: bottomSafeArea, child: child ?? const SizedBox()),
        ),
      ),
    );
  }
}

class _MaxiPocketAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const _MaxiPocketAppBarWidget({
    required this.screenHeight,
    required this.themeMode,
    required this.showLeading,
    required this.leadingIsBackButton,
    required this.automaticallyImplyLeading,
    this.customOnBack,
    this.leading,
    this.actions,
    this.title,
  });

  final double screenHeight;
  final MaxiPocketThemeMode themeMode;
  final bool showLeading;
  final bool leadingIsBackButton;
  final bool automaticallyImplyLeading;
  final VoidCallback? customOnBack;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? title;

  @override
  Size get preferredSize => Size.fromHeight(screenHeight.responsiveHeight(DesignConstants.bottomBarDesignHeight));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: screenHeight.responsiveHeight(DesignConstants.bottomBarDesignHeight),
      automaticallyImplyLeading: automaticallyImplyLeading,
      shadowColor: getShadowsColor(themeMode).withValues(alpha: DesignConstants.bottomBarShadowOpacity),
      leading: showLeading
          ? leadingIsBackButton
                ? _MaxiPocketBackButtonWidget(customOnBack: customOnBack)
                : leading
          : null,
      actions: actions,
      title: title,
    );
  }
}

class _MaxiPocketBackButtonWidget extends StatelessWidget {
  const _MaxiPocketBackButtonWidget({this.customOnBack});

  final VoidCallback? customOnBack;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => customOnBack != null ? customOnBack!.call() : Navigator.pop(context),
      enableFeedback: true,
      icon: const Icon(Icons.arrow_back_ios_new),
    );
  }
}
