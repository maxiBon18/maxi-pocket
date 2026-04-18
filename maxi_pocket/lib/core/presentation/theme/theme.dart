import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;

/// Font family name constants used as reference tokens across the design system.
class ThemeConstants {
  const ThemeConstants._();

  static const String interFontFamily = 'Inter'; // (body/data)
  static const String outfitFontFamily = 'Outfit'; // (headings/display)
  static const String jetBrainsMonoFontFamily = 'JetBrainsMono'; //(amounts/numbers)
}

/// Color tokens for the light theme.
///
/// Shared palette colors (primary, secondary, etc.) are duplicated in
/// [ThemeDarkColors] with the same value so each theme class is self-contained.
class ThemeLightColors {
  const ThemeLightColors._();

  static const Color primaryColor = Color(0xFFFFB3C1); // Main CTA buttons, FAB, active nav icons
  static const Color primaryLightColor = Color(0xFFFFD6E0); // Selected chips, subtle highlights
  static const Color primarySurfaceColor = Color(0xFFFFF0F3); // Card backgrounds, input fills (light mode)
  static const Color secondaryColor = Color(0xFFA8D5BA); // Income indicators, positive trends, success
  static const Color secondaryDarkColor = Color(0xFF7BB894); // Positive amount text
  static const Color tertiaryColor = Color(0xFFC9B1D0); // Categories, chart segments, tags
  static const Color accentColor = Color(0xFFF4A261); // Warnings, budget alerts, over-limit badges
  static const Color errorColor = Color(0xFFD64550); // Expense amounts, negative trends, validation
  static const Color onSurfaceColor = Color(0xFF2B2024); // Primary text (light mode)
  static const Color onSurfaceVariantColor = Color(0xFF5C4F53); // Secondary text (light mode)
  static const Color surfaceVariantColor = Color(0xFFF0E6E8); // Dividers, disabled fields (light mode)
  static const Color backgroundColor = Color(0xFFFFFBFC); // App scaffold (light mode)
  static const Color bottomNavigationBarBackgroundColor = Color(0xFFFFFFFF); // Bottom navigation bar background color

  /// Text Colors
  static const Color textPrimaryColor = Color(0xFF2B2024);
  static const Color textSecondaryColor = Color(0xFF5C4F53);
  static const Color textDisabledColor = Color(0xFFA8A0AE);
  static const Color textOnPrimaryColor = Color(0xFF2B2024);
  static const Color textOnSurfaceColor = Color(0xFF2B2024);
  static const Color textInverseColor = Color(0xFFF5F0EB);
  static const Color textAnnualColor = Color(0xFFF59E0B);
  static const Color textMonthlyColor = Color(0xFF3B82F6);

  /// Navigation Bottom Bar Colors
  static const Color bottomNavigationBarTopBorderColor = Color(0xFFF0E6EB);
  static const Color bottomNavigationBarShadowsColor = Color(0xFF000000);

  // Theme Settings Colors
  static const Color changeThemeIconColor = Color(0xFFEDE4F0);

  // Switch Colors
  static const Color switchTrackColor = Color(0xFFE5E5E5);

  /// Card Colors
  static const Color cardGradientColor1 = Color(0xFFB399BA);

  /// Badge Colors
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
}

/// Color tokens for the dark theme.
///
/// Shared palette colors (primary, secondary, etc.) are duplicated from
/// [ThemeLightColors] with the same value so each theme class is self-contained.
class ThemeDarkColors {
  const ThemeDarkColors._();

