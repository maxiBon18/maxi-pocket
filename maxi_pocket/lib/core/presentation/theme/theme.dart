import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;

/// Font family name constants used as reference tokens across the design system.
class ThemeConstants {
  const ThemeConstants._();

  /// Body text and data labels use Inter.
  static const String interFontFamily = 'Inter';

  /// Headings and display text use Outfit.
  static const String outfitFontFamily = 'Outfit';

  /// Monetary amounts and numbers use JetBrains Mono for tabular alignment.
  static const String jetBrainsMonoFontFamily = 'JetBrainsMono';
}

/// Color tokens for the light theme.
///
/// Shared palette colors (primary, secondary, etc.) are duplicated in
/// [ThemeDarkColors] with the same value so each theme class is self-contained.
class ThemeLightColors {
  const ThemeLightColors._();

  /// Main CTA buttons, FAB, and active nav icons.
  static const Color primaryColor = Color(0xFFFFB3C1);

  /// Selected chips and subtle highlights.
  static const Color primaryLightColor = Color(0xFFFFD6E0);

  /// Card backgrounds and input fills in light mode.
  static const Color primarySurfaceColor = Color(0xFFFFF0F3);

  /// Income indicators, positive trends, and success states.
  static const Color secondaryColor = Color(0xFFA8D5BA);

  /// Positive amount text.
  static const Color secondaryDarkColor = Color(0xFF7BB894);

  /// Categories, chart segments, and tags.
  static const Color tertiaryColor = Color(0xFFC9B1D0);

  /// Warnings, budget alerts, and over-limit badges.
  static const Color accentColor = Color(0xFFF4A261);

  /// Expense amounts, negative trends, and validation errors.
  static const Color errorColor = Color(0xFFD64550);

  /// Primary text in light mode.
  static const Color onSurfaceColor = Color(0xFF2B2024);

  /// Secondary text in light mode.
  static const Color onSurfaceVariantColor = Color(0xFF5C4F53);

  /// Dividers and disabled fields in light mode.
  static const Color surfaceVariantColor = Color(0xFFF0E6E8);

  /// App scaffold background in light mode.
  static const Color backgroundColor = Color(0xFFFFFBFC);

  /// Bottom navigation bar background color.
  static const Color bottomNavigationBarBackgroundColor = Color(0xFFFFFFFF);

  /// Primary heading and data text in light mode.
  static const Color textPrimaryColor = Color(0xFF2B2024);

  /// Secondary and supporting text in light mode.
  static const Color textSecondaryColor = Color(0xFF5C4F53);

  /// Placeholder and disabled-state text in light mode.
  static const Color textDisabledColor = Color(0xFFA8A0AE);

  /// Text rendered on top of the primary colour (e.g. button labels).
  static const Color textOnPrimaryColor = Color(0xFF2B2024);

  /// Text rendered on surface-coloured backgrounds in light mode.
  static const Color textOnSurfaceColor = Color(0xFF2B2024);

  /// Text colour used when the surface is dark (e.g. tooltip text on dark overlays).
  static const Color textInverseColor = Color(0xFFF5F0EB);

  /// Accent colour applied to annual-frequency labels and amounts.
  static const Color textAnnualColor = Color(0xFFF59E0B);

  /// Accent colour applied to monthly-frequency labels and amounts.
  static const Color textMonthlyColor = Color(0xFF3B82F6);

  /// Top border separating the navigation bar from page content in light mode.
  static const Color bottomNavigationBarTopBorderColor = Color(0xFFF0E6EB);

  /// Drop-shadow colour for the navigation bar in light mode.
  static const Color bottomNavigationBarShadowsColor = Color(0xFF000000);

  /// Background colour of the theme-toggle icon container in light mode.
  static const Color changeThemeIconColor = Color(0xFFEDE4F0);

  /// Switch track color in the unchecked state.
  static const Color switchTrackColor = Color(0xFFE5E5E5);

  /// Gradient end colour used on expense-summary cards.
  static const Color cardGradientColor1 = Color(0xFFB399BA);

