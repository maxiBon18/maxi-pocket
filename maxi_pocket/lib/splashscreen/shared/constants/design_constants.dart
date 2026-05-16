import 'package:flutter/foundation.dart';

/// Layout and timing constants used on the splash screen.
@immutable
class MaxiPocketSplashDesignConstants {
  const MaxiPocketSplashDesignConstants._();

  /// Height of the app logo image in logical pixels.
  /// Fixed at 200 px — intentional brand mark size for the splash screen.
  static const double logoHeight = 200;

  /// Width of the app logo image in logical pixels.
  /// Fixed at 200 px — intentional brand mark size for the splash screen.
  static const double logoWidth = 200;

  /// Number of seconds the splash screen is displayed before navigating away.
  static const int splashDuration = 2;
}
