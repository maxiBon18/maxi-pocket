import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart'
    show ThemeDarkColors, ThemeLightColors;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketThemeMode;
import 'package:maxi_pocket/core/shared/utils/extensions.dart';

/// App bar title widget that renders a centred headline with an optional subtitle below it.
class MaxiPocketAppBarTitle extends StatelessWidget {
  const MaxiPocketAppBarTitle({
    required this.title,
    required this.themeMode,
    super.key,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final MaxiPocketThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: .center,
      mainAxisAlignment: .center,
      spacing: DesignConstants.spacing4,
      children: <Widget>[
        Text(
          title,
          textAlign: .center,
          style: context.textTheme.headlineLarge!.copyWith(
            fontSize: DesignConstants.textSize24,
          ),
        ),
        if (subtitle != null)
          Text(
            subtitle!,
            textAlign: .center,
            style: context.textTheme.bodyMedium!.copyWith(
              color: themeMode == MaxiPocketThemeMode.light
                  ? ThemeLightColors.textSecondaryColor
                  : ThemeDarkColors.textSecondaryColor,
            ),
          ),
      ],
    );
  }
}