  /// Background fill for the financing-type badge chip.
  static const Color badgeFinancingBackgroundColor = Color(0xFFD6EFE0);

  /// Expenses Colors
  static const Color expensesSubscriptionIconBackgroundColor = Color(0xFFFFF0F3);
  static const Color expensesFinancingIconBackgroundColor = Color(0xFFF0F8F4);
  static const Color expensesAllIconBackgroundColor = Color(0xFFF7F3F8);
  static const Color expensesSubscriptionIconColor = Color(0xFFFFB3C1);
  static const Color expensesFinancingIconColor = Color(0xFFA8D5BA);
  static const Color expensesAllIconColor = Color(0xFFC9B1D0);
  static const Color expensesAnnualColor = Color(0xFFFFF4E8);
  static const Color expensesMonthlyColor = Color(0xFFE8F4FF);

  /// Appointments Colors
  static const Color appointmentsBulletPointColor = Color(0xFFFFD6A5);
  static const Color appointmentsBadgeBackgroundColor = Color(0xFFD7A567);

  /// Dialog Colors
  static const Color dialogErrorBackgroundColor = Color(0xFFD64550);
  static const Color dialogSuccessBackgroundColor = Color(0xFF7BB894);
  static const Color dialogInfoBackgroundColor = Color(0xFFF3E8FF);
  static const Color dialogCancelBackgroundColor = Color(0xFFF3F3F5);
  static const Color dialogBarrierColor = Color(0xFF000000);

  /// Onboarding Colors
  static const Color onboardingNotificationContainerBackgroundColor = Color(0xFFFFFFFF);

  /// Lightest stop of the onboarding hero gradient (top-left).
  static const Color onboardingGradientColor3 = Color(0xFFFFB3C1);

  /// Mid stop of the onboarding hero gradient.
  static const Color onboardinGradientColor2 = Color(0xFFF3A2B2);

  /// Darkest stop of the onboarding hero gradient (bottom-right).
  static const Color onboardingGradientColor1 = Color(0xFFE0899B);

  /// Ordered gradient stops used by the onboarding icon circle (dark → mid → light).
  static const List<Color> onboardingGradientColors = <Color>[
    onboardingGradientColor1,
    onboardinGradientColor2,
    onboardingGradientColor3,
  ];

  static const List<Color> onboardingBackgroundGradientColors = <Color>[
    onboardingGradientColor3,
    appointmentsBulletPointColor,
    onboardingNotificationContainerBackgroundColor,
  ];

  /// Background fill of the appointments info card on the onboarding page.
  static const Color onboardingAppointmentsContainerBackgroundColor = Color(0xFFFFF7E6);
}

/// Color tokens for the dark theme.
///
/// Shared palette colors (primary, secondary, etc.) are duplicated from
/// [ThemeLightColors] with the same value so each theme class is self-contained.
class ThemeDarkColors {
  const ThemeDarkColors._();

  /// Main CTA buttons, FAB, and active nav icons.
  static const Color primaryColor = Color(0xFFFFB3C1);

  /// Pressed states and active indicators.
  static const Color primaryDarkColor = Color(0xFFE0899B);

  /// Selected chip and card backgrounds in dark mode.
  static const Color primarySurfaceColor = Color(0xFF3D2030);

  /// Income indicators, positive trends, and success states.
  static const Color secondaryColor = Color(0xFFA8D5BA);

  /// Positive amount text.
  static const Color secondaryDarkColor = Color(0xFF7BB894);

  /// Categories, chart segments, and tags.
  static const Color tertiaryColor = Color(0xFFC9B1D0);

  /// Warnings, budget alerts, and over-limit badges.
  static const Color accentColor = Color(0xFFF4A261);

  /// Expense amounts, negative trends, and validation errors.
  static const Color errorColor = Color(0xFFD64550);

  /// Used for the switch thumb in dark mode.
  static const Color backgroundColor = Color(0xFFFFFBFC);

  /// App scaffold background in dark mode.
  static const Color scaffoldBackgroundColor = Color(0xFF1A1215);

