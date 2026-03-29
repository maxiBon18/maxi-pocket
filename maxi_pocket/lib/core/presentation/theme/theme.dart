import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConstants {
  const ThemeConstants._();

  static const String interFontFamily = 'Inter'; // (body/data)
  static const String outfitFontFamily = 'Outfit'; // (headings/display)
  static const String jetBrainsMonoFontFamily = 'JetBrainsMono'; //(amounts/numbers)
}

class ThemeColors {
  const ThemeColors._();

  static const Color primaryColor = Color(0xFFFFB3C1); // Main CTA buttons, FAB, active nav icons
  static const Color primaryLightColor = Color(0xFFFFD6E0); // Selected chips, subtle highlights
  static const Color primaryDarkColor = Color(0xFFE0899B); // Pressed states, active indicators
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
  static const Color darkBackgroundColor = Color(0xFF1A1215); // Scaffold (dark mode)
  static const Color darkSurfaceColor = Color(0xFF2B2024); // Cards (dark mode)
  static const Color darkOnSurfaceColor = Color(0xFFF0E6E8); // Primary text (dark mode)
  static const Color darkOnSurfaceVariantColor = Color(0xFFA89598); // Secondary text (dark mode)
  static const Color darkSurfaceVariantColor = Color(0xFF3D2F33); // Dividers, disabled fields (dark mode)

  static const Color textLightPrimaryColor = Color(0xFF2B2024);
  static const Color textLightSecondaryColor = Color(0xFF5C4F53);
  static const Color textLightDisabledColor = Color(0xFFA8A0AE);
  static const Color textLightOnPrimaryColor = Color(0xFF2B2024);
  static const Color textLightOnSurfaceColor = Color(0xFF2B2024);
  static const Color textLightInverseColor = Color(0xFFF5F0EB);
  static const Color textDarkPrimaryColor = Color(0xFFF5F0EB);
  static const Color textDarkSecondaryColor = Color(0xFFC4B8CB);
  static const Color textDarkDisabledColor = Color(0xFF6B5F72);
  static const Color textDarkOnPrimaryColor = Color(0xFF2B2024);
  static const Color textDarkOnSurfaceColor = Color(0xFFF5F0EB);
  static const Color textDarkInverseColor = Color(0xFF2B2024);
}

class ThemeTextStyles {
  ThemeTextStyles._();

  static TextTheme appLightTextTheme = TextTheme(
    /// displayLarge — hero banners, onboarding screens.
    displayLarge: GoogleFonts.outfit(
      fontWeight: FontWeight.w700,
      fontSize: 57, // M3 default for displayLarge
      height: 64 / 57,
      letterSpacing: -0.25,
      color: ThemeColors.textLightPrimaryColor,
    ),

    /// displayMedium — section heroes, large totals.
    displayMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.w700,
      fontSize: 45, // M3 default for displayMedium
      height: 52 / 45,
      letterSpacing: 0,
      color: ThemeColors.textLightPrimaryColor,
    ),

    /// displaySmall — dashboard balance, month summary.
    displaySmall: GoogleFonts.outfit(
      fontWeight: FontWeight.w700,
      fontSize: 36,
      height: 44 / 36,
      letterSpacing: 0,
      color: ThemeColors.textLightPrimaryColor,
    ),

    /// headlineLarge — closest mapping to source `font.display.lg` (32sp/40sp).
    headlineLarge: GoogleFonts.outfit(
      fontWeight: FontWeight.w700,
      fontSize: 32,
      height: 40 / 32,
      letterSpacing: 0,
      color: ThemeColors.textLightPrimaryColor,
    ),

