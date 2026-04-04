import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors, ThemeDarkColors;
import 'package:maxi_pocket/core/presentation/viewmodel/bottom_bar_viewmodel.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart';
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart';
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show DoubleExtension;

/// App-wide bottom navigation bar with themed border, shadow, and page-index state.
///
/// Wraps a [NavigationBar] in [_BoxDecorationWidget] to apply the correct top-border
/// and drop-shadow colours for the active [MaxiPocketThemeMode]. The selected index
/// is owned by [bottomBarProvider] so any widget in the tree can react to tab changes.
class MaxiPocketBottomBarWidget extends ConsumerWidget {
  const MaxiPocketBottomBarWidget({super.key});

  List<NavigationDestination> _getDestinations() {
    const List<NavigationDestination> destinations = [
      NavigationDestination(
        icon: Icon(Icons.home_outlined),
        label: WidgetConstants.bottomBarHomeLabel,
        tooltip: WidgetConstants.bottomBarHomeLabel,
      ),
      NavigationDestination(
        icon: Icon(Icons.payments_outlined),
        label: WidgetConstants.bottomBarExpensesLabel,
        tooltip: WidgetConstants.bottomBarExpensesLabel,
      ),
      NavigationDestination(
        icon: Icon(Icons.settings_outlined),
        label: WidgetConstants.bottomBarSettingsLabel,
        tooltip: WidgetConstants.bottomBarSettingsLabel,
      ),
    ];

    return destinations;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    final int currentPageIndex = ref.watch(bottomBarProvider);
    final double screenHeight = MediaQuery.of(context).size.height;
    return _BoxDecorationWidget(
      themeMode: themeMode,
      child: NavigationBar(
        destinations: _getDestinations(),
        selectedIndex: currentPageIndex,
        height: screenHeight.bottomBarHeight,
        onDestinationSelected: (int index) => ref.read(bottomBarProvider.notifier).setCurrentIndex(index),
      ),
    );
  }
}

/// Wraps [child] in a [DecoratedBox] with a themed top border and outer drop shadows.
class _BoxDecorationWidget extends StatelessWidget {
  const _BoxDecorationWidget({required this.child, required this.themeMode});

  final Widget child;
  final MaxiPocketThemeMode themeMode;

  Color _getBorderColor(MaxiPocketThemeMode themeMode) {
    final Color borderColor = themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.bottomNavigationBarTopBorderColor
        : ThemeDarkColors.bottomNavigationBarTopBorderColor;

    return borderColor;
  }

  Color _getShadowsColor(MaxiPocketThemeMode themeMode) {
    final Color shadowsColor = themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.bottomNavigationBarShadowsColor
        : ThemeDarkColors.bottomNavigationBarShadowsColor;

    return shadowsColor;
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: DesignConstants.bottomBarBorderWidth, color: _getBorderColor(themeMode)),
        ),
        boxShadow: [
          BoxShadow(
            offset: DesignConstants.bottomBarOffsetFirst,
            blurStyle: BlurStyle.outer,
            blurRadius: DesignConstants.bottomBarBlurRadiusFirst,
            color: _getShadowsColor(themeMode).withValues(alpha: DesignConstants.bottomBarShadowOpacity),
            spreadRadius: DesignConstants.bottomBarSpreadRadiusFirst,
          ),
          BoxShadow(
            offset: DesignConstants.bottomBarOffsetSecond,
            blurStyle: BlurStyle.outer,
            blurRadius: DesignConstants.bottomBarBlurRadiusSecond,
            color: _getShadowsColor(themeMode).withValues(alpha: DesignConstants.bottomBarShadowOpacity),
            spreadRadius: DesignConstants.bottomBarSpreadRadiusSecond,
          ),
        ],
      ),
      child: child,
    );
  }
}
