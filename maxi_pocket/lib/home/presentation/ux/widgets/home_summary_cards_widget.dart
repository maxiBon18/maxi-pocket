import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors;
import 'package:maxi_pocket/core/presentation/ux/widgets/card_widget.dart' show MaxiPocketSummaryCardWidget;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/home/shared/constants/widget_constants.dart' show HomeWidgetConstants;

@immutable
class MaxiPocketHomeSummaryCardsWidget extends StatelessWidget {
  const MaxiPocketHomeSummaryCardsWidget({required this.themeMode, super.key});

  final MaxiPocketThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: MaxiPocketSummaryCardWidget(
            themeMode: themeMode,
            label: HomeWidgetConstants.weeklyCardTitle,
            amount: HomeWidgetConstants.weeklyCardAmountPlaceholder,
            subtitle: HomeWidgetConstants.weeklyCardSubtitle,
            iconData: Icons.calendar_today_outlined,
          ),
        ),
        const SizedBox(width: DesignConstants.spacing16),
        Expanded(
          child: MaxiPocketSummaryCardWidget(
            themeMode: themeMode,
            label: HomeWidgetConstants.monthlyCardTitle,
            amount: HomeWidgetConstants.monthlyCardAmountPlaceholder,
            subtitle: HomeWidgetConstants.monthlyCardSubtitle,
            iconData: Icons.calendar_month_outlined,
            colorsGradient: const <Color>[ThemeLightColors.tertiaryColor, ThemeLightColors.cardGradientColor1],
          ),
        ),
      ],
    );
  }
}
