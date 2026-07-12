import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors, ThemeDarkColors;
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/button_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/image_widget.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/loading_viewmodel.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/controllers/di.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
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

  Color _getBackgroundColor(MaxiPocketThemeMode themeMode) {
    return themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.expensesSubscriptionIconBackgroundColor
        : ThemeDarkColors.expensesSubscriptionIconBackgroundColor;
  }

  Color _getBackgroundAppointmentsColor(MaxiPocketThemeMode themeMode) {
    return themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.onboardingAppointmentsContainerBackgroundColor
        : ThemeDarkColors.appointmentsBulletPointColor.withValues(alpha: DesignConstants.alpha10);
  }

  Color _getTitleColor(MaxiPocketThemeMode themeMode) {
    return themeMode == MaxiPocketThemeMode.light ? ThemeDarkColors.textPrimaryColor : ThemeLightColors.onSurfaceColor;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    return MaxiPocketPage(
      showAppBar: false,
      showBottomBar: false,
      showLeading: false,
      allowBack: false,
      backgroundColor: _getScaffoldBackgroundColor(themeMode),
      extendBodyBehindAppBar: true,
      topSafeArea: false,
      bottomSafeArea: false,
      routeName: Routes.onboardingRoute,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: ThemeLightColors.onboardingBackgroundGradientColors,
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: <double>[0.3, 0.6, 1.0],
          ),
        ),
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
                    const _TopIconWidget(),
                    const SizedBox(height: DesignConstants.spacing32),
                    Text(
                      OnboardingWidgetConstants.onboardingTitle,
                      textAlign: .center,
                      style: context.textTheme.headlineLarge?.copyWith(color: _getTitleColor(themeMode)),
                    ),
                    const SizedBox(height: DesignConstants.spacing16),
                    Text(
                      OnboardingWidgetConstants.onboardingSubtitle,
                      textAlign: .center,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontSize: DesignConstants.textSize18,
                        color: _getTitleColor(themeMode),
                      ),
                    ),
                    const SizedBox(height: DesignConstants.spacing40),
                    _NotificationInfoContainerWidget(
                      themeMode: themeMode,
                      title: OnboardingWidgetConstants.onboardingNotificationContainerTitle,
                      subtitle: OnboardingWidgetConstants.onboardingNotificationContainerSubtitle,
                      iconName: OnboardingAssetsConstants.notificationIcon,
                      backgroundIconColor: _getBackgroundColor(themeMode),
                    ),
                    const SizedBox(height: DesignConstants.spacing16),
                    _NotificationInfoContainerWidget(
                      themeMode: themeMode,
                      title: OnboardingWidgetConstants.onboardingNotificationAppointmentsContainerTitle,
                      subtitle: OnboardingWidgetConstants.onboardingNotificationAppointmentsContainerSubtitle,
                      iconName: OnboardingAssetsConstants.notificationAppointmentsIcon,
                      backgroundIconColor: _getBackgroundAppointmentsColor(themeMode),
                    ),
                  ],
                ),
              ),
              MaxiPocketButtonWidget(
                label: OnboardingWidgetConstants.onboardingContinueButtonText,
                width: double.infinity,
                themeMode: themeMode,
                onPressed: () async {
                  getDI<LoadingViewmodel>().showLoading(context: context);
                  await ref.read(onboardingProvider.notifier).setOnboardingCompleted();
                  getDI<LoadingViewmodel>().hideLoading();
                  if (context.mounted) {
                    Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
                  }
                },
              ),
              const SizedBox(height: DesignConstants.spacing32),
            ],
          ),
        ),
      ),
    );
  }
}

/// Circular gradient icon displayed at the top of the onboarding page.
///
/// Uses the gradient defined in [ThemeLightColors.onboardingGradientColors]
/// regardless of the current theme, matching the Figma design spec.
class _TopIconWidget extends StatelessWidget {
  const _TopIconWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DesignConstants.containerSize80,
      height: DesignConstants.containerSize80,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: ThemeLightColors.onboardingGradientColors,
          stops: <double>[0.0, 0.4, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Icon(
        Icons.notifications_outlined,
        color: ThemeLightColors.bottomNavigationBarBackgroundColor,
        size: DesignConstants.icon36,
      ),
    );
  }
}

/// Info card that explains a single notification feature (payments or appointments).
///
/// Renders a rounded container with a coloured icon box on the left and
/// [title] / [subtitle] text on the right. Surface and border colours adapt
/// to [themeMode] via [_getBackgroundColor] and [_getStrokeBorderColor].
class _NotificationInfoContainerWidget extends StatelessWidget {
  const _NotificationInfoContainerWidget({
    required this.themeMode,
    required this.title,
    required this.subtitle,
    required this.iconName,
    required this.backgroundIconColor,
  });

  final MaxiPocketThemeMode themeMode;
  final String title;
  final String subtitle;
  final String iconName;
  final Color backgroundIconColor;

  Color _getBackgroundColor(MaxiPocketThemeMode themeMode) {
    return themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.onboardingNotificationContainerBackgroundColor
        : ThemeDarkColors.surfaceColor.withValues(alpha: DesignConstants.alpha70);
  }

  Color _getStrokeBorderColor(MaxiPocketThemeMode themeMode) {
    return themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.surfaceVariantColor
        : ThemeDarkColors.listTileBorderColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getBackgroundColor(themeMode),
        borderRadius: BorderRadius.circular(DesignConstants.radius16),
        border: Border.all(color: _getStrokeBorderColor(themeMode), width: DesignConstants.borderWidth1),
      ),
      padding: const EdgeInsets.all(DesignConstants.spacing16),
      child: Row(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: <Widget>[
          Container(
            width: DesignConstants.containerSize56,
            height: DesignConstants.containerSize56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundIconColor,
              borderRadius: BorderRadius.circular(DesignConstants.radius16),
            ),
            child: MaxiPocketImage(
              image: iconName,
              width: DesignConstants.icon24,
              height: DesignConstants.icon24,
              fit: BoxFit.fitHeight,
              quality: FilterQuality.high,
            ),
          ),
          const SizedBox(width: DesignConstants.spacing16),
          _NotificationContainerTextWidget(title: title, subtitle: subtitle),
        ],
      ),
    );
  }
}

/// Text column displaying a bold [title] above a lighter [subtitle] inside a notification info card.
class _NotificationContainerTextWidget extends StatelessWidget {
  const _NotificationContainerTextWidget({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

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
            child: Text(title, style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700)),
          ),
          Flexible(child: Text(subtitle, style: context.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
