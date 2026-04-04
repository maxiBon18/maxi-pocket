import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Offset;

/// Design-system tokens for sizing, spacing, and layout shared across the app.
@immutable
class DesignConstants {
  const DesignConstants._();

  static const double appMaxTextScaler = 1.6;
  static const double appHeightByDesign = 853;
  static const double iconSize = 24.0;

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
}
