import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors, ThemeTextStyles, ThemeDarkColors;
import 'package:maxi_pocket/core/presentation/ux/widgets/bullet_point_widget.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart' show WidgetConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;

/// A summary row showing an active-item count label alongside a total amount.
///
/// [isAppointment] switches to appointment-specific labels and bullet color.
/// [value] is formatted to two decimal places for expenses or rendered as a
/// plain integer for appointments.
class MaxiPocketRecapWidget extends StatelessWidget {
  const MaxiPocketRecapWidget({required this.value, required this.themeMode, super.key, this.isAppointment = false});

  final double value;
  final bool isAppointment;
  final MaxiPocketThemeMode themeMode;

  Color _getTextColor(MaxiPocketThemeMode themeMode) {
    return themeMode == MaxiPocketThemeMode.light ? ThemeLightColors.textPrimaryColor : ThemeDarkColors.backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: DesignConstants.spacing16, vertical: DesignConstants.spacing12),
      decoration: BoxDecoration(
        border: Border.all(
          color: themeMode == MaxiPocketThemeMode.light
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
            child: Row(
              spacing: DesignConstants.spacing8,
              children: <Widget>[
                MaxiPocketBulletPointWidget(
                  color: isAppointment ? ThemeDarkColors.appointmentsBulletPointColor : ThemeLightColors.primaryColor,
                ),
                Flexible(
                  child: Text(
                    isAppointment ? WidgetConstants.activeNumberAppointments : WidgetConstants.activeNumberExpenses,
                    style: ThemeTextStyles.appLightTextTheme.titleSmall?.copyWith(color: _getTextColor(themeMode)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              isAppointment ? value.toString() : '${value.toStringAsFixed(2)} ${WidgetConstants.currencySymbol}',
              style:
                  (themeMode == MaxiPocketThemeMode.light
                          ? ThemeTextStyles.monetaryAmountSmallLight
                          : ThemeTextStyles.monetaryAmountSmallDark)
                      .copyWith(color: _getTextColor(themeMode)),
              textAlign: .end,
            ),
          ),
        ],
      ),
    );
  }
}