  static const Color primaryColor = Color(0xFFFFB3C1); // Main CTA buttons, FAB, active nav icons
  static const Color primaryDarkColor = Color(0xFFE0899B); // Pressed states, active indicators
  static const Color primarySurfaceColor = Color(0xFF3D2030); // Selected chip/card backgrounds (dark mode)
  static const Color secondaryColor = Color(0xFFA8D5BA); // Income indicators, positive trends, success
  static const Color secondaryDarkColor = Color(0xFF7BB894); // Positive amount text
  static const Color tertiaryColor = Color(0xFFC9B1D0); // Categories, chart segments, tags
  static const Color accentColor = Color(0xFFF4A261); // Warnings, budget alerts, over-limit badges
  static const Color errorColor = Color(0xFFD64550); // Expense amounts, negative trends, validation
  static const Color backgroundColor = Color(0xFFFFFBFC); // Used for switch thumb in dark mode
  static const Color scaffoldBackgroundColor = Color(0xFF1A1215); // Scaffold (dark mode)
  static const Color surfaceColor = Color(0xFF2B2024); // Cards (dark mode)
  static const Color onSurfaceColor = Color(0xFFF0E6E8); // Primary text (dark mode)
  static const Color onSurfaceVariantColor = Color(0xFFA89598); // Secondary text (dark mode)
  static const Color surfaceVariantColor = Color(0xFF3D2F33); // Dividers, disabled fields (dark mode)

  /// Text Colors
  static const Color textPrimaryColor = Color(0xFFF5F0EB);
  static const Color textSecondaryColor = Color(0xFFC9B8C0);
  static const Color textDisabledColor = Color(0xFF6B5F72);
  static const Color textOnPrimaryColor = Color(0xFF2B2024);
  static const Color textOnSurfaceColor = Color(0xFFF5F0EB);
  static const Color textInverseColor = Color(0xFF2B2024);
  static const Color textAnnualColor = Color(0xFFF59E0B);
  static const Color textMonthlyColor = Color(0xFF3B82F6);

  /// Navigation Bottom Bar Colors
  static const Color bottomNavigationBarBackgroundColor = Color(0xFF1A1216);
  static const Color bottomNavigationBarTopBorderColor = Color(0xFF2E2329);
  static const Color bottomNavigationBarShadowsColor = Color(0xFFFFFFFF);

  /// List Tile Colors
  static const Color listTileBorderColor = Color(0xFF3D3438);
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
}

/// Pre-built [TextTheme]s and custom monetary [TextStyle]s for light and dark modes.
class ThemeTextStyles {
  ThemeTextStyles._();

  static final TextTheme appLightTextTheme = TextTheme(
    /// displayLarge — hero banners, onboarding screens.
    displayLarge: GoogleFonts.outfit(
      fontWeight: FontWeight.w700,
      fontSize: 60, // M3 default for displayLarge
      height: 64 / 60,
      letterSpacing: -0.25,
      color: ThemeLightColors.textPrimaryColor,
    ),

    /// displayMedium — section heroes, large totals.
    displayMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.w700,
      fontSize: 45, // M3 default for displayMedium
      height: 52 / 45,
      letterSpacing: 0,
      color: ThemeLightColors.textPrimaryColor,
    ),

    /// displaySmall — dashboard balance, month summary.
    displaySmall: GoogleFonts.outfit(
      fontWeight: FontWeight.w700,
      fontSize: 36,
      height: 44 / 36,
      letterSpacing: 0,
      color: ThemeLightColors.textPrimaryColor,
    ),

    /// headlineLarge — closest mapping to source `font.display.lg` (32sp/40sp).
    headlineLarge: GoogleFonts.outfit(
      fontWeight: FontWeight.w700,
      fontSize: 32,
      height: 40 / 32,
      letterSpacing: 0,
      color: ThemeLightColors.textPrimaryColor,
    ),

