import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors;
import 'package:maxi_pocket/core/presentation/ux/widgets/card_widget.dart' show MaxiPocketSummaryCardWidget;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart' show WidgetConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/home/shared/constants/widget_constants.dart' show HomeWidgetConstants;

/// A side-by-side pair of summary cards showing weekly and monthly expense totals.
///
/// Displays zero-value placeholders when [isInError] is true.
@immutable
class MaxiPocketHomeSummaryCardsWidget extends StatelessWidget {
  const MaxiPocketHomeSummaryCardsWidget({
    required this.themeMode,
    required this.isInError,
    required this.monthlyAmount,
    required this.weeklyAmount,
    super.key,
  });

  /// Controls the colour palette applied to both summary cards.
  final MaxiPocketThemeMode themeMode;

  /// When true, both cards show a `0.00 €` placeholder instead of real totals.
  final bool isInError;

  /// Sum of all expenses due within the current calendar month.
  final double monthlyAmount;

  /// Sum of all expenses due within the next seven days.
  final double weeklyAmount;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: MaxiPocketSummaryCardWidget(
            themeMode: themeMode,
            label: HomeWidgetConstants.weeklyCardTitle,
            amount: isInError
                ? '${HomeWidgetConstants.weeklyCardAmountErrorPlaceholder} ${WidgetConstants.currencySymbol}'
                : '${weeklyAmount.toStringAsFixed(2)} ${WidgetConstants.currencySymbol}',
            subtitle: HomeWidgetConstants.weeklyCardSubtitle,
            iconData: Icons.calendar_today_outlined,
          ),
        ),
        const SizedBox(width: DesignConstants.spacing16),
        Expanded(
          child: MaxiPocketSummaryCardWidget(
            themeMode: themeMode,
            label: HomeWidgetConstants.monthlyCardTitle,
            amount: isInError
                ? '${HomeWidgetConstants.weeklyCardAmountErrorPlaceholder} ${WidgetConstants.currencySymbol}'
                : '${monthlyAmount.toStringAsFixed(2)} ${WidgetConstants.currencySymbol}',
            subtitle: HomeWidgetConstants.monthlyCardSubtitle,
            iconData: Icons.calendar_month_outlined,
            colorsGradient: const <Color>[ThemeLightColors.tertiaryColor, ThemeLightColors.cardGradientColor1],
          ),
        ),
      ],
    );
  }
}