  /// Card surface in dark mode.
  static const Color surfaceColor = Color(0xFF2B2024);

  /// Primary text in dark mode.
  static const Color onSurfaceColor = Color(0xFFF0E6E8);

  /// Secondary text in dark mode.
  static const Color onSurfaceVariantColor = Color(0xFFA89598);

  /// Dividers and disabled fields in dark mode.
  static const Color surfaceVariantColor = Color(0xFF3D2F33);

  /// Primary heading and data text in dark mode.
  static const Color textPrimaryColor = Color(0xFFF5F0EB);

  /// Secondary and supporting text in dark mode.
  static const Color textSecondaryColor = Color(0xFFC9B8C0);

  /// Placeholder and disabled-state text in dark mode.
  static const Color textDisabledColor = Color(0xFF6B5F72);

  /// Text rendered on top of the primary colour (e.g. button labels) in dark mode.
  static const Color textOnPrimaryColor = Color(0xFF2B2024);

  /// Text rendered on surface-coloured backgrounds in dark mode.
  static const Color textOnSurfaceColor = Color(0xFFF5F0EB);

  /// Text colour used when the surface is light (e.g. text on light overlays in dark mode).
  static const Color textInverseColor = Color(0xFF2B2024);

  /// Accent colour applied to annual-frequency labels and amounts in dark mode.
  static const Color textAnnualColor = Color(0xFFF59E0B);

  /// Accent colour applied to monthly-frequency labels and amounts in dark mode.
  static const Color textMonthlyColor = Color(0xFF3B82F6);

  /// Background fill of the navigation bar in dark mode.
  static const Color bottomNavigationBarBackgroundColor = Color(0xFF1A1216);

  /// Top border separating the navigation bar from page content in dark mode.
  static const Color bottomNavigationBarTopBorderColor = Color(0xFF2E2329);

  /// Drop-shadow colour for the navigation bar in dark mode.
  static const Color bottomNavigationBarShadowsColor = Color(0xFFFFFFFF);

  /// Border colour for list tile separators in dark mode.
  static const Color listTileBorderColor = Color(0xFF3D3438);

  /// Background colour of the theme-toggle icon container in dark mode.
  static const Color changeThemeIconColor = Color(0xFFC9B1D0);

  /// Expenses Colors
  static const Color expensesSubscriptionIconBackgroundColor = Color(0xFF3D2830);
  static const Color expensesFinancingIconBackgroundColor = Color(0xFF2A3832);
  static const Color expensesAllIconBackgroundColor = Color(0xFF352E38);
  static const Color expensesSubscriptionIconColor = Color(0xFFFFB3C1);
  static const Color expensesFinancingIconColor = Color(0xFFA8D5BA);
  static const Color expensesAllIconColor = Color(0xFFC9B1D0);
  static const Color expensesAnnualColor = Color(0xFF38342E);
  static const Color expensesMonthlyColor = Color(0xFF2E3438);

  /// Appointments Colors
  static const Color appointmentsBulletPointColor = Color(0xFFFFD6A5);
  static const Color appointmentsBadgeBackgroundColor = Color(0xFFD7A567);

  /// Dialog Colors
  static const Color dialogErrorBackgroundColor = Color(0xFF3D3438);
  static const Color dialogSuccessBackgroundColor = Color(0xFF2A3832);
  static const Color dialogInfoBackgroundColor = Color(0xFF352E38);
  static const Color dialogBarrierColor = Color(0xFFFFFFFF);

  // Onboarding Colors
  static const Color onboardingScaffoldBackgroundColor = Color(0xFF1A1518);
  static const Color onboardingNotificationContainerBackgroundColor = Color(0xFF3D3438);
  static const Color onboardingAppointmentsContainerBackgroundColor = Color(0xFF3D3438);
}

/// Pre-built [TextTheme]s and custom monetary [TextStyle]s for light and dark modes.
class ThemeTextStyles {
  ThemeTextStyles._();

