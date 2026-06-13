import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/domain/entities/home_entity.dart'
    show HomeEntity;
import 'package:maxi_pocket/core/presentation/theme/theme.dart'
    show ThemeLightColors;
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/circular_loading.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/image_widget.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/home_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/app_constants.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart'
    show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/extensions.dart';
import 'package:maxi_pocket/routes.dart' show Routes;
import 'package:maxi_pocket/splashscreen/shared/constants/assets_constants.dart';
import 'package:maxi_pocket/splashscreen/shared/constants/design_constants.dart';

/// Initial branded screen shown while the app prepares itself.
///
/// Displays the app logo, name and description for a fixed duration defined in
/// [MaxiPocketSplashDesignConstants.splashDuration], then navigates to the home
/// route. The timer is cancelled on disposal to avoid navigating with a stale
/// context.
class MaxiPocketSplashPage extends ConsumerWidget {
  const MaxiPocketSplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(homeNotifierProvider, (
      AsyncValue<HomeEntity?>? previous,
      AsyncValue<HomeEntity?> next,
    ) {
      next.when(
        data: (_) {
          if (ref.read(homeNotifierProvider.notifier).onboardingCompleted) {
            Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
          } else {
            Navigator.of(context).pushReplacementNamed(Routes.onboardingRoute);
          }
        },
        error: (Object error, StackTrace stackTrace) {
          if (ref.read(homeNotifierProvider.notifier).onboardingCompleted) {
            Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
          } else {
            Navigator.of(context).pushReplacementNamed(Routes.onboardingRoute);
          }
        },
        loading: () {},
      );
    });
    return const MaxiPocketPage(
      routeName: Routes.initialRoute,
      allowBack: false,
      showAppBar: false,
      extendBodyBehindAppBar: true,
      backgroundColor: ThemeLightColors.primaryColor,
      showBottomBar: false,
      child: Center(child: _SplashContent()),
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
      children: <Widget>[
        const MaxiPocketImage(
          image: MaxiPocketSplashAssets.logo,
          height: MaxiPocketSplashDesignConstants.logoHeight,
          width: MaxiPocketSplashDesignConstants.logoWidth,
          fit: BoxFit.contain,
          quality: FilterQuality.low,
        ),
        Text(
          AppConstants.appName,
          style: (context.textTheme.displaySmall ?? const TextStyle()).copyWith(
            color: ThemeLightColors.textInverseColor,
          ),
          semanticsLabel: AppConstants.appName,
          textAlign: .center,
        ),
        Text(
          AppConstants.appDescription,
          style: (context.textTheme.bodyLarge ?? const TextStyle()).copyWith(
            color: ThemeLightColors.textInverseColor,
          ),
          semanticsLabel: AppConstants.appDescription,
          textAlign: .center,
        ),
        const SizedBox(height: DesignConstants.spacing16),
        const MaxiPocketSplashLoadingWidget(),
      ],
    );
  }
}
