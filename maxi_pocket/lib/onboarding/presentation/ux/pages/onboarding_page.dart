import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart'
    show ThemeLightColors, ThemeDarkColors;
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/button_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/icon_container_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/image_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/leading_trailing_icon_widget.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/loading_viewmodel.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart'
    show DesignConstants;
import 'package:maxi_pocket/core/shared/controllers/di.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketThemeMode;
import 'package:maxi_pocket/core/shared/utils/extensions.dart';
import 'package:maxi_pocket/onboarding/presentation/viewmodel/onboarding_viewmodel.dart';
import 'package:maxi_pocket/onboarding/shared/constants/widget_constant.dart';
import 'package:maxi_pocket/routes.dart';

/// First-run onboarding page that introduces the app, explains notifications, and
/// requests notification permission when the user taps the continue button.
class MaxiPocketOnboardingPage extends ConsumerWidget {
  const MaxiPocketOnboardingPage({super.key});

  Color _getScaffoldBackgroundColor(MaxiPocketThemeMode themeMode) {
    return themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.backgroundColor
        : ThemeDarkColors.onboardingScaffoldBackgroundColor;
  }

  Color _getColorIconBackground(MaxiPocketThemeMode themeMode) =>
      themeMode == MaxiPocketThemeMode.light
      ? ThemeLightColors.expensesSubscriptionIconBackgroundColor
      : ThemeDarkColors.expensesSubscriptionIconBackgroundColor;

  Color _getColorIcon(MaxiPocketThemeMode themeMode) =>
      themeMode == MaxiPocketThemeMode.light
      ? ThemeLightColors.expensesSubscriptionIconColor
      : ThemeDarkColors.expensesSubscriptionIconColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    return MaxiPocketPage(
      showAppBar: false,
      showBottomBar: false,
      showLeading: false,
      allowBack: false,
      backgroundColor: _getScaffoldBackgroundColor(themeMode),
      routeName: Routes.onboardingRoute,
      child: Padding(
        padding: const EdgeInsets.all(DesignConstants.spacing32),
        child: Column(
          crossAxisAlignment: .center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                children: <Widget>[
                  MaxiPocketIconContainerWidget(
                    colorBackground: _getColorIconBackground(themeMode),
                    width: DesignConstants.containerSize88,
                    height: DesignConstants.containerSize88,
                    child: MaxiPocketLeadingTrailingIconWidget(
                      themeMode: themeMode,
                      icon: Icons.notifications_outlined,
                      colorIcon: _getColorIcon(themeMode),
                      size: DesignConstants.icon48,
                    ),
                  ),
                  const SizedBox(height: DesignConstants.spacing32),
                  Text(
                    OnboardingWidgetConstants.onboardingTitle,
                    textAlign: .center,
                    style: context.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: DesignConstants.spacing16),
                  Text(
                    OnboardingWidgetConstants.onboardingSubtitle,
                    textAlign: .center,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontSize: DesignConstants.textSize18,
                    ),
                  ),
                  const SizedBox(height: DesignConstants.spacing40),
                  _NotificationInfoContainerWidget(themeMode: themeMode),
                ],
              ),
            ),
            MaxiPocketButtonWidget(
              label: OnboardingWidgetConstants.onboardingContinueButtonText,
              width: double.infinity,
              themeMode: themeMode,
              onPressed: () async {
                getDI<LoadingViewmodel>().showLoading(context: context);
                await ref
                    .read(onboardingProvider.notifier)
                    .setOnboardingCompleted();
                getDI<LoadingViewmodel>().hideLoading();
                if (context.mounted) {
                  Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationInfoContainerWidget extends StatelessWidget {
  const _NotificationInfoContainerWidget({required this.themeMode});

  final MaxiPocketThemeMode themeMode;

  Color _getBackgroundColor(MaxiPocketThemeMode themeMode) {
    return themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.onboardingNotificationContainerBackgroundColor
        : ThemeDarkColors.onboardingNotificationContainerBackgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getBackgroundColor(themeMode),
        borderRadius: BorderRadius.circular(DesignConstants.radius16),
      ),
      padding: const EdgeInsets.all(DesignConstants.spacing16),
      child: const Row(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: <Widget>[
          MaxiPocketImage(
            image: OnboardingAssetsConstants.notificationIcon,
            width: DesignConstants.icon24,
            height: DesignConstants.icon24,
            fit: BoxFit.contain,
            quality: FilterQuality.high,
          ),
          SizedBox(width: DesignConstants.spacing16),
          _NotificationContainerTextWidget(),
        ],
      ),
    );
  }
}

class _NotificationContainerTextWidget extends StatelessWidget {
  const _NotificationContainerTextWidget();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        spacing: DesignConstants.spacing4,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: <Widget>[
          Flexible(
            child: Text(
              OnboardingWidgetConstants.onboardingNotificationContainerTitle,
              style: context.textTheme.titleLarge?.copyWith(
                fontSize: DesignConstants.textSize18,
              ),
            ),
          ),
          Flexible(
            child: Text(
              OnboardingWidgetConstants.onboardingNotificationContainerSubtitle,
              style: context.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
