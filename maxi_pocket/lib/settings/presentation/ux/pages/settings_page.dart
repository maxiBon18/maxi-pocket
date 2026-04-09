import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/domain/entities/app_info.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors, ThemeDarkColors, ThemeTextStyles;
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/app_bar_title_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/icon_container_widget.dart' show MaxiPocketIconContainerWidget;
import 'package:maxi_pocket/core/presentation/ux/widgets/list_tile_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/overlay_loading_widget.dart' show MaxiPocketLoadingWidget;
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart' show themeProvider;
import 'package:maxi_pocket/core/shared/constants/app_constants.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/core/shared/utils/extensions.dart';
import 'package:maxi_pocket/routes.dart';
import 'package:maxi_pocket/settings/presentation/viewmodel/settings_viewmodel.dart';
import 'package:maxi_pocket/settings/shared/constants/widget_constants.dart' show SettingsWidgetConstants;

class MaxiPocketSettingsPage extends ConsumerWidget {
  const MaxiPocketSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    final AsyncValue<AppInfo> appInfo = ref.watch(appInfoProvider);

    return MaxiPocketPage(
      routeName: Routes.settingsRoute,
      showLeading: false,
      showBottomBar: true,
      showAppBar: true,
      title: MaxiPocketAppBarTitle(title: SettingsWidgetConstants.appBarTitle, themeMode: themeMode),
      child: appInfo.when(
        data: (AppInfo appInfo) => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignConstants.spacing16,
              vertical: DesignConstants.spacing12,
            ),
            child: Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .center,
              mainAxisSize: .max,
              children: [
                _SettingsListTilesWidget(themeMode: themeMode),
                const SizedBox(height: DesignConstants.spacing64),
                _SettingsFooterWidget(appInfo: appInfo),
              ],
            ),
          ),
        ),
        loading: () => const Center(child: MaxiPocketLoadingWidget()),
        // App info failure is non-critical (version display only), silent fallback is acceptable.
        error: (Object error, StackTrace stackTrace) => const SizedBox.shrink(),
      ),
    );
  }
}

class _SettingsListTilesWidget extends StatelessWidget {
  const _SettingsListTilesWidget({required this.themeMode});

  final MaxiPocketThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    final Color colorBackground = themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.primaryColor.withValues(alpha: DesignConstants.alpha10)
        : ThemeDarkColors.listTileBorderColor;
    final Color colorBackgroundChangeTheme = themeMode == MaxiPocketThemeMode.light
        ? ThemeDarkColors.changeThemeIconColor.withValues(alpha: DesignConstants.alpha10)
        : ThemeDarkColors.listTileBorderColor;
    final Color colorIconTrailing = themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.onSurfaceVariantColor
        : ThemeDarkColors.tertiaryColor;
    final TextStyle textStyleSubtitle = themeMode == MaxiPocketThemeMode.light
        ? ThemeTextStyles.appLightTextTheme.titleSmall!.copyWith(color: ThemeLightColors.textSecondaryColor)
        : ThemeTextStyles.appDarkTextTheme.titleSmall!.copyWith(color: ThemeDarkColors.textSecondaryColor);
    final Widget trailingWidget = Icon(
      Icons.arrow_forward_ios_outlined,
      color: colorIconTrailing,
      size: DesignConstants.icon24,
      applyTextScaling: false,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MaxiPocketListTileWidget(
          height: DesignConstants.containerSize85,
          title: Text(
            SettingsWidgetConstants.notificationsTitle,
            textAlign: .start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Text(
            SettingsWidgetConstants.notificationsSubtitle,
            textAlign: .start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: textStyleSubtitle,
          ),
          leading: MaxiPocketIconContainerWidget(
            colorBackground: colorBackground,
            child: Icon(
              Icons.notifications_outlined,
              color: ThemeLightColors.primaryColor,
              size: DesignConstants.icon24,
              applyTextScaling: false,
            ),
          ),
          trailing: trailingWidget,
          onTap: () => Navigator.pushNamed(context, Routes.notificationsSettingsRoute),
          themeMode: themeMode,
        ),
        const SizedBox(height: DesignConstants.spacing12),
        MaxiPocketListTileWidget(
          height: DesignConstants.containerSize85,
          title: Text(
            SettingsWidgetConstants.themeTitle,
            textAlign: .start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Text(
            SettingsWidgetConstants.themeSubtitle,
            textAlign: .start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: textStyleSubtitle,
          ),
          leading: MaxiPocketIconContainerWidget(
            colorBackground: colorBackgroundChangeTheme,
            child: Icon(
              Icons.dark_mode_outlined,
              color: ThemeDarkColors.changeThemeIconColor,
              size: DesignConstants.icon24,
              applyTextScaling: false,
            ),
          ),
          trailing: trailingWidget,
          onTap: () => Navigator.pushNamed(context, Routes.themeRoute),
          themeMode: themeMode,
        ),
      ],
    );
  }
}

class _SettingsFooterWidget extends StatelessWidget {
  const _SettingsFooterWidget({required this.appInfo});

  final AppInfo appInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(AppConstants.appName, style: context.textTheme.bodyMedium, overflow: TextOverflow.ellipsis, maxLines: 1),
        Text(
          '${AppConstants.versionTitle}: ${appInfo.version}+${appInfo.buildNumber}',
          style: context.textTheme.bodySmall,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