  /// Complete [TextTheme] for the light mode, with each role mapped to Inter or Outfit at design-system sizes.
  static const TextTheme appLightTextTheme = TextTheme(
    // displayLarge — hero banners, onboarding screens.
    displayLarge: TextStyle(
      fontFamily: ThemeConstants.outfitFontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 60,
      height: 64 / 60,
      letterSpacing: -0.25,
      color: ThemeLightColors.textPrimaryColor,
    ),

    // displayMedium — section heroes, large totals.
    displayMedium: TextStyle(
      fontFamily: ThemeConstants.outfitFontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 45,
      height: 52 / 45,
      letterSpacing: 0,
      color: ThemeLightColors.textPrimaryColor,
    ),

    // displaySmall — dashboard balance, month summary.
    displaySmall: TextStyle(
      fontFamily: ThemeConstants.outfitFontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 36,
      height: 44 / 36,
      letterSpacing: 0,
      color: ThemeLightColors.textPrimaryColor,
    ),

    // headlineLarge — closest mapping to source `font.display.lg` (32sp/40sp).
    headlineLarge: TextStyle(
      fontFamily: ThemeConstants.outfitFontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 32,
      height: 40 / 32,
      letterSpacing: 0,
      color: ThemeLightColors.textPrimaryColor,
    ),

    // headlineMedium — maps to source `font.display.md` (28sp/36sp).
    headlineMedium: TextStyle(
      fontFamily: ThemeConstants.outfitFontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 28,
      height: 36 / 28,
      letterSpacing: 0,
      color: ThemeLightColors.textPrimaryColor,
    ),

    // headlineSmall — maps to source `font.headline` (22sp/28sp).
    headlineSmall: TextStyle(
      fontFamily: ThemeConstants.outfitFontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 22,
      height: 28 / 22,
      letterSpacing: 0,
      color: ThemeLightColors.textPrimaryColor,
    ),

    // titleLarge — card titles, dialog headers.
    titleLarge: TextStyle(
      fontFamily: ThemeConstants.interFontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 20,
      height: 28 / 20,
      letterSpacing: 0,
      color: ThemeLightColors.textPrimaryColor,
    ),

    // titleMedium — list-tile titles, tab labels.
    titleMedium: TextStyle(
      fontFamily: ThemeConstants.interFontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 18,
      height: 24 / 16,
      letterSpacing: 0.15,
      color: ThemeLightColors.textPrimaryColor,
    ),

    // titleSmall — sub-headers, grouped list section titles.
    titleSmall: TextStyle(
      fontFamily: ThemeConstants.interFontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: ThemeLightColors.textPrimaryColor,
    ),

    // bodyLarge — primary paragraph text.
    bodyLarge: TextStyle(
      fontFamily: ThemeConstants.interFontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.5,
      color: ThemeLightColors.textPrimaryColor,
    ),

    // bodyMedium — default body, transaction descriptions.
    bodyMedium: TextStyle(
      fontFamily: ThemeConstants.interFontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.25,
      color: ThemeLightColors.textSecondaryColor,
    ),

    // bodySmall — timestamps, metadata, fine print.
    bodySmall: TextStyle(
      fontFamily: ThemeConstants.interFontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.4,
      color: ThemeLightColors.textSecondaryColor,
    ),

    // labelLarge — button text, prominent chips.
    labelLarge: TextStyle(
      fontFamily: ThemeConstants.interFontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: ThemeLightColors.textSecondaryColor,
    ),

    // labelMedium — navigation labels, input hints.
    labelMedium: TextStyle(
      fontFamily: ThemeConstants.interFontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.5,
      color: ThemeLightColors.textSecondaryColor,
    ),

    // labelSmall — captions, badges, overline text.
    labelSmall: TextStyle(
      fontFamily: ThemeConstants.interFontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 11,
      height: 16 / 11,
      letterSpacing: 0.5,
      color: ThemeLightColors.textSecondaryColor,
    ),
  );

