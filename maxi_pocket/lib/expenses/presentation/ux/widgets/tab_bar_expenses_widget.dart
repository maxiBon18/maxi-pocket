import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart' show CommitmentsEntity, WrapperCommitmentsEntity;
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors, ThemeTextStyles, ThemeDarkColors;
import 'package:maxi_pocket/core/presentation/ux/pages/section_page.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode, MaxiPocketExpensesFrequency;
import 'package:maxi_pocket/core/shared/utils/helpers_method.dart' show getSpecificFrequencyWrapperCommitments;
import 'package:maxi_pocket/expenses/shared/constants/expenses_constants.dart';
import 'package:maxi_pocket/expenses/shared/constants/widget_constants.dart';

/// A tabbed view splitting expenses into monthly and yearly billing periods.
///
/// Uses a [TabController] to host two [MaxiPocketSectionPage] instances.
/// [themeMode] is forwarded to all child widgets for consistent color adaptation.
class MaxiPocketTabBarExpensesWidget extends StatefulWidget {
  const MaxiPocketTabBarExpensesWidget({
    required this.themeMode,
    required this.numberOfMonthlyExpenses,
    required this.numberOfYearlyExpenses,
    required this.totalAmountOfMonthlyExpenses,
    required this.totalAmountOfYearlyExpenses,
    required this.entityToShow,
    super.key,
    this.onEdit,
    this.onDelete,
  });

  final MaxiPocketThemeMode themeMode;
  final int numberOfMonthlyExpenses;
  final int numberOfYearlyExpenses;
  final double totalAmountOfMonthlyExpenses;
  final double totalAmountOfYearlyExpenses;
  final List<WrapperCommitmentsEntity> entityToShow;
  final void Function(CommitmentsEntity entity)? onEdit;
  final void Function(CommitmentsEntity entity)? onDelete;

  @override
  State<MaxiPocketTabBarExpensesWidget> createState() => _MaxiPocketTabBarExpensesWidgetState();
}

class _MaxiPocketTabBarExpensesWidgetState extends State<MaxiPocketTabBarExpensesWidget>
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

  /// Builds tab labels with [numberOfExpenses] appended in parentheses.
  List<Tab> _getTabs() => <Tab>[
    Tab(text: '${ExpensesWidgetConstants.monthlyExpenses} (${widget.numberOfMonthlyExpenses})'),
    Tab(text: '${ExpensesWidgetConstants.yearlyExpenses} (${widget.numberOfYearlyExpenses})'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DesignConstants.spacing16),
      child: Column(
        children: <Widget>[
          TabBar(
            tabs: _getTabs(),
            controller: _tabController,
            indicatorColor: widget.themeMode == MaxiPocketThemeMode.light
                ? ThemeLightColors.primaryColor
                : ThemeDarkColors.primaryColor,
            tabAlignment: TabAlignment.fill,
            labelStyle:
                (widget.themeMode == MaxiPocketThemeMode.light
                        ? ThemeTextStyles.appLightTextTheme
                        : ThemeTextStyles.appDarkTextTheme)
                    .bodyLarge
                    ?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: widget.themeMode == MaxiPocketThemeMode.light
                          ? ThemeLightColors.primaryColor
                          : ThemeDarkColors.primaryColor,
                    ),
            unselectedLabelStyle:
                (widget.themeMode == MaxiPocketThemeMode.light
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
              children: <Widget>[
                MaxiPocketSectionPage(
                  themeMode: widget.themeMode,
                  isAppointment: false,
                  totalAmountOfExpense: widget.totalAmountOfMonthlyExpenses,
                  numberOfExpenses: widget.numberOfMonthlyExpenses,
                  entityToShow: getSpecificFrequencyWrapperCommitments(
                    widget.entityToShow,
                    MaxiPocketExpensesFrequency.monthly,
                  ),
                  onEdit: widget.onEdit,
                  onDelete: widget.onDelete,
                ),
                MaxiPocketSectionPage(
                  themeMode: widget.themeMode,
                  isAppointment: false,
                  totalAmountOfExpense: widget.totalAmountOfYearlyExpenses,
                  numberOfExpenses: widget.numberOfYearlyExpenses,
                  entityToShow: getSpecificFrequencyWrapperCommitments(
                    widget.entityToShow,
                    MaxiPocketExpensesFrequency.annual,
                  ),
                  onEdit: widget.onEdit,
                  onDelete: widget.onDelete,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
