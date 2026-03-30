import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/presentation/ux/routing_service.dart';
import 'package:maxi_pocket/core/shared/controllers/custom_navigator_observer.dart';
import 'package:maxi_pocket/core/shared/utils/loggers.dart';

R getDI<R extends Object>() => GetIt.instance<R>();

void setupAllDependencies() {
  final GetIt getIt = GetIt.instance;
  setupDependencies(getIt);
}

/// Registers all application-wide singletons with GetIt.
///
/// Registration order: infrastructure → observers → services.
void setupDependencies(GetIt getIt) {
  getIt.registerSingletonIfAbsent<Logger>(
    () => Logger(
      level: Level.all,
      printer: PrettyPrinter(dateTimeFormat: DateTimeFormat.dateAndTime),
    ),
    dispose: (Logger logger) => logger.close(),
  );
  getIt.registerSingletonIfAbsent<MaxiPocketNavigatorObserver>(() => MaxiPocketNavigatorObserver());
  getIt.registerSingletonIfAbsent<RoutingService>(() => RoutingService(getDI<MaxiPocketNavigatorObserver>()));
  if (kDebugMode) {
    getIt.registerSingletonIfAbsent<ProviderLogger>(() => ProviderLogger());
  }
}
