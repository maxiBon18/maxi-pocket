import 'package:flutter/material.dart' show WidgetBuilder, BuildContext;
import 'package:maxi_pocket/core/presentation/ux/pages/not_found_page.dart';
import 'package:maxi_pocket/home/presentation/ux/pages/home_page.dart';
import 'package:maxi_pocket/settings/presentation/ux/pages/notifications_page.dart';
import 'package:maxi_pocket/settings/presentation/ux/pages/settings_page.dart';
import 'package:maxi_pocket/settings/presentation/ux/pages/theme_page.dart';
import 'package:maxi_pocket/splashscreen/presentation/ux/pages/splash_page.dart';

import 'package:flutter/foundation.dart';

/// App-level route configuration.
///
/// Centralises route name constants and the builder map consumed by
/// [RoutingService]. Lives at `lib/` level so that it can reference feature
/// pages without violating the rule that `core/` must stay feature-agnostic.
@immutable
class Routes {
  const Routes._();

  /// Maps route names to their page builders.
  ///
  /// Passed into [RoutingService] at registration time via GetIt.
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    initialRoute: (BuildContext context) => const MaxiPocketSplashPage(),
    homeRoute: (BuildContext context) => const MaxiPocketHomePage(),
    notFoundRoute: (BuildContext context) => const MaxiPocketNotFoundPage(),
    settingsRoute: (BuildContext context) => const MaxiPocketSettingsPage(),
    themeRoute: (BuildContext context) => const MaxiPocketThemePage(),
    notificationsSettingsRoute: (BuildContext context) => const MaxiPocketNotificationsPage(),
  };

  static const String initialRoute = '/';
  static const String homeRoute = '/home';
  static const String notFoundRoute = '/not-found';
  static const String expensesRoute = '/expenses';
  static const String expensesSubscriptionsRoute = '/subscriptions';
  static const String expensesFinancingRoute = '/financing';
  static const String expensesAllRoute = '/all';
  static const String settingsRoute = '/settings';
  static const String themeRoute = '/theme';
  static const String notificationsSettingsRoute = '/notifications-settings';
}
