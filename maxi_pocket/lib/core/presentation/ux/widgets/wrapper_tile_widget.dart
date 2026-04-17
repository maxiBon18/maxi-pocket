import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeDarkColors, ThemeLightColors, ThemeTextStyles;
import 'package:maxi_pocket/core/presentation/ux/widgets/badge_widget.dart' show MaxiPocketBadgeWidget;
import 'package:maxi_pocket/core/presentation/ux/widgets/list_tile_widget.dart' show MaxiPocketListTileWidget;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart' show WidgetConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketExpensesType, MaxiPocketThemeMode;
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show BuildContextExtension;

/// A list tile displaying an expense or appointment item with edit and delete actions.
///
/// [isAppointment] hides the monetary amount and switches badge and date
/// labels to their appointment equivalents. Placeholder data is used until
/// a ViewModel is connected.
@immutable
class MaxiPocketWrapperTileWidget extends StatelessWidget {
  const MaxiPocketWrapperTileWidget({super.key, required this.themeMode, this.isAppointment = false});

  final MaxiPocketThemeMode themeMode;
  final bool isAppointment;

  Color get _iconColor =>
      themeMode == MaxiPocketThemeMode.light ? ThemeLightColors.textSecondaryColor : ThemeDarkColors.backgroundColor;

  Color get _amountColor =>
      themeMode == MaxiPocketThemeMode.light ? ThemeLightColors.onSurfaceColor : ThemeDarkColors.backgroundColor;

  @override
  Widget build(BuildContext context) {
    return MaxiPocketListTileWidget(
      title: Text(WidgetConstants.expenseTitlePlaceholder),
      subtitle: _ExpenseTileSubtitle(iconColor: _iconColor, isAppointment: isAppointment),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isAppointment == false)
            Text(
              WidgetConstants.expenseAmountPlaceholder.toStringAsFixed(2),
              style: ThemeTextStyles.monetaryAmountSmallLight.copyWith(color: _amountColor),
            ),
          if (isAppointment == false) const SizedBox(height: DesignConstants.spacing8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.edit_outlined,
                  color: _iconColor,
                  size: DesignConstants.icon24,
                  applyTextScaling: false,
                ),
              ),
              const SizedBox(width: DesignConstants.spacing12),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.delete_outlined,
                  color: _iconColor,
                  size: DesignConstants.icon24,
                  applyTextScaling: false,
                ),
              ),
            ],
          ),
        ],
      ),
      isThreeLine: true,
      themeMode: themeMode,
    );
  }
}

@immutable
class _ExpenseTileSubtitle extends StatelessWidget {
  const _ExpenseTileSubtitle({required this.iconColor, required this.isAppointment});

  final Color iconColor;
  final bool isAppointment;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: DesignConstants.spacing12,
      children: [
        Row(
          children: [
            MaxiPocketBadgeWidget(
              label: isAppointment ? WidgetConstants.appointmentType : WidgetConstants.expenseTypePlaceholder,
              expensesType: isAppointment ? MaxiPocketExpensesType.appointments : MaxiPocketExpensesType.subscription,
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
                isAppointment ? WidgetConstants.nextAppointment : WidgetConstants.nextExpenses,
                style: context.textTheme.bodyMedium?.copyWith(fontSize: DesignConstants.textSize12),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
