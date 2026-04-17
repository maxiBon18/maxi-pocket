import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors, ThemeDarkColors;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;

/// An icon that adapts its color to the current theme mode.
///
/// Intended for use as a leading or trailing element inside list tiles.
/// Pass [colorIcon] to override the default theme-derived tint.
class MaxiPocketLeadingTrailingIconWidget extends StatelessWidget {
  const MaxiPocketLeadingTrailingIconWidget({super.key, required this.themeMode, required this.icon, this.colorIcon});

  final MaxiPocketThemeMode themeMode;
  final IconData icon;
  final Color? colorIcon;

  @override
  Widget build(BuildContext context) {
    final Color colorIconTrailing =
        colorIcon ??
        (themeMode == MaxiPocketThemeMode.light
            ? ThemeLightColors.onSurfaceVariantColor
            : ThemeDarkColors.tertiaryColor);
    return Icon(icon, color: colorIconTrailing, size: DesignConstants.icon24, applyTextScaling: false);
  }
}
