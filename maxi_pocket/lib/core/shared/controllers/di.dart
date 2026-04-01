import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/data/repo/shared_pref_repo_impl.dart';
import 'package:maxi_pocket/core/data/repo/source/shared_pref_source.dart';
import 'package:maxi_pocket/core/data/source/shared_pref_source_impl.dart';
import 'package:maxi_pocket/core/domain/services/repo/shared_pref_repo.dart';
import 'package:maxi_pocket/core/domain/services/shared_pref_service.dart';
import 'package:maxi_pocket/core/presentation/ux/routing_service.dart';
import 'package:maxi_pocket/core/shared/constants/cache_constants.dart';
import 'package:maxi_pocket/core/shared/controllers/custom_navigator_observer.dart';
import 'package:maxi_pocket/core/shared/utils/loggers.dart';
import 'package:maxi_pocket/routes.dart' show Routes;
import 'package:shared_preferences/shared_preferences.dart';

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
  getIt.registerSingletonIfAbsent<RoutingService>(
    () => RoutingService(getDI<MaxiPocketNavigatorObserver>(), Routes.routes),
  );

  if (kDebugMode) {
    getIt.registerSingletonIfAbsent<ProviderLogger>(() => ProviderLogger());
  }
  getIt.registerLazySingleton<SharedPrefAsyncSource>(() => SharedPrefAsyncSourceImpl(SharedPreferencesAsync()));
  getIt.registerLazySingletonAsync(
    () async => SharedPrefWithCacheSourceImpl(
      await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(allowList: CacheKeys.allKeys),
      ),
    ),
  );

  getIt.registerLazySingleton<SharedPrefAsyncRepo>(() => SharedPrefAsyncRepoImpl(getDI<SharedPrefAsyncSource>()));

  getIt.registerLazySingleton<SharedPrefAsyncService>(() => SharedPrefAsyncService(getDI<SharedPrefAsyncRepo>()));
}