    /// headlineMedium — maps to source `font.display.md` (28sp/36sp).
    headlineMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.w600,
      fontSize: 28,
      height: 36 / 28,
      letterSpacing: 0,
      color: ThemeLightColors.textPrimaryColor,
    ),

    /// headlineSmall — maps to source `font.headline` (22sp/28sp).
    headlineSmall: GoogleFonts.outfit(
      fontWeight: FontWeight.w600,
      fontSize: 22,
      height: 28 / 22,
      letterSpacing: 0,
      color: ThemeLightColors.textPrimaryColor,
    ),

    /// titleLarge — card titles, dialog headers.
    titleLarge: GoogleFonts.inter(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      height: 28 / 20,
      letterSpacing: 0,
      color: ThemeLightColors.textPrimaryColor,
    ),

    /// titleMedium — list-tile titles, tab labels.
    titleMedium: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 18,
      height: 24 / 16,
      letterSpacing: 0.15,
      color: ThemeLightColors.textPrimaryColor,
    ),

    /// titleSmall — sub-headers, grouped list section titles.
    titleSmall: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: ThemeLightColors.textPrimaryColor,
    ),

    /// bodyLarge — primary paragraph text.
    bodyLarge: GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.5,
      color: ThemeLightColors.textPrimaryColor,
    ),

    /// bodyMedium — default body, transaction descriptions.
    bodyMedium: GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.25,
      color: ThemeLightColors.textSecondaryColor,
    ),

    /// bodySmall — timestamps, metadata, fine print.
    bodySmall: GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.4,
      color: ThemeLightColors.textSecondaryColor, // secondary text color for less-prominent content
    ),

    /// labelLarge — button text, prominent chips.
    labelLarge: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: ThemeLightColors.textSecondaryColor,
    ),

    /// labelMedium — navigation labels, input hints.
    labelMedium: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.5,
      color: ThemeLightColors.textSecondaryColor,
    ),

    /// labelSmall — captions, badges, overline text.
    labelSmall: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 11,
      height: 16 / 11,
      letterSpacing: 0.5,
      color: ThemeLightColors.textSecondaryColor,
    ),
  );

  static final TextTheme appDarkTextTheme = TextTheme(
    /// displayLarge — hero banners, onboarding screens.
    displayLarge: GoogleFonts.outfit(
      fontWeight: FontWeight.w700,
      fontSize: 60, // M3 default for displayLarge
      height: 64 / 60,
      letterSpacing: -0.25,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    /// displayMedium — section heroes, large totals.
    displayMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.w700,
      fontSize: 45, // M3 default for displayMedium
      height: 52 / 45,
      letterSpacing: 0,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    /// displaySmall — dashboard balance, month summary.
    displaySmall: GoogleFonts.outfit(
      fontWeight: FontWeight.w700,
      fontSize: 36,
      height: 44 / 36,
      letterSpacing: 0,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    /// headlineLarge — closest mapping to source `font.display.lg` (32sp/40sp).
    headlineLarge: GoogleFonts.outfit(
      fontWeight: FontWeight.w700,
      fontSize: 32,
      height: 40 / 32,
      letterSpacing: 0,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    /// headlineMedium — maps to source `font.display.md` (28sp/36sp).
    headlineMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.w600,
      fontSize: 28,
      height: 36 / 28,
      letterSpacing: 0,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    /// headlineSmall — maps to source `font.headline` (22sp/28sp).
    headlineSmall: GoogleFonts.outfit(
      fontWeight: FontWeight.w600,
      fontSize: 22,
      height: 28 / 22,
      letterSpacing: 0,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    /// titleLarge — card titles, dialog headers.
    titleLarge: GoogleFonts.inter(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      height: 28 / 20,
      letterSpacing: 0,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    /// titleMedium — list-tile titles, tab labels.
    titleMedium: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 18,
      height: 24 / 16,
      letterSpacing: 0.15,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    /// titleSmall — sub-headers, grouped list section titles.
    titleSmall: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    /// bodyLarge — primary paragraph text.
    bodyLarge: GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.5,
      color: ThemeDarkColors.textPrimaryColor,
    ),

    /// bodyMedium — default body, transaction descriptions.
    bodyMedium: GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.25,
      color: ThemeDarkColors.textSecondaryColor,
    ),

    /// bodySmall — timestamps, metadata, fine print.
    bodySmall: GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.4,
      color: ThemeDarkColors.textSecondaryColor, // secondary text color for less-prominent content
    ),

    /// labelLarge — button text, prominent chips.
    labelLarge: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: ThemeDarkColors.textSecondaryColor,
    ),

    /// labelMedium — navigation labels, input hints.
    labelMedium: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.5,
      color: ThemeDarkColors.textSecondaryColor,
    ),

    /// labelSmall — captions, badges, overline text.
    labelSmall: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 11,
      height: 16 / 11,
      letterSpacing: 0.5,
      color: ThemeDarkColors.textSecondaryColor,
    ),
  );

  /// Monospaced style for monetary amounts and financial data.
  static final TextStyle monetaryAmountLight = GoogleFonts.jetBrainsMono(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 28 / 24,
    letterSpacing: 0,
    color: ThemeLightColors.textSecondaryColor,
    fontFeatures: const <FontFeature>[
      FontFeature.tabularFigures(), // `tnum` — equal-width digits
    ],
  );

  /// Smaller monetary amount variant for inline / list-item use (14sp).
  static final TextStyle monetaryAmountSmallLight = GoogleFonts.jetBrainsMono(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 24 / 18,
    letterSpacing: 0,
    color: ThemeLightColors.textSecondaryColor,
    fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
  );

  /// Monospaced style for monetary amounts and financial data.
  static final TextStyle monetaryAmountDark = GoogleFonts.jetBrainsMono(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 28 / 20,
    letterSpacing: 0,
    color: ThemeDarkColors.textSecondaryColor,
    fontFeatures: const <FontFeature>[
      FontFeature.tabularFigures(), // `tnum` — equal-width digits
    ],
  );

  /// Smaller monetary amount variant for inline / list-item use (14sp).
  static final TextStyle monetaryAmountSmallDark = GoogleFonts.jetBrainsMono(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0,
    color: ThemeDarkColors.textSecondaryColor,
    fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
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
    iconTheme: IconThemeData(
      color: ThemeLightColors.onSurfaceVariantColor,
      size: DesignConstants.icon24,
      applyTextScaling: false,
    ),
    actionsIconTheme: IconThemeData(
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
        return IconThemeData(
          size: DesignConstants.icon24,
          color: ThemeLightColors.primaryColor,
          applyTextScaling: false,
        );
      }
      return IconThemeData(
        size: DesignConstants.icon24,
        color: ThemeLightColors.textDisabledColor,
        applyTextScaling: false,
      );
    }),
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((Set<WidgetState> state) {
      if (state.contains(WidgetState.selected)) {
        return ThemeTextStyles.appLightTextTheme.labelMedium!.copyWith(color: ThemeLightColors.primaryColor);
      }
      return ThemeTextStyles.appLightTextTheme.labelMedium!.copyWith(color: ThemeLightColors.textDisabledColor);
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
      side: BorderSide(
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
    iconTheme: IconThemeData(
      color: ThemeDarkColors.onSurfaceVariantColor,
      size: DesignConstants.icon24,
      applyTextScaling: false,
    ),
    actionsIconTheme: IconThemeData(
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
        return IconThemeData(
          size: DesignConstants.icon24,
          color: ThemeDarkColors.primaryColor,
          applyTextScaling: false,
        );
      }
      return IconThemeData(
        size: DesignConstants.icon24,
        color: ThemeDarkColors.textSecondaryColor,
        applyTextScaling: false,
      );
    }),
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((Set<WidgetState> state) {
      if (state.contains(WidgetState.selected)) {
        return ThemeTextStyles.appDarkTextTheme.labelMedium!.copyWith(color: ThemeDarkColors.primaryColor);
      }
      return ThemeTextStyles.appDarkTextTheme.labelMedium!.copyWith(color: ThemeDarkColors.textSecondaryColor);
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
      side: BorderSide(color: ThemeDarkColors.listTileBorderColor, width: DesignConstants.bottomBarBorderWidth),
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
