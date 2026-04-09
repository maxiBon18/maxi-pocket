import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors, ThemeDarkColors;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/core/shared/utils/extensions.dart';
import 'package:maxi_pocket/core/shared/utils/methods.dart' show getShadowsColor;

/// Summary card with an icon + label header, a large amount, and a subtitle.
///
/// Renders over a [LinearGradient] background with a drop shadow. Use for
/// period summaries (e.g. weekly, monthly totals). The gradient defaults to
/// the app primary pink tokens; pass a custom [colorsGradient] to override.
@immutable
class MaxiPocketSummaryCardWidget extends StatelessWidget {
  const MaxiPocketSummaryCardWidget({
    super.key,
    required this.themeMode,
    required this.label,
    required this.amount,
    required this.subtitle,
    required this.iconData,
    this.colorsGradient = _defaultGradient,
  });

  static const List<Color> _defaultGradient = <Color>[ThemeLightColors.primaryColor, ThemeDarkColors.primaryDarkColor];

  final MaxiPocketThemeMode themeMode;
  final String label;
  final String amount;
  final String subtitle;
  final IconData iconData;
  final List<Color> colorsGradient;

  List<BoxShadow> _getBoxShadows() {
    final Color shadowColor = getShadowsColor(themeMode).withValues(alpha: DesignConstants.cardShadowOpacity);
    return <BoxShadow>[
      BoxShadow(
        offset: DesignConstants.cardOffsetFirst,
        blurRadius: DesignConstants.cardBlurRadiusFirst,
        spreadRadius: DesignConstants.cardSpreadRadiusFirst,
        color: shadowColor,
      ),
      BoxShadow(
        offset: DesignConstants.cardOffsetSecond,
        blurRadius: DesignConstants.cardBlurRadiusSecond,
        spreadRadius: DesignConstants.cardSpreadRadiusSecond,
        color: shadowColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(DesignConstants.radius16);
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: borderRadius, boxShadow: _getBoxShadows()),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colorsGradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: _SummaryCardContent(label: label, amount: amount, subtitle: subtitle, iconData: iconData),
        ),
      ),
    );
  }
}

@immutable
class _SummaryCardContent extends StatelessWidget {
  const _SummaryCardContent({
    required this.label,
    required this.amount,
    required this.subtitle,
    required this.iconData,
  });

  final String label;
  final String amount;
  final String subtitle;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DesignConstants.spacing16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SummaryCardHeader(iconData: iconData, label: label),
          const SizedBox(height: DesignConstants.spacing8),
          Text(
            amount,
            style: context.textTheme.headlineLarge?.copyWith(
              color: ThemeDarkColors.backgroundColor,
              fontWeight: FontWeight.w700,
              fontSize: DesignConstants.textSize24,
            ),
          ),
          const SizedBox(height: DesignConstants.spacing4),
          Text(subtitle, style: context.textTheme.bodySmall?.copyWith(color: ThemeDarkColors.backgroundColor)),
        ],
      ),
    );
  }
}

@immutable
class _SummaryCardHeader extends StatelessWidget {
  const _SummaryCardHeader({required this.iconData, required this.label});

  final IconData iconData;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData, color: ThemeDarkColors.backgroundColor, size: DesignConstants.icon16, applyTextScaling: false),
        const SizedBox(width: DesignConstants.spacing8),
        Text(label, style: context.textTheme.labelMedium?.copyWith(color: ThemeDarkColors.backgroundColor)),
      ],
    );
  }
}
