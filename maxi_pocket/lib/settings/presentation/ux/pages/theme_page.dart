import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart'
    show ThemeLightColors, ThemeDarkColors, ThemeTextStyles;
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
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
import 'package:maxi_pocket/routes.dart' show Routes;
import 'package:maxi_pocket/settings/shared/constants/widget_constants.dart'
    show SettingsWidgetConstants;

/// Settings page that lets the user switch between light and dark app themes.
class MaxiPocketThemePage extends ConsumerWidget {
  const MaxiPocketThemePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double responsiveIconSize = screenHeight.responsiveHeight(
      DesignConstants.containerSize80,
    );

    return MaxiPocketPage(
      routeName: Routes.themeRoute,
      showAppBar: true,
      extendBodyBehindAppBar: false,
      allowBack: true,
      title: const Text(SettingsWidgetConstants.themePageTitle),
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
          children: <Widget>[
            _ThemeHeaderWidget(
              themeMode: themeMode,
              responsiveIconSize: responsiveIconSize,
            ),
            const SizedBox(height: DesignConstants.spacing16),
            _ThemeSwitchTileWidget(themeMode: themeMode),
          ],
        ),
      ),
    );
  }
}

class _ThemeHeaderWidget extends StatelessWidget {
  const _ThemeHeaderWidget({
    required this.themeMode,
    required this.responsiveIconSize,
  });

  final MaxiPocketThemeMode themeMode;
  final double responsiveIconSize;

  @override
  Widget build(BuildContext context) {
    final Color colorBackground = themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.changeThemeIconColor
        : ThemeDarkColors.listTileBorderColor;

    return MaxiPocketIconContainerWidget(
      colorBackground: colorBackground,
      height: responsiveIconSize,
      width: responsiveIconSize,
      useBorderRadius: false,
      shape: BoxShape.circle,
      child: const Icon(
        Icons.dark_mode_outlined,
        color: ThemeDarkColors.changeThemeIconColor,
        size: DesignConstants.icon40,
        applyTextScaling: false,
      ),
    );
  }
}

class _ThemeSwitchTileWidget extends ConsumerWidget {
  const _ThemeSwitchTileWidget({required this.themeMode});

  final MaxiPocketThemeMode themeMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = themeMode == MaxiPocketThemeMode.dark;
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
        SettingsWidgetConstants.darkModeTitle,
        textAlign: .start,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Text(
        SettingsWidgetConstants.darkModeSubtitle,
        textAlign: .start,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: textStyleSubtitle,
      ),
      trailing: MaxiPocketSwitchWidget(
        value: isDarkMode,
        onChanged: (bool? value) {
          if (value != null) {
            ref
                .read(themeProvider.notifier)
                .setThemeMode(
                  value ? MaxiPocketThemeMode.dark : MaxiPocketThemeMode.light,
                );
          }
        },
      ),
      themeMode: themeMode,
    );
  }
}
