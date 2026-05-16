import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart'
    show ThemeLightColors, ThemeDarkColors, ThemeTextStyles;
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/bullet_point_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/dialog_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/icon_container_widget.dart'
    show MaxiPocketIconContainerWidget;
import 'package:maxi_pocket/core/presentation/ux/widgets/list_tile_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/switch_widget.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/loading_viewmodel.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart'
    show DesignConstants;
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart'
    show WidgetConstants;
import 'package:maxi_pocket/core/shared/controllers/di.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketThemeMode, MaxiPocketDialogType;
import 'package:maxi_pocket/core/shared/utils/extensions.dart';
import 'package:maxi_pocket/core/shared/utils/methods.dart'
    show getListTileBorderColor, getShadowsColor;
import 'package:maxi_pocket/notifications/presentation/viewmodel/notification_viewmodel.dart';
import 'package:maxi_pocket/routes.dart' show Routes;
import 'package:maxi_pocket/settings/shared/constants/widget_constants.dart'
    show SettingsWidgetConstants;

/// Settings page for managing notification preferences, including the enable/disable toggle
/// and a description of the notification type currently supported.
class MaxiPocketNotificationsPage extends ConsumerWidget {
  const MaxiPocketNotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    final bool isEnabled = ref.watch(notificationProvider);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double responsiveIconSize = screenHeight.responsiveHeight(
      DesignConstants.containerSize80,
    );

    return MaxiPocketPage(
      routeName: Routes.notificationsSettingsRoute,
      showAppBar: true,
      extendBodyBehindAppBar: false,
      allowBack: true,
      title: const Text(SettingsWidgetConstants.notificationsPageTitle),
      showBottomBar: true,
      showLeading: true,
      onResumed: () async {
        if (!ref.read(notificationProvider.notifier).isFromSettings) {
          return;
        }
        getDI<Logger>().d('Set enabled notifications on resume');
        getDI<LoadingViewmodel>().showLoading(context: context);
        await ref.read(notificationProvider.notifier).setEnabled(true);
        getDI<LoadingViewmodel>().hideLoading();
      },

      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignConstants.spacing16,
          vertical: DesignConstants.spacing24,
        ),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .center,
          children: <Widget>[
            _NotificationsHeaderWidget(
              themeMode: themeMode,
              responsiveIconSize: responsiveIconSize,
            ),
            const SizedBox(height: DesignConstants.spacing16),
            _NotificationsToggleTileWidget(
              themeMode: themeMode,
              isEnabled: isEnabled,
            ),
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
      child: const Icon(
        Icons.notifications_outlined,
        color: ThemeDarkColors.primaryColor,
        size: DesignConstants.icon40,
        applyTextScaling: false,
      ),
    );
  }
}

class _NotificationsToggleTileWidget extends ConsumerWidget {
  const _NotificationsToggleTileWidget({
    required this.themeMode,
    required this.isEnabled,
  });

  final MaxiPocketThemeMode themeMode;
  final bool isEnabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextStyle textStyleSubtitle = themeMode == MaxiPocketThemeMode.light
        ? ThemeTextStyles.appLightTextTheme.titleSmall?.copyWith(
                color: ThemeLightColors.textSecondaryColor,
              ) ??
              const TextStyle()
        : ThemeTextStyles.appDarkTextTheme.titleSmall?.copyWith(
                color: ThemeDarkColors.textSecondaryColor,
              ) ??
              const TextStyle();

    return MaxiPocketListTileWidget(
      height: DesignConstants.containerSize85,
      title: const Text(
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
      trailing: MaxiPocketSwitchWidget(
        value: isEnabled,
        onChanged: (bool value) async {
          getDI<LoadingViewmodel>().showLoading(context: context);
          final bool successSetNotification = await ref
              .read(notificationProvider.notifier)
              .setEnabled(value);
          getDI<LoadingViewmodel>().hideLoading();

          if (ref.read(notificationProvider.notifier).isDenied) {
            await ref.read(notificationProvider.notifier).openSettings();
            return;
          }

          if (context.mounted) {
            if (!successSetNotification) {
              await showAlertDialog(
                context: context,
                barrierColor: themeMode == MaxiPocketThemeMode.light
                    ? ThemeLightColors.onSurfaceColor.withValues(alpha: 0.7)
                    : ThemeDarkColors.onSurfaceColor.withValues(alpha: 0.7),
                title: SettingsWidgetConstants.enableNotificationsErrorTitle,
                subtitle:
                    SettingsWidgetConstants.enableNotificationsErrorSubtitle,
                confirmButtonText: WidgetConstants.buttonOk,
                themeMode: themeMode,
                dialogType: MaxiPocketDialogType.error,
                onConfirm: () {
                  ref.invalidate(notificationProvider);
                  Navigator.of(context).pop();
                },
              );
            }
          }
        },
      ),
      themeMode: themeMode,
    );
  }
}

class _NotificationsInfoContainerWidget extends StatelessWidget {
  _NotificationsInfoContainerWidget({required this.themeMode})
    : boxShadows = <BoxShadow>[
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

  final MaxiPocketThemeMode themeMode;
  final List<BoxShadow> boxShadows;

  @override
  Widget build(BuildContext context) {
    final Color titleTextColor = themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.textOnSurfaceColor
        : ThemeDarkColors.textOnSurfaceColor;

    return Container(
      decoration: BoxDecoration(
        boxShadow: boxShadows,
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
        children: <Widget>[
          Text(
            SettingsWidgetConstants.notificationsTypeSectionTitle,
            style:
                context.textTheme.titleMedium?.copyWith(
                  fontSize: DesignConstants.textSize16,
                  color: titleTextColor,
                ) ??
                const TextStyle(),
          ),
          const SizedBox(height: DesignConstants.spacing12),
          Row(
            spacing: DesignConstants.spacing8,
            crossAxisAlignment: .center,
            children: <Widget>[
              const MaxiPocketBulletPointWidget(
                color: ThemeLightColors.primaryColor,
              ),
              Text(
                SettingsWidgetConstants.notificationsTypeTitle,
                style: context.textTheme.titleSmall,
              ),
            ],
          ),
          Row(
            spacing: DesignConstants.spacing8,
            children: <Widget>[
              const SizedBox(width: DesignConstants.spacing8),
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
