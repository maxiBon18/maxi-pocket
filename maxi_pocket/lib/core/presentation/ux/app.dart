import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/ux/routing_service.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show darkAppTheme, lightAppTheme;
import 'package:maxi_pocket/core/presentation/ux/widgets/custom_text_scaling.dart';
import 'package:maxi_pocket/core/shared/constants/app_constants.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/constants/routes.dart' show Routes;
import 'package:maxi_pocket/core/shared/controllers/di.dart';

class MaxiPocketApp extends StatefulWidget {
  const MaxiPocketApp({super.key});

  @override
  State<MaxiPocketApp> createState() => _MaxiPocketAppState();
}

class _MaxiPocketAppState extends State<MaxiPocketApp> {
  final RoutingService _routingService = getDI<RoutingService>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: lightAppTheme,
      darkTheme: darkAppTheme,
      highContrastTheme: lightAppTheme,
      highContrastDarkTheme: darkAppTheme,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,
      locale: const Locale(AppConstants.languageCode, AppConstants.countryCode),
      navigatorObservers: <NavigatorObserver>[_routingService.navigatorObserver, _routingService.routeObserver],
      onGenerateRoute: (RouteSettings routeSettings) => _routingService.onGenerateRoute(routeSettings),
      onUnknownRoute: (RouteSettings routeSettings) => _routingService.onUnknownRoute(routeSettings),
      initialRoute: Routes.initialRoute,
      builder: (BuildContext context, Widget? child) {
        return MaxiPocketCustomTextScaling(
          maxTextScalerValue: DesignConstants.appMaxTextScaler,
          blockText: false,
          child: Overlay(
            initialEntries: <OverlayEntry>[OverlayEntry(builder: (BuildContext context) => child ?? const SizedBox())],
          ),
        );
      },
    );
  }
}
