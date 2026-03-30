import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/lifecycle_page.dart';

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
    this.actions,
    this.allowBack = true,
    this.automaticallyImplyLeading = false,
    this.resizeToAvoidBottomInset = true,
    this.extendBodyBehindAppBar = false,
    this.showAppBar = true,
    this.showLeading = false,
    this.topSafeArea = true,
    this.bottomSafeArea = true,
  });

  final Widget? child;
  final Widget? leading;
  final List<Widget>? actions;
  final String routeName;
  final bool? showAppBar;
  final bool resizeToAvoidBottomInset;
  final bool extendBodyBehindAppBar;
  final bool allowBack;
  final bool showLeading;
  final bool automaticallyImplyLeading;
  final bool? topSafeArea;
  final bool? bottomSafeArea;
  final VoidCallback? customOnBack;
  final VoidCallback? didPopNext;
  final VoidCallback? didPush;
  final VoidCallback? didPushNext;
  final VoidCallback? didPop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          // TODO: do appbar
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          body: SafeArea(top: topSafeArea ?? true, bottom: bottomSafeArea ?? true, child: child ?? const SizedBox()),
        ),
      ),
    );
  }
}
