import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeDarkColors, ThemeLightColors, ThemeTextStyles;
import 'package:maxi_pocket/core/presentation/ux/widgets/badge_widget.dart' show MaxiPocketBadgeWidget;
import 'package:maxi_pocket/core/presentation/ux/widgets/list_tile_widget.dart' show MaxiPocketListTileWidget;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart' show WidgetConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketExpensesType, MaxiPocketThemeMode, MaxiPocketExpensesFrequency;
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show BuildContextExtension;

/// A list tile displaying an expense or appointment item with edit and delete actions.
///
/// [isAppointment] hides the monetary amount and switches badge and date
/// labels to their appointment equivalents. Placeholder data is used until
/// a ViewModel is connected.
@immutable
class MaxiPocketWrapperTileWidget extends StatelessWidget {
  const MaxiPocketWrapperTileWidget({required this.themeMode, super.key, this.isAppointment = false});

  final MaxiPocketThemeMode themeMode;
  final bool isAppointment;

  Color get _iconColor => themeMode == MaxiPocketThemeMode.light
      ? ThemeLightColors.textSecondaryColor
      : ThemeDarkColors.onSurfaceVariantColor;

  Color get _amountColor => themeMode == MaxiPocketThemeMode.light
      ? ThemeLightColors.onSurfaceColor
      : ThemeDarkColors.onSurfaceColor;

  @override
  Widget build(BuildContext context) {
    return MaxiPocketListTileWidget(
      title: const Text(WidgetConstants.expenseTitlePlaceholder),
      subtitle: _ExpenseTileSubtitle(iconColor: _iconColor, isAppointment: isAppointment, themeMode: themeMode),
      trailing: _MaxiPocketTileTrailing(
        isAppointment: isAppointment,
        iconColor: _iconColor,
        amountColor: _amountColor,
      ),
      isThreeLine: true,
      themeMode: themeMode,
    );
  }
}

/// Trailing column showing the formatted amount and edit/delete icon buttons.
///
/// The amount row is hidden when [isAppointment] is true.
@immutable
class _MaxiPocketTileTrailing extends StatelessWidget {
  const _MaxiPocketTileTrailing({
    required this.isAppointment,
    required this.iconColor,
    required this.amountColor,
  });

  final bool isAppointment;
  final Color iconColor;
  final Color amountColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        if (!isAppointment)
          Text(
            WidgetConstants.expenseAmountPlaceholder.toStringAsFixed(2),
            style: ThemeTextStyles.monetaryAmountSmallLight.copyWith(color: amountColor),
          ),
        if (!isAppointment) const SizedBox(height: DesignConstants.spacing8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Icon(Icons.edit_outlined, color: iconColor, size: DesignConstants.icon24, applyTextScaling: false),
            ),
            const SizedBox(width: DesignConstants.spacing12),
            GestureDetector(
              onTap: () {},
              child: Icon(Icons.delete_outlined, color: iconColor, size: DesignConstants.icon24, applyTextScaling: false),
            ),
          ],
        ),
      ],
    );
  }
}

/// Subtitle showing type and frequency badges above the next-payment or next-appointment date.
@immutable
class _ExpenseTileSubtitle extends StatelessWidget {
  const _ExpenseTileSubtitle({required this.iconColor, required this.isAppointment, required this.themeMode});

  final Color iconColor;
  final bool isAppointment;
  final MaxiPocketThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: DesignConstants.spacing12,
      children: <Widget>[
        Row(
          children: <Widget>[
            MaxiPocketBadgeWidget(
              label: isAppointment ? WidgetConstants.appointmentType : WidgetConstants.expenseTypePlaceholder,
              expensesType: isAppointment ? MaxiPocketExpensesType.appointments : MaxiPocketExpensesType.subscription,
              themeMode: themeMode,
            ),
            if (!isAppointment) const SizedBox(width: DesignConstants.spacing4),
            if (!isAppointment)
              MaxiPocketBadgeWidget(
                label: WidgetConstants.addExpensesFrequencyMonthly,
                expensesFrequency: MaxiPocketExpensesFrequency.monthly,
                themeMode: themeMode,
              ),
            const Spacer(),
          ],
        ),
        _ExpenseTileDateRow(iconColor: iconColor, isAppointment: isAppointment),
      ],
    );
  }
}

@immutable
class _ExpenseTileDateRow extends StatelessWidget {
  const _ExpenseTileDateRow({required this.iconColor, required this.isAppointment});

  final Color iconColor;
  final bool isAppointment;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: DesignConstants.spacing4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
    );
  }
}
