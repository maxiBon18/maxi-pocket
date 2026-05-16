import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors, ThemeDarkColors;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketExpensesFrequency, MaxiPocketExpensesType, MaxiPocketThemeMode;
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show BuildContextExtension, DoubleExtension;

/// A pill-shaped badge displaying an expense category or billing-frequency label.
///
/// Pass either [expensesType] or [expensesFrequency] — not both. When both are
/// null the badge falls back to the subscription style. Colors adapt to [themeMode].
@immutable
class MaxiPocketBadgeWidget extends StatelessWidget {
  const MaxiPocketBadgeWidget({
    required this.label,
    required this.themeMode,
    super.key,
    this.expensesType,
    this.expensesFrequency,
  });

  final String label;
  final MaxiPocketExpensesType? expensesType;
  final MaxiPocketExpensesFrequency? expensesFrequency;
  final MaxiPocketThemeMode themeMode;

  Color _getBackgroundColor() {
    final MaxiPocketExpensesType? expType = expensesType;
    if (expType != null) {
      return switch (expType) {
        MaxiPocketExpensesType.subscription || MaxiPocketExpensesType.all =>
          themeMode == MaxiPocketThemeMode.light
              ? ThemeLightColors.primaryLightColor
              : ThemeDarkColors.primarySurfaceColor,
        MaxiPocketExpensesType.financing =>
          themeMode == MaxiPocketThemeMode.light
              ? ThemeLightColors.badgeFinancingBackgroundColor
              : ThemeDarkColors.expensesFinancingIconBackgroundColor,
        MaxiPocketExpensesType.appointments =>
          themeMode == MaxiPocketThemeMode.light
              ? ThemeLightColors.appointmentsBadgeBackgroundColor
              : ThemeDarkColors.appointmentsBadgeBackgroundColor,
      };
    }
    final MaxiPocketExpensesFrequency? expFreq = expensesFrequency;
    if (expFreq != null) {
      return switch (expFreq) {
        MaxiPocketExpensesFrequency.monthly =>
          themeMode == MaxiPocketThemeMode.light
              ? ThemeLightColors.expensesMonthlyColor
              : ThemeDarkColors.expensesMonthlyColor,
        MaxiPocketExpensesFrequency.annual =>
          themeMode == MaxiPocketThemeMode.light
              ? ThemeLightColors.expensesAnnualColor
              : ThemeDarkColors.expensesAnnualColor,
      };
    }
    return ThemeLightColors.primaryLightColor;
  }

  Color _getTextColor() {
    final MaxiPocketExpensesType? expType = expensesType;
    if (expType != null) {
      return switch (expType) {
        MaxiPocketExpensesType.subscription || MaxiPocketExpensesType.all => ThemeLightColors.errorColor,
        MaxiPocketExpensesType.financing => ThemeLightColors.secondaryDarkColor,
        MaxiPocketExpensesType.appointments =>
          themeMode == MaxiPocketThemeMode.light ? ThemeLightColors.textPrimaryColor : ThemeDarkColors.textPrimaryColor,
      };
    }
    final MaxiPocketExpensesFrequency? expFreq = expensesFrequency;
    if (expFreq != null) {
      return switch (expFreq) {
        MaxiPocketExpensesFrequency.monthly => ThemeLightColors.textMonthlyColor,
        MaxiPocketExpensesFrequency.annual => ThemeLightColors.textAnnualColor,
      };
    }
    return ThemeLightColors.errorColor;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: DesignConstants.spacing8, vertical: DesignConstants.spacing4),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(DesignConstants.radius40)),
      ),
      height: screenHeight.responsiveHeight(DesignConstants.containerSize24).normalizedSizeWithTextScaler(context),
      child: Text(
        label,
        style: context.textTheme.labelMedium?.copyWith(color: _getTextColor()),
        textAlign: .center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
