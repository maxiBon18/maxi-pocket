import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart'
    show ThemeLightColors, ThemeDarkColors, ThemeTextStyles;
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/bullet_point_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/icon_container_widget.dart'
    show MaxiPocketIconContainerWidget;
import 'package:maxi_pocket/core/presentation/ux/widgets/list_tile_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/switch_widget.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart'
    show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketThemeMode;
import 'package:maxi_pocket/core/shared/utils/extensions.dart';
import 'package:maxi_pocket/core/shared/utils/methods.dart'
    show getListTileBorderColor, getShadowsColor;
import 'package:maxi_pocket/routes.dart' show Routes;
import 'package:maxi_pocket/settings/shared/constants/widget_constants.dart'
    show SettingsWidgetConstants;

class MaxiPocketNotificationsPage extends ConsumerWidget {
  const MaxiPocketNotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double responsiveIconSize = screenHeight.responsiveHeight(
      DesignConstants.containerSize80,
    );

    return MaxiPocketPage(
      routeName: Routes.notificationsSettingsRoute,
      showAppBar: true,
      extendBodyBehindAppBar: false,
      allowBack: true,
      title: Text(SettingsWidgetConstants.notificationsPageTitle),
      showBottomBar: true,
      showLeading: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignConstants.spacing16,
          vertical: DesignConstants.spacing24,
        ),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .center,
          children: [
            _NotificationsHeaderWidget(
              themeMode: themeMode,
              responsiveIconSize: responsiveIconSize,
            ),
            const SizedBox(height: DesignConstants.spacing16),
            _NotificationsToggleTileWidget(themeMode: themeMode),
            const SizedBox(height: DesignConstants.spacing32),
            _NotificationsInfoContainerWidget(themeMode: themeMode),
          ],
        ),
      ),
    );
  }
}

class _NotificationsHeaderWidget extends StatelessWidget {
  const _NotificationsHeaderWidget({
    required this.themeMode,
    required this.responsiveIconSize,
  });

  final MaxiPocketThemeMode themeMode;
  final double responsiveIconSize;

  @override
  Widget build(BuildContext context) {
    final Color colorBackground = themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.primarySurfaceColor
        : ThemeDarkColors.listTileBorderColor;

    return MaxiPocketIconContainerWidget(
      colorBackground: colorBackground,
      height: responsiveIconSize,
      width: responsiveIconSize,
      useBorderRadius: false,
      shape: BoxShape.circle,
      child: Icon(
        Icons.notifications_outlined,
        color: ThemeDarkColors.primaryColor,
        size: DesignConstants.icon40,
        applyTextScaling: false,
      ),
    );
  }
}

class _NotificationsToggleTileWidget extends StatelessWidget {
  const _NotificationsToggleTileWidget({required this.themeMode});

  final MaxiPocketThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyleSubtitle = themeMode == MaxiPocketThemeMode.light
        ? ThemeTextStyles.appLightTextTheme.titleSmall!.copyWith(
            color: ThemeLightColors.textSecondaryColor,
          )
        : ThemeTextStyles.appDarkTextTheme.titleSmall!.copyWith(
            color: ThemeDarkColors.textSecondaryColor,
          );

    return MaxiPocketListTileWidget(
      title: Text(
        SettingsWidgetConstants.enableNotificationsTitle,
        textAlign: .start,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Text(
        SettingsWidgetConstants.enableNotificationsSubtitle,
        textAlign: .start,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: textStyleSubtitle,
      ),
      // TODO: Wire to notification provider when implemented
      trailing: MaxiPocketSwitchWidget(value: false, onChanged: null),
      themeMode: themeMode,
    );
  }
}

class _NotificationsInfoContainerWidget extends StatelessWidget {
  const _NotificationsInfoContainerWidget({required this.themeMode});

  final MaxiPocketThemeMode themeMode;

  List<BoxShadow> _getBoxShadows() => [
    BoxShadow(
      offset: DesignConstants.listTileOffset,
      blurRadius: DesignConstants.listTileBlurRadiusFirst,
      blurStyle: BlurStyle.outer,
      color: getShadowsColor(
        themeMode,
      ).withValues(alpha: DesignConstants.listTileShadowOpacity),
      spreadRadius: DesignConstants.listTileSpreadRadiusFirst,
    ),
    BoxShadow(
      offset: DesignConstants.listTileOffset,
      blurRadius: DesignConstants.listTileBlurRadiusSecond,
      blurStyle: BlurStyle.outer,
      color: getShadowsColor(
        themeMode,
      ).withValues(alpha: DesignConstants.listTileShadowOpacity),
      spreadRadius: DesignConstants.listTileSpreadRadiusSecond,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Color titleTextColor = themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.textOnSurfaceColor
        : ThemeDarkColors.textOnSurfaceColor;

    return Container(
      decoration: BoxDecoration(
        boxShadow: _getBoxShadows(),
        borderRadius: BorderRadiusGeometry.circular(DesignConstants.radius16),
        border: Border.all(
          color: getListTileBorderColor(themeMode),
          width: DesignConstants.bottomBarBorderWidth,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: DesignConstants.spacing16,
        vertical: DesignConstants.spacing24,
      ),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: [
          Text(
            SettingsWidgetConstants.notificationsTypeSectionTitle,
            style: context.textTheme.titleMedium!.copyWith(
              fontSize: DesignConstants.textSize16,
              color: titleTextColor,
            ),
          ),
          const SizedBox(height: DesignConstants.spacing12),
          Row(
            spacing: DesignConstants.spacing8,
            crossAxisAlignment: .center,
            children: [
              MaxiPocketBulletPointWidget(color: ThemeLightColors.primaryColor),
              Text(
                SettingsWidgetConstants.notificationsTypeTitle,
                style: context.textTheme.titleSmall,
              ),
            ],
          ),
          Row(
            spacing: DesignConstants.spacing8,
            children: [
              SizedBox(width: DesignConstants.spacing8),
              Flexible(
                child: Text(
                  SettingsWidgetConstants.notificationsTypeSubtitle,
                  style: context.textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
