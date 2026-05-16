import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart'
    show ThemeLightColors, ThemeDarkColors;
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/app_bar_title_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/icon_container_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/list_tile_widget.dart'
    show MaxiPocketListTileWidget;
import 'package:maxi_pocket/core/presentation/ux/widgets/leading_trailing_icon_widget.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart'
    show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketExpensesType, MaxiPocketThemeMode;
import 'package:maxi_pocket/expenses/shared/constants/widget_constants.dart';
import 'package:maxi_pocket/routes.dart' show Routes;

/// The expenses landing page showing a navigation tile for each expense category.
class MaxiPocketExpensesHomePage extends ConsumerWidget {
  const MaxiPocketExpensesHomePage({super.key});

  Color _getColorIconBackground(
    MaxiPocketExpensesType expensesType,
    MaxiPocketThemeMode themeMode,
  ) => switch (expensesType) {
    MaxiPocketExpensesType.subscription =>
      themeMode == MaxiPocketThemeMode.light
          ? ThemeLightColors.expensesSubscriptionIconBackgroundColor
          : ThemeDarkColors.expensesSubscriptionIconBackgroundColor,
    MaxiPocketExpensesType.financing =>
      themeMode == MaxiPocketThemeMode.light
          ? ThemeLightColors.expensesFinancingIconBackgroundColor
          : ThemeDarkColors.expensesFinancingIconBackgroundColor,
    MaxiPocketExpensesType.appointments || MaxiPocketExpensesType.all =>
      themeMode == MaxiPocketThemeMode.light
          ? ThemeLightColors.expensesAllIconBackgroundColor
          : ThemeDarkColors.expensesAllIconBackgroundColor,
  };

  Color _getColorIcon(
    MaxiPocketExpensesType expensesType,
    MaxiPocketThemeMode themeMode,
  ) => switch (expensesType) {
    MaxiPocketExpensesType.subscription =>
      themeMode == MaxiPocketThemeMode.light
          ? ThemeLightColors.expensesSubscriptionIconColor
          : ThemeDarkColors.expensesSubscriptionIconColor,
    MaxiPocketExpensesType.financing =>
      themeMode == MaxiPocketThemeMode.light
          ? ThemeLightColors.expensesFinancingIconColor
          : ThemeDarkColors.expensesFinancingIconColor,
    MaxiPocketExpensesType.appointments || MaxiPocketExpensesType.all =>
      themeMode == MaxiPocketThemeMode.light
          ? ThemeLightColors.expensesAllIconColor
          : ThemeDarkColors.expensesAllIconColor,
  };

  List<Widget> _getExpensesSections(
    MaxiPocketThemeMode themeMode,
    BuildContext context,
  ) {
    final List<Widget> sections = <Widget>[
      MaxiPocketListTileWidget(
        height: DesignConstants.containerSize85,
        title: const Text(
          ExpensesWidgetConstants.subscriptionsTitle,
          textAlign: .start,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        leading: MaxiPocketIconContainerWidget(
          colorBackground: _getColorIconBackground(
            MaxiPocketExpensesType.subscription,
            themeMode,
          ),
          child: MaxiPocketLeadingTrailingIconWidget(
            themeMode: themeMode,
            icon: Icons.subscriptions_outlined,
            colorIcon: _getColorIcon(
              MaxiPocketExpensesType.subscription,
              themeMode,
            ),
          ),
        ),
        trailing: MaxiPocketLeadingTrailingIconWidget(
          themeMode: themeMode,
          icon: Icons.arrow_forward_ios_outlined,
        ),
        onTap: () =>
            Navigator.pushNamed(context, Routes.expensesSubscriptionsRoute),
        themeMode: themeMode,
      ),
      MaxiPocketListTileWidget(
        height: DesignConstants.containerSize85,
        title: const Text(
          ExpensesWidgetConstants.financingsTitle,
          textAlign: .start,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        leading: MaxiPocketIconContainerWidget(
          colorBackground: _getColorIconBackground(
            MaxiPocketExpensesType.financing,
            themeMode,
          ),
          child: MaxiPocketLeadingTrailingIconWidget(
            themeMode: themeMode,
            icon: Icons.account_balance_outlined,
            colorIcon: _getColorIcon(
              MaxiPocketExpensesType.financing,
              themeMode,
            ),
          ),
        ),
        trailing: MaxiPocketLeadingTrailingIconWidget(
          themeMode: themeMode,
          icon: Icons.arrow_forward_ios_outlined,
        ),
        onTap: () =>
            Navigator.pushNamed(context, Routes.expensesFinancingRoute),
        themeMode: themeMode,
      ),
      MaxiPocketListTileWidget(
        height: DesignConstants.containerSize85,
        title: const Text(
          ExpensesWidgetConstants.allExpensesTitle,
          textAlign: .start,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        leading: MaxiPocketIconContainerWidget(
          colorBackground: _getColorIconBackground(
            MaxiPocketExpensesType.all,
            themeMode,
          ),
          child: MaxiPocketLeadingTrailingIconWidget(
            themeMode: themeMode,
            icon: Icons.payments_outlined,
            colorIcon: _getColorIcon(MaxiPocketExpensesType.all, themeMode),
          ),
        ),
        trailing: MaxiPocketLeadingTrailingIconWidget(
          themeMode: themeMode,
          icon: Icons.arrow_forward_ios_outlined,
        ),
        onTap: () => Navigator.pushNamed(context, Routes.expensesAllRoute),
        themeMode: themeMode,
      ),
    ];

    return sections;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    return MaxiPocketPage(
      routeName: Routes.expensesRoute,
      allowBack: false,
      showLeading: false,
      showAppBar: true,
      showBottomBar: true,
      title: MaxiPocketAppBarTitle(
        title: ExpensesWidgetConstants.expensesHomePageTitle,
        subtitle: ExpensesWidgetConstants.expensesHomePageSubtitle,
        themeMode: themeMode,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignConstants.spacing16,
          vertical: DesignConstants.spacing24,
        ),
        child: Column(
          spacing: DesignConstants.spacing12,
          children: <Widget>[..._getExpensesSections(themeMode, context)],
        ),
      ),
    );
  }
}
