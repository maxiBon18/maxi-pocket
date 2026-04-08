/// Small platform helpers that do not belong in a specific feature.
library;

import 'dart:ui' show Brightness, PlatformDispatcher;

import 'package:flutter/material.dart' show Color;
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors, ThemeDarkColors;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;

/// Whether the current platform brightness is dark, from [PlatformDispatcher].
///
/// Used as a fallback when no theme preference is stored yet. This reflects the
/// system setting at read time; it does not listen for changes by itself.
bool get isDarkMode => PlatformDispatcher.instance.platformBrightness == Brightness.dark;

Color getShadowsColor(MaxiPocketThemeMode themeMode) => themeMode == MaxiPocketThemeMode.light
    ? ThemeLightColors.bottomNavigationBarShadowsColor
    : ThemeDarkColors.bottomNavigationBarShadowsColor;

Color getBottomBarBorderColor(MaxiPocketThemeMode themeMode) => themeMode == MaxiPocketThemeMode.light
    ? ThemeLightColors.bottomNavigationBarTopBorderColor
    : ThemeDarkColors.bottomNavigationBarTopBorderColor;

Color getListTileBorderColor(MaxiPocketThemeMode themeMode) =>
    themeMode == MaxiPocketThemeMode.light ? ThemeLightColors.surfaceVariantColor : ThemeDarkColors.listTileBorderColor;
