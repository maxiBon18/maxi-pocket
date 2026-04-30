import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeDarkColors;
import 'package:maxi_pocket/core/presentation/ux/widgets/box_decoration_widget.dart' show MaxiPocketBoxDecorationWidget;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/core/shared/utils/extensions.dart';
import 'package:maxi_pocket/core/shared/utils/methods.dart' show getShadowsColor, getListTileBorderColor;

/// A styled list-tile card with rounded corners, a border, and a two-layer drop shadow.
///
/// Wraps Flutter's [ListTile] inside [MaxiPocketBoxDecorationWidget] so every tile
/// in the app shares consistent elevation and border appearance. The shadow color
/// adapts to [themeMode] so it remains visible against both light and dark scaffolds.
class MaxiPocketListTileWidget extends StatelessWidget {
  const MaxiPocketListTileWidget({
    required this.title,
    required this.themeMode,
    super.key,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.height,
    this.isThreeLine = false,
  });

  final Widget title;
  final MaxiPocketThemeMode themeMode;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final double? height;
  final bool isThreeLine;

  List<BoxShadow> _getBoxShadows(MaxiPocketThemeMode themeMode) => <BoxShadow>[
    BoxShadow(
      offset: DesignConstants.listTileOffset,
      blurRadius: DesignConstants.listTileBlurRadiusFirst,
      blurStyle: BlurStyle.outer,
      color: getShadowsColor(themeMode).withValues(alpha: DesignConstants.listTileShadowOpacity),
      spreadRadius: DesignConstants.listTileSpreadRadiusFirst,
    ),
    BoxShadow(
      offset: DesignConstants.listTileOffset,
      blurRadius: DesignConstants.listTileBlurRadiusSecond,
      blurStyle: BlurStyle.outer,
      color: getShadowsColor(themeMode).withValues(alpha: DesignConstants.listTileShadowOpacity),
      spreadRadius: DesignConstants.listTileSpreadRadiusSecond,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenSize = MediaQuery.of(context).size.height;
    return MaxiPocketBoxDecorationWidget(
      themeMode: themeMode,
      boxShadows: _getBoxShadows(themeMode),
      borderRadius: BorderRadiusGeometry.circular(DesignConstants.radius16),
      border: Border.all(color: getListTileBorderColor(themeMode), width: DesignConstants.bottomBarBorderWidth),
      child: ListTile(
        minTileHeight: height != null ? screenSize.responsiveHeight(height!) : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: DesignConstants.spacing16,
          vertical: DesignConstants.spacing8,
        ),
        minVerticalPadding: DesignConstants.spacing8,
        titleAlignment: ListTileTitleAlignment.center,
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
        onTap: onTap,
        isThreeLine: isThreeLine,
        splashColor: ThemeDarkColors.primaryColor.withValues(alpha: DesignConstants.alpha20),
      ),
    );
  }
}
