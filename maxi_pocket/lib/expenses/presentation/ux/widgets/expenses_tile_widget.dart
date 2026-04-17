import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors, ThemeTextStyles, ThemeDarkColors;
import 'package:maxi_pocket/core/presentation/ux/pages/section_page.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart' show WidgetConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/expenses/shared/constants/expenses_constants.dart';
import 'package:maxi_pocket/expenses/shared/constants/widget_constants.dart';

/// A tabbed view splitting expenses into monthly and yearly billing periods.
///
/// Uses a [TabController] to host two [MaxiPocketSectionPage] instances.
/// [themeMode] is forwarded to all child widgets for consistent color adaptation.
class MaxiPocketExpensesTileWidget extends StatefulWidget {
  const MaxiPocketExpensesTileWidget({super.key, required this.themeMode});

  final MaxiPocketThemeMode themeMode;

  @override
  State<MaxiPocketExpensesTileWidget> createState() => _MaxiPocketExpensesTileWidgetState();
}

class _MaxiPocketExpensesTileWidgetState extends State<MaxiPocketExpensesTileWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: ExpensesConstants.numberOfTabs, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Tab> _getTabs(String numberOfExpenses) => [
    Tab(text: '${ExpensesWidgetConstants.monthlyExpenses} ($numberOfExpenses)'),
    Tab(text: '${ExpensesWidgetConstants.yearlyExpenses} ($numberOfExpenses)'),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DesignConstants.spacing16),
      child: Column(
        children: [
          TabBar(
            tabs: _getTabs(WidgetConstants.activeNumberExpenses),
            controller: _tabController,
            indicatorColor: widget.themeMode == MaxiPocketThemeMode.light
                ? ThemeLightColors.primaryColor
                : ThemeDarkColors.primaryColor,
            tabAlignment: TabAlignment.fill,
            labelStyle: (widget.themeMode == MaxiPocketThemeMode.light
                    ? ThemeTextStyles.appLightTextTheme
                    : ThemeTextStyles.appDarkTextTheme)
                .bodyLarge
                ?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: widget.themeMode == MaxiPocketThemeMode.light
                      ? ThemeLightColors.primaryColor
                      : ThemeDarkColors.primaryColor,
                ),
            unselectedLabelStyle: (widget.themeMode == MaxiPocketThemeMode.light
                    ? ThemeTextStyles.appLightTextTheme
                    : ThemeTextStyles.appDarkTextTheme)
                .bodyLarge
                ?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: widget.themeMode == MaxiPocketThemeMode.light
                      ? ThemeLightColors.textSecondaryColor
                      : ThemeDarkColors.textSecondaryColor,
                ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                MaxiPocketSectionPage(themeMode: widget.themeMode, isAppointment: false),
                MaxiPocketSectionPage(themeMode: widget.themeMode, isAppointment: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
