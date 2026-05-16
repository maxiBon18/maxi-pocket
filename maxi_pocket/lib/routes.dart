import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show WidgetBuilder, BuildContext;
import 'package:maxi_pocket/appointments/presentation/ux/pages/appointments_page.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/not_found_page.dart';
import 'package:maxi_pocket/expenses/presentation/ux/pages/all_expenses_page.dart';
import 'package:maxi_pocket/expenses/presentation/ux/pages/expenses_home_page.dart';
import 'package:maxi_pocket/expenses/presentation/ux/pages/financing_page.dart';
import 'package:maxi_pocket/expenses/presentation/ux/pages/subscriptions_page.dart';
import 'package:maxi_pocket/home/presentation/ux/pages/home_page.dart';
import 'package:maxi_pocket/onboarding/presentation/ux/pages/onboarding_page.dart';
import 'package:maxi_pocket/settings/presentation/ux/pages/notifications_page.dart';
import 'package:maxi_pocket/settings/presentation/ux/pages/settings_page.dart';
import 'package:maxi_pocket/settings/presentation/ux/pages/theme_page.dart';
import 'package:maxi_pocket/splashscreen/presentation/ux/pages/splash_page.dart';

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
    onboardingRoute: (BuildContext context) => const MaxiPocketOnboardingPage(),
    notFoundRoute: (BuildContext context) => const MaxiPocketNotFoundPage(),
    settingsRoute: (BuildContext context) => const MaxiPocketSettingsPage(),
    themeRoute: (BuildContext context) => const MaxiPocketThemePage(),
    notificationsSettingsRoute: (BuildContext context) =>
        const MaxiPocketNotificationsPage(),
    expensesRoute: (BuildContext context) => const MaxiPocketExpensesHomePage(),
    expensesSubscriptionsRoute: (BuildContext context) =>
        const MaxiPocketSubscriptionsPage(),
    expensesFinancingRoute: (BuildContext context) =>
        const MaxiPocketFinancingPage(),
    expensesAllRoute: (BuildContext context) =>
        const MaxiPocketAllExpensesPage(),
    appointmentsRoute: (BuildContext context) =>
        const MaxiPocketAppointmentsPage(),
  };

  /// Root route shown on cold start; navigates to the splash page.
  static const String initialRoute = '/';

  /// Main dashboard shown after a successful data load.
  static const String homeRoute = '/home';

  /// First-run screen that explains the app and requests notification permission.
  static const String onboardingRoute = '/onboarding';

  /// Fallback destination for unregistered route names.
  static const String notFoundRoute = '/not-found';

  /// Expenses hub page containing subscription, financing, and all-expenses tabs.
  static const String expensesRoute = '/expenses';

  /// Detail list for recurring subscription expenses.
  static const String expensesSubscriptionsRoute = '/subscriptions';

  /// Detail list for financing / instalment expenses.
  static const String expensesFinancingRoute = '/financing';

  /// Appointments tracking page.
  static const String appointmentsRoute = '/appointments';

  /// Aggregated view showing all expense categories together.
  static const String expensesAllRoute = '/all';

  /// App settings root page.
  static const String settingsRoute = '/settings';

  /// Theme selection page (light / dark / system).
  static const String themeRoute = '/theme';

  /// Notification preferences page.
  static const String notificationsSettingsRoute = '/notifications-settings';
}
