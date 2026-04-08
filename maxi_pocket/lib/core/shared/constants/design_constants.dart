import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Offset;

/// Design-system tokens for sizing, spacing, and layout shared across the app.
@immutable
class DesignConstants {
  const DesignConstants._();

  static const double appMaxTextScaler = 1.6;
  static const double appHeightByDesign = 853;

  /// Text Size
  static const double textSize14 = 14.0;
  static const double textSize16 = 16.0;
  static const double textSize18 = 18.0;
  static const double textSize20 = 20.0;
  static const double textSize22 = 22.0;
  static const double textSize24 = 24.0;
  static const double textSize26 = 26.0;
  static const double textSize28 = 28.0;

  /// Icon
  static const double icon24 = 24.0;
  static const double icon40 = 40.0;

  /// Container Size
  static const double containerSize24 = 24.0;
  static const double containerSize32 = 32.0;
  static const double containerSize40 = 40.0;
  static const double containerSize48 = 48.0;
  static const double containerSize56 = 56.0;
  static const double containerSize64 = 64.0;
  static const double containerSize72 = 72.0;
  static const double containerSize80 = 80.0;
  static const double containerSize85 = 85.0;
  static const double containerSize88 = 88.0;
  static const double containerSize100 = 100.0;

  /// Alpha
  static const double alpha10 = 0.1;
  static const double alpha20 = 0.2;
  static const double alpha30 = 0.3;
  static const double alpha40 = 0.4;
  static const double alpha50 = 0.5;
  static const double alpha60 = 0.6;
  static const double alpha70 = 0.7;
  static const double alpha80 = 0.8;
  static const double alpha90 = 0.9;
  static const double alpha100 = 1.0;

  // Spacing
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
  static const double spacing48 = 48.0;
  static const double spacing56 = 56.0;
  static const double spacing64 = 64.0;

  /// Radius
  static const double radius4 = 4.0;
  static const double radius8 = 8.0;
  static const double radius12 = 12.0;
  static const double radius16 = 16.0;
  static const double radius24 = 24.0;
  static const double radius32 = 32.0;
  static const double radius40 = 40.0;
  static const double radius48 = 48.0;
  static const double radius56 = 56.0;
  static const double radius64 = 64.0;

  /// Loading
  static const double loadingSize = 48.0;

  /// App Bar
  static const double appBarElevation = 2.0;

  /// List Tile
  static const Offset listTileOffset = Offset(0, 1);
  static const double listTileBlurRadiusFirst = 3.0;
  static const double listTileBlurRadiusSecond = 2.0;
  static const double listTileSpreadRadiusFirst = 0.0;
  static const double listTileSpreadRadiusSecond = -1.0;
  static const double listTileShadowOpacity = 0.1;

  /// Bottom Bar
  static const double bottomBarBorderWidth = 1.0;
  static const double bottomBarDesignHeight = 65.0;
  static const Offset bottomBarOffsetFirst = Offset(0, 4);
  static const Offset bottomBarOffsetSecond = Offset(0, 2);
  static const double bottomBarBlurRadiusFirst = 5.0;
  static const double bottomBarBlurRadiusSecond = 17.0;
  static const double bottomBarSpreadRadiusFirst = -1.0;
  static const double bottomBarSpreadRadiusSecond = -7.0;
  static const double bottomBarShadowOpacity = 0.1;

  /// Empty Data
  static const double emptyDataImageSize = 170.0;
}
