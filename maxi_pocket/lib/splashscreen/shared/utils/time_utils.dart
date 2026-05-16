import 'dart:async' show Timer;
import 'dart:ui' show VoidCallback;

import 'package:maxi_pocket/splashscreen/shared/constants/design_constants.dart'
    show MaxiPocketSplashDesignConstants;

/// Creates a one-shot [Timer] that fires [onComplete] after the splash
/// duration defined in [MaxiPocketSplashDesignConstants.splashDuration].
///
/// The caller is responsible for cancelling the returned timer on disposal
/// to prevent executing [onComplete] on a stale context.
Timer createSplashTimer(VoidCallback onComplete) => Timer(
  const Duration(seconds: MaxiPocketSplashDesignConstants.splashDuration),
  onComplete,
);
