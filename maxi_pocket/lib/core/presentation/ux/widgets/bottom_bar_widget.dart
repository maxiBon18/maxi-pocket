import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/box_decoration_widget.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/bottom_bar_viewmodel.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart';
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show DoubleExtension;
import 'package:maxi_pocket/core/shared/utils/methods.dart' show getShadowsColor, getBottomBarBorderColor;

/// App-wide bottom navigation bar with themed border, shadow, and page-index state.
///
/// Wraps a [NavigationBar] in [_BoxDecorationWidget] to apply the correct top-border
/// and drop-shadow colours for the active [MaxiPocketThemeMode]. The selected index
/// is owned by [bottomBarProvider] so any widget in the tree can react to tab changes.
class MaxiPocketBottomBarWidget extends ConsumerWidget {
  const MaxiPocketBottomBarWidget({super.key});

  List<NavigationDestination> _getDestinations() {
    const List<NavigationDestination> destinations = <NavigationDestination>[
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
        icon: Icon(Icons.calendar_today_outlined),
        label: WidgetConstants.bottomBarAppointmentLabel,
        tooltip: WidgetConstants.bottomBarAppointmentLabel,
      ),
      NavigationDestination(
        icon: Icon(Icons.settings_outlined),
        label: WidgetConstants.bottomBarSettingsLabel,
        tooltip: WidgetConstants.bottomBarSettingsLabel,
      ),
    ];

    return destinations;
  }

  List<BoxShadow> _getBoxShadows(MaxiPocketThemeMode themeMode) => <BoxShadow>[
    BoxShadow(
      offset: DesignConstants.bottomBarOffsetFirst,
      blurStyle: BlurStyle.outer,
      blurRadius: DesignConstants.bottomBarBlurRadiusFirst,
      color: getShadowsColor(themeMode).withValues(alpha: DesignConstants.bottomBarShadowOpacity),
      spreadRadius: DesignConstants.bottomBarSpreadRadiusFirst,
    ),
    BoxShadow(
      offset: DesignConstants.bottomBarOffsetSecond,
      blurStyle: BlurStyle.outer,
      blurRadius: DesignConstants.bottomBarBlurRadiusSecond,
      color: getShadowsColor(themeMode).withValues(alpha: DesignConstants.bottomBarShadowOpacity),
      spreadRadius: DesignConstants.bottomBarSpreadRadiusSecond,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Maps each bottom-bar tab index to its named route.
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    final int currentPageIndex = ref.watch(bottomBarProvider);
    final double screenHeight = MediaQuery.of(context).size.height;
    return MaxiPocketBoxDecorationWidget(
      themeMode: themeMode,
      boxShadows: _getBoxShadows(themeMode),
      border: Border(
        top: BorderSide(width: DesignConstants.bottomBarBorderWidth, color: getBottomBarBorderColor(themeMode)),
      ),
      child: NavigationBar(
        destinations: _getDestinations(),
        selectedIndex: currentPageIndex,
        height: screenHeight
            .responsiveHeight(DesignConstants.bottomBarDesignHeight)
            .normalizedSizeWithTextScaler(context),
        onDestinationSelected: (int index) {
          if (index == currentPageIndex) return;
          ref.read(bottomBarProvider.notifier).setCurrentIndex(index);
          final String? route = WidgetConstants.tabRoutes[index];
          if (route != null) Navigator.of(context).pushReplacementNamed(route);
        },
      ),
    );
  }
}
