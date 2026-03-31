import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/image_widget.dart';
import 'package:maxi_pocket/core/shared/constants/app_constants.dart';
import 'package:maxi_pocket/core/shared/utils/extensions.dart';
import 'package:maxi_pocket/routes.dart' show Routes;
import 'package:maxi_pocket/splashscreen/shared/constants/assets_constants.dart';
import 'package:maxi_pocket/splashscreen/shared/constants/design_constants.dart';
import 'package:maxi_pocket/splashscreen/shared/utils/time_utils.dart' show createSplashTimer;

/// Initial branded screen shown while the app prepares itself.
///
/// Displays the app logo, name and description for a fixed duration defined in
/// [MaxiPocketSplashDesignConstants.splashDuration], then navigates to the home
/// route. The timer is cancelled on disposal to avoid navigating with a stale
/// context.
class MaxiPocketSplashPage extends StatefulWidget {
  const MaxiPocketSplashPage({super.key});

  @override
  State<MaxiPocketSplashPage> createState() => _MaxiPocketSplashPageState();
}

class _MaxiPocketSplashPageState extends State<MaxiPocketSplashPage> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = createSplashTimer(() {
      Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaxiPocketPage(
      routeName: Routes.initialRoute,
      allowBack: false,
      showAppBar: false,
      extendBodyBehindAppBar: true,
      backgroundColor: ThemeColors.primaryColor,
      child: Center(child: const _SplashContent()),
    );
  }
}

/// Branding column shown inside the splash page.
///
/// Displays the logo, app name and app description in a vertically centered
/// layout.
class _SplashContent extends StatelessWidget {
  const _SplashContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaxiPocketImage(
          image: MaxiPocketSplashAssets.logo,
          height: MaxiPocketSplashDesignConstants.logoHeight,
          width: MaxiPocketSplashDesignConstants.logoWidth,
          fit: BoxFit.contain,
          quality: FilterQuality.low,
        ),
        Text(
          AppConstants.appName,
          style: context.textTheme.displaySmall!.copyWith(color: ThemeColors.textLightInverseColor),
          semanticsLabel: AppConstants.appName,
        ),
        Text(
          AppConstants.appDescription,
          style: context.textTheme.bodyLarge!.copyWith(color: ThemeColors.textLightInverseColor),
          semanticsLabel: AppConstants.appDescription,
        ),
      ],
    );
  }
}
