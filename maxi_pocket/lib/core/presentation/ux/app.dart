/// Root [MaterialApp] for MaxiPocket: theme, routing, locale, and text scaling.
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/ux/routing_service.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart'
    show darkAppTheme, lightAppTheme;
import 'package:maxi_pocket/core/presentation/ux/widgets/custom_text_scaling_widget.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/app_constants.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart'
    show DesignConstants;
import 'package:maxi_pocket/core/shared/controllers/di.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart';
import 'package:maxi_pocket/core/shared/utils/extensions.dart';
import 'package:maxi_pocket/routes.dart';

/// Application shell: watches [themeProvider], applies light/dark [ThemeData], and delegates
/// navigation to [RoutingService].
///
/// The [builder] wraps the route child in [MaxiPocketCustomTextScaling] and an [Overlay]
/// so overlays and accessibility scaling behave consistently.
class MaxiPocketApp extends ConsumerStatefulWidget {
  const MaxiPocketApp({super.key});

  @override
  ConsumerState<MaxiPocketApp> createState() => _MaxiPocketAppConsumerState();
}

class _MaxiPocketAppConsumerState extends ConsumerState<MaxiPocketApp> {
  final RoutingService _routingService = getDI<RoutingService>();

  @override
  Widget build(BuildContext context) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    final Locale deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
    final String languageCode = deviceLocale.languageCode.isNotEmpty
        ? deviceLocale.languageCode
        : AppConstants.languageCode;
    final String countryCode = (deviceLocale.countryCode?.isNotEmpty ?? false)
        ? deviceLocale.countryCode!
        : AppConstants.countryCode;
    final Locale resolvedLocale = Locale(languageCode, countryCode);
    return MaterialApp(
      title: AppConstants.appName,
      theme: lightAppTheme,
      darkTheme: darkAppTheme,
      highContrastTheme: lightAppTheme,
      highContrastDarkTheme: darkAppTheme,
      themeMode: themeMode.toThemeMode,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,
      locale: resolvedLocale,
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: <Locale>[resolvedLocale],
      navigatorObservers: <NavigatorObserver>[
        _routingService.navigatorObserver,
        _routingService.routeObserver,
      ],
      onGenerateRoute: (RouteSettings routeSettings) =>
          _routingService.onGenerateRoute(routeSettings),
      onUnknownRoute: (RouteSettings routeSettings) =>
          _routingService.onUnknownRoute(routeSettings),
      initialRoute: Routes.initialRoute,
      builder: (BuildContext context, Widget? child) {
        return MaxiPocketCustomTextScaling(
          maxTextScalerValue: DesignConstants.appMaxTextScaler,
          blockText: false,
          child: Overlay(
            initialEntries: <OverlayEntry>[
              OverlayEntry(
                builder: (BuildContext context) => child ?? const SizedBox(),
              ),
            ],
          ),
        );
      },
    );
  }
}