  /// Complete [TextTheme] for the dark mode, mirroring [appLightTextTheme] with dark-mode color tokens.
  static const TextTheme appDarkTextTheme = TextTheme(
    // displayLarge — hero banners, onboarding screens.
    displayLarge: TextStyle(
      fontFamily: ThemeConstants.outfitFontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 60,
      height: 64 / 60,
      letterSpacing: -0.25,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    // displayMedium — section heroes, large totals.
    displayMedium: TextStyle(
      fontFamily: ThemeConstants.outfitFontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 45,
      height: 52 / 45,
      letterSpacing: 0,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    // displaySmall — dashboard balance, month summary.
    displaySmall: TextStyle(
      fontFamily: ThemeConstants.outfitFontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 36,
      height: 44 / 36,
      letterSpacing: 0,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    // headlineLarge — closest mapping to source `font.display.lg` (32sp/40sp).
    headlineLarge: TextStyle(
      fontFamily: ThemeConstants.outfitFontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 32,
      height: 40 / 32,
      letterSpacing: 0,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    // headlineMedium — maps to source `font.display.md` (28sp/36sp).
    headlineMedium: TextStyle(
      fontFamily: ThemeConstants.outfitFontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 28,
      height: 36 / 28,
      letterSpacing: 0,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    // headlineSmall — maps to source `font.headline` (22sp/28sp).
    headlineSmall: TextStyle(
      fontFamily: ThemeConstants.outfitFontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 22,
      height: 28 / 22,
      letterSpacing: 0,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    // titleLarge — card titles, dialog headers.
    titleLarge: TextStyle(
      fontFamily: ThemeConstants.interFontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 20,
      height: 28 / 20,
      letterSpacing: 0,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    // titleMedium — list-tile titles, tab labels.
    titleMedium: TextStyle(
      fontFamily: ThemeConstants.interFontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 18,
      height: 24 / 16,
      letterSpacing: 0.15,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    // titleSmall — sub-headers, grouped list section titles.
    titleSmall: TextStyle(
      fontFamily: ThemeConstants.interFontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    // bodyLarge — primary paragraph text.
    bodyLarge: TextStyle(
      fontFamily: ThemeConstants.interFontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.5,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    // bodyMedium — default body, transaction descriptions.
    bodyMedium: TextStyle(
      fontFamily: ThemeConstants.interFontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.25,
      color: ThemeDarkColors.textSecondaryColor,
    ),

    // bodySmall — timestamps, metadata, fine print.
    bodySmall: TextStyle(
      fontFamily: ThemeConstants.interFontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.4,
      color: ThemeDarkColors.textSecondaryColor,
    ),

    // labelLarge — button text, prominent chips.
    labelLarge: TextStyle(
      fontFamily: ThemeConstants.interFontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: ThemeDarkColors.textSecondaryColor,
    ),

    // labelMedium — navigation labels, input hints.
    labelMedium: TextStyle(
      fontFamily: ThemeConstants.interFontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.5,
      color: ThemeDarkColors.textSecondaryColor,
    ),

    // labelSmall — captions, badges, overline text.
    labelSmall: TextStyle(
      fontFamily: ThemeConstants.interFontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 11,
      height: 16 / 11,
      letterSpacing: 0.5,
      color: ThemeDarkColors.textSecondaryColor,
    ),
  );

  /// Monospaced style for monetary amounts and financial data.
  static const TextStyle monetaryAmountLight = TextStyle(
    fontFamily: ThemeConstants.jetBrainsMonoFontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 28 / 24,
    letterSpacing: 0,
    color: ThemeLightColors.textSecondaryColor,
    fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
  );

  /// Smaller monetary amount variant for inline / list-item use (14sp).
  static const TextStyle monetaryAmountSmallLight = TextStyle(
    fontFamily: ThemeConstants.jetBrainsMonoFontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 24 / 18,
    letterSpacing: 0,
    color: ThemeLightColors.textSecondaryColor,
    fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
  );

  /// Monospaced style for monetary amounts and financial data.
  static const TextStyle monetaryAmountDark = TextStyle(
    fontFamily: ThemeConstants.jetBrainsMonoFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 28 / 20,
    letterSpacing: 0,
    color: ThemeDarkColors.textSecondaryColor,
    fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
  );

  /// Smaller monetary amount variant for inline / list-item use (14sp).
  static const TextStyle monetaryAmountSmallDark = TextStyle(
    fontFamily: ThemeConstants.jetBrainsMonoFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0,
    color: ThemeDarkColors.textSecondaryColor,
    fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
  );
}

/// Material 3 [ThemeData] for light mode.
final ThemeData lightAppTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorSchemeSeed: ThemeLightColors.primaryColor,
  textTheme: ThemeTextStyles.appLightTextTheme,
  scaffoldBackgroundColor: ThemeLightColors.backgroundColor,
  appBarTheme: AppBarTheme(
    backgroundColor: ThemeLightColors.bottomNavigationBarBackgroundColor,
    surfaceTintColor: Colors.transparent,
    elevation: DesignConstants.appBarElevation,
    centerTitle: true,
    titleTextStyle: ThemeTextStyles.appLightTextTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
    iconTheme: const IconThemeData(
      color: ThemeLightColors.onSurfaceVariantColor,
      size: DesignConstants.icon24,
      applyTextScaling: false,
    ),
    actionsIconTheme: const IconThemeData(
      color: ThemeLightColors.onSurfaceVariantColor,
      size: DesignConstants.icon24,
      applyTextScaling: false,
    ),
    toolbarTextStyle: ThemeTextStyles.appLightTextTheme.titleLarge,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: ThemeLightColors.backgroundColor,
    elevation: 5,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((Set<WidgetState> state) {
      if (state.contains(WidgetState.selected)) {
        return const IconThemeData(
          size: DesignConstants.icon24,
          color: ThemeLightColors.primaryColor,
          applyTextScaling: false,
        );
      }
      return const IconThemeData(
        size: DesignConstants.icon24,
        color: ThemeLightColors.textDisabledColor,
        applyTextScaling: false,
      );
    }),
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((Set<WidgetState> state) {
      if (state.contains(WidgetState.selected)) {
        return ThemeTextStyles.appLightTextTheme.labelMedium!.copyWith(
          color: ThemeLightColors.primaryColor,
          overflow: TextOverflow.ellipsis,
        );
      }
      return ThemeTextStyles.appLightTextTheme.labelMedium!.copyWith(
        color: ThemeLightColors.textDisabledColor,
        overflow: TextOverflow.ellipsis,
      );
    }),
  ),
  switchTheme: SwitchThemeData(
    trackOutlineWidth: const WidgetStatePropertyAll<double>(0),
    thumbColor: WidgetStateProperty.all<Color>(ThemeLightColors.backgroundColor),
    trackColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return ThemeLightColors.primaryColor;
      }
      return ThemeLightColors.switchTrackColor;
    }),
  ),
  inputDecorationTheme: InputDecorationTheme(
    errorMaxLines: 2,
    fillColor: ThemeLightColors.backgroundColor,
    filled: true,
    alignLabelWithHint: true,
    isDense: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(
        color: ThemeLightColors.surfaceVariantColor,
        width: 1,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(
        color: ThemeLightColors.errorColor,
        width: 1.5,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(
        color: ThemeLightColors.primaryColor,
        width: 1.5,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(
        color: ThemeLightColors.errorColor,
        width: 1.5,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(
        color: ThemeLightColors.surfaceVariantColor,
        width: 1.5,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
    ),
  ),
  listTileTheme: ListTileThemeData(
    style: ListTileStyle.list,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(DesignConstants.radius16),
      side: const BorderSide(
        color: ThemeLightColors.bottomNavigationBarTopBorderColor,
        width: DesignConstants.bottomBarBorderWidth,
      ),
    ),
    titleAlignment: .center,
    titleTextStyle: ThemeTextStyles.appLightTextTheme.titleMedium,
    subtitleTextStyle: ThemeTextStyles.appLightTextTheme.titleSmall!.copyWith(
      color: ThemeLightColors.textSecondaryColor,
    ),
    dense: false,
    tileColor: ThemeLightColors.backgroundColor,
    selectedTileColor: ThemeLightColors.primaryColor,
    selectedColor: ThemeLightColors.primaryColor,
  ),
);

/// Material 3 [ThemeData] for dark mode.
final ThemeData darkAppTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorSchemeSeed: ThemeDarkColors.primaryColor,
  textTheme: ThemeTextStyles.appDarkTextTheme,
  scaffoldBackgroundColor: ThemeDarkColors.scaffoldBackgroundColor,
  appBarTheme: AppBarTheme(
    backgroundColor: ThemeDarkColors.bottomNavigationBarBackgroundColor,
    surfaceTintColor: Colors.transparent,
    elevation: DesignConstants.appBarElevation,
    centerTitle: true,
    titleTextStyle: ThemeTextStyles.appDarkTextTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
    iconTheme: const IconThemeData(
      color: ThemeDarkColors.onSurfaceVariantColor,
      size: DesignConstants.icon24,
      applyTextScaling: false,
    ),
    actionsIconTheme: const IconThemeData(
      color: ThemeDarkColors.onSurfaceVariantColor,
      size: DesignConstants.icon24,
      applyTextScaling: false,
    ),
    toolbarTextStyle: ThemeTextStyles.appDarkTextTheme.titleLarge,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: ThemeDarkColors.scaffoldBackgroundColor,
    elevation: 5,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((Set<WidgetState> state) {
      if (state.contains(WidgetState.selected)) {
        return const IconThemeData(
          size: DesignConstants.icon24,
          color: ThemeDarkColors.primaryColor,
          applyTextScaling: false,
        );
      }
      return const IconThemeData(
        size: DesignConstants.icon24,
        color: ThemeDarkColors.textSecondaryColor,
        applyTextScaling: false,
      );
    }),
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((Set<WidgetState> state) {
      if (state.contains(WidgetState.selected)) {
        return ThemeTextStyles.appDarkTextTheme.labelMedium!.copyWith(
          color: ThemeDarkColors.primaryColor,
          overflow: TextOverflow.ellipsis,
        );
      }
      return ThemeTextStyles.appDarkTextTheme.labelMedium!.copyWith(
        color: ThemeDarkColors.textSecondaryColor,
        overflow: TextOverflow.ellipsis,
      );
    }),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all<Color>(ThemeDarkColors.backgroundColor),
    trackColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return ThemeDarkColors.primaryDarkColor;
      }
      return ThemeDarkColors.onSurfaceVariantColor;
    }),
  ),
  inputDecorationTheme: InputDecorationTheme(
    errorMaxLines: 2,
    fillColor: ThemeDarkColors.scaffoldBackgroundColor,
    filled: true,
    alignLabelWithHint: true,
    isDense: true,
    outlineBorder: const BorderSide(
      color: ThemeDarkColors.surfaceVariantColor,
      width: 1,
      strokeAlign: BorderSide.strokeAlignOutside,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(
        color: ThemeDarkColors.surfaceVariantColor,
        width: 1,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(
        color: ThemeDarkColors.errorColor,
        width: 1.5,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(
        color: ThemeDarkColors.primaryDarkColor,
        width: 1.5,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(
        color: ThemeDarkColors.errorColor,
        width: 1.5,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(
        color: ThemeDarkColors.surfaceVariantColor,
        width: 1.5,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
    ),
  ),
  listTileTheme: ListTileThemeData(
    style: ListTileStyle.list,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(DesignConstants.radius16),
      side: const BorderSide(color: ThemeDarkColors.listTileBorderColor, width: DesignConstants.bottomBarBorderWidth),
    ),
    titleAlignment: .center,
    titleTextStyle: ThemeTextStyles.appDarkTextTheme.titleMedium,
    subtitleTextStyle: ThemeTextStyles.appDarkTextTheme.titleSmall!.copyWith(color: ThemeDarkColors.textSecondaryColor),
    dense: false,
    tileColor: ThemeDarkColors.surfaceColor,
    selectedTileColor: ThemeDarkColors.primaryColor,
    selectedColor: ThemeDarkColors.primaryColor,
  ),
);
