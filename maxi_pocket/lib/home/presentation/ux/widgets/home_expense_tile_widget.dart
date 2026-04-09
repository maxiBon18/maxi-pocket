import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeDarkColors, ThemeLightColors;
import 'package:maxi_pocket/core/presentation/ux/widgets/badge_widget.dart' show MaxiPocketBadgeWidget;
import 'package:maxi_pocket/core/presentation/ux/widgets/list_tile_widget.dart' show MaxiPocketListTileWidget;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketExpensesType, MaxiPocketThemeMode;
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show BuildContextExtension;
import 'package:maxi_pocket/home/shared/constants/widget_constants.dart' show HomeWidgetConstants;

@immutable
class MaxiPocketHomeExpenseTileWidget extends StatelessWidget {
  const MaxiPocketHomeExpenseTileWidget({super.key, required this.themeMode});

  final MaxiPocketThemeMode themeMode;

  Color get _iconColor => themeMode == MaxiPocketThemeMode.light
      ? ThemeLightColors.textSecondaryColor
      : ThemeDarkColors.backgroundColor;

  Color get _amountColor => themeMode == MaxiPocketThemeMode.light
      ? ThemeLightColors.onSurfaceColor
      : ThemeDarkColors.backgroundColor;

  @override
  Widget build(BuildContext context) {
    return MaxiPocketListTileWidget(
      title: Text(HomeWidgetConstants.expenseTitlePlaceholder),
      subtitle: _ExpenseTileSubtitle(iconColor: _iconColor),
      trailing: Text(
        HomeWidgetConstants.expenseAmountPlaceholder,
        style: context.textTheme.headlineLarge?.copyWith(
          color: _amountColor,
          fontWeight: FontWeight.w700,
          fontSize: DesignConstants.textSize18,
        ),
      ),
      isThreeLine: true,
      themeMode: themeMode,
    );
  }
}

@immutable
class _ExpenseTileSubtitle extends StatelessWidget {
  const _ExpenseTileSubtitle({required this.iconColor});

  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: DesignConstants.spacing12,
      children: [
        Row(
          children: [
            MaxiPocketBadgeWidget(
              label: HomeWidgetConstants.expenseTypePlaceholder,
              expensesType: MaxiPocketExpensesType.subscription,
            ),
            const Spacer(),
          ],
        ),
        Row(
          spacing: DesignConstants.spacing4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              color: iconColor,
              size: DesignConstants.icon16,
              applyTextScaling: false,
            ),
            Flexible(
              child: Text(
                HomeWidgetConstants.nextExpenses,
                style: context.textTheme.bodyMedium?.copyWith(fontSize: DesignConstants.textSize12),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
