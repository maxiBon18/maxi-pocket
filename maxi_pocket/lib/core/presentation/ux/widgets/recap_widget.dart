import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors, ThemeTextStyles, ThemeDarkColors;
import 'package:maxi_pocket/core/presentation/ux/widgets/bullet_point_widget.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart' show WidgetConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;

/// A summary row showing an active-item count label alongside a total amount.
///
/// [isAppointment] switches to appointment-specific labels and bullet color.
/// [amount] is formatted to two decimal places for expenses; appointments show no amount.
class MaxiPocketRecapWidget extends StatelessWidget {
  const MaxiPocketRecapWidget({
    required this.numberOfCommitments,
    required this.themeMode,
    super.key,
    this.amount,
    this.isAppointment = false,
  });

  final int numberOfCommitments;
  final double? amount;
  final bool isAppointment;
  final MaxiPocketThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: DesignConstants.spacing16, vertical: DesignConstants.spacing12),
      decoration: BoxDecoration(
        border: Border.all(
          color: themeMode == MaxiPocketThemeMode.dark
              ? ThemeLightColors.bottomNavigationBarTopBorderColor
              : ThemeDarkColors.listTileBorderColor,
          width: DesignConstants.bottomBarBorderWidth,
        ),
        borderRadius: BorderRadius.circular(DesignConstants.radius16),
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: <Widget>[
          Expanded(
            child: _RecapCountRow(
              isAppointment: isAppointment,
              numberOfCommitments: numberOfCommitments,
              themeMode: themeMode,
            ),
          ),
          if (!isAppointment)
            Expanded(
              child: _RecapAmountText(isAppointment: isAppointment, amount: amount, themeMode: themeMode),
            ),
        ],
      ),
    );
  }
}

class _RecapCountRow extends StatelessWidget {
  const _RecapCountRow({required this.isAppointment, required this.numberOfCommitments, required this.themeMode});

  final bool isAppointment;
  final int numberOfCommitments;
  final MaxiPocketThemeMode themeMode;

  Color get _textColor =>
      themeMode == MaxiPocketThemeMode.light ? ThemeLightColors.textPrimaryColor : ThemeDarkColors.backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: DesignConstants.spacing8,
      children: <Widget>[
        MaxiPocketBulletPointWidget(
          color: isAppointment ? ThemeDarkColors.appointmentsBulletPointColor : ThemeLightColors.primaryColor,
        ),
        Flexible(
          child: Text(
            isAppointment
                ? '${WidgetConstants.activeNumberAppointments} ${numberOfCommitments.toString()}'
                : '${WidgetConstants.activeNumberExpenses} ${numberOfCommitments.toString()}',
            style: ThemeTextStyles.appLightTextTheme.titleSmall?.copyWith(color: _textColor),
          ),
        ),
      ],
    );
  }
}

class _RecapAmountText extends StatelessWidget {
  const _RecapAmountText({required this.isAppointment, required this.amount, required this.themeMode});

  final bool isAppointment;
  final double? amount;
  final MaxiPocketThemeMode themeMode;

  Color get _textColor =>
      themeMode == MaxiPocketThemeMode.light ? ThemeLightColors.textPrimaryColor : ThemeDarkColors.backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      isAppointment ? '' : '${amount?.toStringAsFixed(2) ?? '0.00'} ${WidgetConstants.currencySymbol}',
      style:
          (themeMode == MaxiPocketThemeMode.light
                  ? ThemeTextStyles.monetaryAmountSmallLight
                  : ThemeTextStyles.monetaryAmountSmallDark)
              .copyWith(color: _textColor),
      textAlign: .end,
    );
  }
}
