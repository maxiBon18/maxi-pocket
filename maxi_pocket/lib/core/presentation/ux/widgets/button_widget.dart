import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show DoubleExtension, BuildContextExtension;

/// A full-width primary action button with responsive height.
///
/// Height scales with the screen via [responsiveHeight]. When [enabled] is
/// false the tap handler is removed and disabled color tokens are applied.
/// Default background and text colors adapt to [themeMode]; pass
/// [backgroundColor] or [textColor] to override them, and [textStyle] to
/// override the default label typography.
class MaxiPocketButtonWidget extends StatelessWidget {
  const MaxiPocketButtonWidget({
    required this.themeMode,
    super.key,
    this.onPressed,
    this.label,
    this.height,
    this.width,
    this.textStyle,
    this.enabled = true,
    this.backgroundColor,
    this.textColor,
  });

  final VoidCallback? onPressed;
  final String? label;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final bool enabled;
  final MaxiPocketThemeMode themeMode;
  final Color? backgroundColor;
  final Color? textColor;

  Color get _textColor {
    if (textColor != null) return textColor!;
    if (!enabled) {
      return themeMode == MaxiPocketThemeMode.light
          ? ThemeLightColors.textDisabledColor
          : ThemeDarkColors.textDisabledColor;
    }
    return themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.textOnPrimaryColor
        : ThemeDarkColors.textOnPrimaryColor;
  }

  Color get _backgroundColor =>
      backgroundColor ??
      (themeMode == MaxiPocketThemeMode.light ? ThemeLightColors.primaryColor : ThemeDarkColors.primaryDarkColor);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double buttonHeight = screenHeight.responsiveHeight(height ?? DesignConstants.minButtonHeight);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(DesignConstants.radius16),
        color: _backgroundColor,
      ),
      width: width,
      height: buttonHeight,
      child: FilledButton(
        onPressed: enabled ? onPressed : null,
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
          shadowColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
          enableFeedback: enabled,
          elevation: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return DesignConstants.elevation0;
            } else {
              return DesignConstants.elevation5;
            }
          }),
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: DesignConstants.spacing16, vertical: DesignConstants.spacing12),
          ),
          shape: const WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(DesignConstants.radius16))),
          ),
        ),
        child: Text(
          label ?? '',
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          maxLines: 1,
          style:
              textStyle ??
              context.textTheme.titleLarge?.copyWith(fontSize: DesignConstants.textSize16, color: _textColor),
        ),
      ),
    );
  }
}