    /// headlineMedium — maps to source `font.display.md` (28sp/36sp).
    headlineMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.w600,
      fontSize: 28,
      height: 36 / 28,
      letterSpacing: 0,
      color: ThemeColors.textLightPrimaryColor,
    ),

    /// headlineSmall — maps to source `font.headline` (22sp/28sp).
    headlineSmall: GoogleFonts.outfit(
      fontWeight: FontWeight.w600,
      fontSize: 22,
      height: 28 / 22,
      letterSpacing: 0,
      color: ThemeColors.textLightPrimaryColor,
    ),

    /// titleLarge — card titles, dialog headers.
    titleLarge: GoogleFonts.inter(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      height: 28 / 20,
      letterSpacing: 0,
      color: ThemeColors.textLightPrimaryColor,
    ),

    /// titleMedium — list-tile titles, tab labels.
    titleMedium: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.15,
      color: ThemeColors.textLightPrimaryColor,
    ),

    /// titleSmall — sub-headers, grouped list section titles.
    titleSmall: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: ThemeColors.textLightPrimaryColor,
    ),

    /// bodyLarge — primary paragraph text.
    bodyLarge: GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.5,
      color: ThemeColors.textLightPrimaryColor,
    ),

    /// bodyMedium — default body, transaction descriptions.
    bodyMedium: GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.25,
      color: ThemeColors.textLightSecondaryColor,
    ),

    /// bodySmall — timestamps, metadata, fine print.
    bodySmall: GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.4,
      color: ThemeColors.textLightSecondaryColor, // secondary text color for less-prominent content
    ),

    /// labelLarge — button text, prominent chips.
    labelLarge: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: ThemeColors.textLightSecondaryColor,
    ),

    /// labelMedium — navigation labels, input hints.
    labelMedium: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.5,
      color: ThemeColors.textLightSecondaryColor,
    ),

    /// labelSmall — captions, badges, overline text.
    labelSmall: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 11,
      height: 16 / 11,
      letterSpacing: 0.5,
      color: ThemeColors.textLightSecondaryColor,
    ),
  );

  static TextTheme appDarkTextTheme = TextTheme(
    /// displayLarge — hero banners, onboarding screens.
    displayLarge: GoogleFonts.outfit(
      fontWeight: FontWeight.w700,
      fontSize: 57, // M3 default for displayLarge
      height: 64 / 57,
      letterSpacing: -0.25,
      color: ThemeColors.textDarkPrimaryColor,
    ),

    /// displayMedium — section heroes, large totals.
    displayMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.w700,
      fontSize: 45, // M3 default for displayMedium
      height: 52 / 45,
      letterSpacing: 0,
      color: ThemeColors.textDarkPrimaryColor,
    ),

    /// displaySmall — dashboard balance, month summary.
    displaySmall: GoogleFonts.outfit(
      fontWeight: FontWeight.w700,
      fontSize: 36,
      height: 44 / 36,
      letterSpacing: 0,
      color: ThemeColors.textDarkPrimaryColor,
    ),

    /// headlineLarge — closest mapping to source `font.display.lg` (32sp/40sp).
    headlineLarge: GoogleFonts.outfit(
      fontWeight: FontWeight.w700,
      fontSize: 32,
      height: 40 / 32,
      letterSpacing: 0,
      color: ThemeColors.textDarkPrimaryColor,
    ),

    /// headlineMedium — maps to source `font.display.md` (28sp/36sp).
    headlineMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.w600,
      fontSize: 28,
      height: 36 / 28,
      letterSpacing: 0,
      color: ThemeColors.textDarkPrimaryColor,
    ),

    /// headlineSmall — maps to source `font.headline` (22sp/28sp).
    headlineSmall: GoogleFonts.outfit(
      fontWeight: FontWeight.w600,
      fontSize: 22,
      height: 28 / 22,
      letterSpacing: 0,
      color: ThemeColors.textDarkPrimaryColor,
    ),

    /// titleLarge — card titles, dialog headers.
    titleLarge: GoogleFonts.inter(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      height: 28 / 20,
      letterSpacing: 0,
      color: ThemeColors.textDarkPrimaryColor,
    ),

    /// titleMedium — list-tile titles, tab labels.
    titleMedium: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.15,
      color: ThemeColors.textDarkPrimaryColor,
    ),

    /// titleSmall — sub-headers, grouped list section titles.
    titleSmall: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: ThemeColors.textDarkPrimaryColor,
    ),

    /// bodyLarge — primary paragraph text.
    bodyLarge: GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.5,
      color: ThemeColors.textDarkPrimaryColor,
    ),

    /// bodyMedium — default body, transaction descriptions.
    bodyMedium: GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.25,
      color: ThemeColors.textDarkSecondaryColor,
    ),

    /// bodySmall — timestamps, metadata, fine print.
    bodySmall: GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.4,
      color: ThemeColors.textDarkSecondaryColor, // secondary text color for less-prominent content
    ),

    /// labelLarge — button text, prominent chips.
    labelLarge: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: ThemeColors.textDarkSecondaryColor,
    ),

    /// labelMedium — navigation labels, input hints.
    labelMedium: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.5,
      color: ThemeColors.textDarkSecondaryColor,
    ),

    /// labelSmall — captions, badges, overline text.
    labelSmall: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 11,
      height: 16 / 11,
      letterSpacing: 0.5,
      color: ThemeColors.textDarkSecondaryColor,
    ),
  );

  /// Monospaced style for monetary amounts and financial data.
  static final TextStyle monetaryAmountLight = GoogleFonts.jetBrainsMono(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 28 / 20,
    letterSpacing: 0,
    color: ThemeColors.textLightSecondaryColor,
    fontFeatures: const <FontFeature>[
      FontFeature.tabularFigures(), // `tnum` — equal-width digits
    ],
  );

  /// Smaller monetary amount variant for inline / list-item use (14sp).
  static final TextStyle monetaryAmountSmallLight = GoogleFonts.jetBrainsMono(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0,
    color: ThemeColors.textLightSecondaryColor,
    fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
  );

  /// Monospaced style for monetary amounts and financial data.
  static final TextStyle monetaryAmountDark = GoogleFonts.jetBrainsMono(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 28 / 20,
    letterSpacing: 0,
    color: ThemeColors.textDarkSecondaryColor,
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
    color: ThemeColors.textDarkSecondaryColor,
    fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
  );
}
