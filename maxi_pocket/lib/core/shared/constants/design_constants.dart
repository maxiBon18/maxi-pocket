import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Offset;

/// Design-system tokens for sizing, spacing, and layout shared across the app.
@immutable
class DesignConstants {
  const DesignConstants._();

  static const double appMaxTextScaler = 1.6;
  static const double appHeightByDesign = 853;
  static const double iconSize = 24.0;

  // Spacing
  static const double spacing = 8.0;
  static const double spacingSmall = 4.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;
  static const double spacingXXLarge = 40.0;
  static const double spacingXXXLarge = 48.0;
  static const double spacingXXXXLarge = 56.0;
  static const double spacingXXXXXLarge = 64.0;

  /// Loading
  static const double loadingSize = 48.0;

  /// Bottom Bar
  static const double bottomBarBorderWidth = 1.0;
  static const double bottomBarDesignHeight = 65.0;
  static const Offset bottomBarOffsetFirst = Offset(0, 10);
  static const Offset bottomBarOffsetSecond = Offset(0, 4);
  static const double bottomBarBlurRadiusFirst = 10.0;
  static const double bottomBarBlurRadiusSecond = 50.0;
  static const double bottomBarSpreadRadiusFirst = -3.0;
  static const double bottomBarSpreadRadiusSecond = -4.0;
  static const double bottomBarShadowOpacity = 0.1;

  /// Empty Data
  static const double emptyDataImageSize = 170.0;
}
