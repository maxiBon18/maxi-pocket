import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/data/repo/app_info_repo_impl.dart';
import 'package:maxi_pocket/core/data/repo/shared_pref_repo_impl.dart';
import 'package:maxi_pocket/core/data/repo/source/app_info_source.dart';
import 'package:maxi_pocket/core/data/repo/source/shared_pref_source.dart';
import 'package:maxi_pocket/core/data/source/app_info_source_impl.dart';
import 'package:maxi_pocket/core/data/source/shared_pref_source_impl.dart';
import 'package:maxi_pocket/core/domain/services/app_info_service.dart';
import 'package:maxi_pocket/core/domain/services/repo/app_info_repo.dart';
import 'package:maxi_pocket/core/domain/services/repo/shared_pref_repo.dart';
import 'package:maxi_pocket/core/domain/services/shared_pref_service.dart';
import 'package:maxi_pocket/core/presentation/ux/routing_service.dart';
import 'package:maxi_pocket/core/shared/constants/cache_constants.dart';
import 'package:maxi_pocket/core/shared/controllers/custom_navigator_observer.dart';
import 'package:maxi_pocket/core/shared/utils/loggers.dart';
import 'package:maxi_pocket/routes.dart' show Routes;
import 'package:shared_preferences/shared_preferences.dart';

/// Shorthand for retrieving a registered instance from GetIt.
R getDI<R extends Object>() => GetIt.instance<R>();

/// Initialises all singletons and waits for async registrations to complete.
Future<void> setupAllDependencies() async {
  final GetIt getIt = GetIt.instance;
  await setupDependencies(getIt);
  await getIt.allReady();
}

/// Registers all application-wide singletons with GetIt.
///
/// Registration order: infrastructure → observers → services.
Future<void> setupDependencies(GetIt getIt) async {
  getIt.registerSingletonAsync<SharedPrefWithCacheSource>(
    () async => SharedPrefWithCacheSourceImpl(
      await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(allowList: CacheKeys.allKeys),
      ),
    ),
  );
  getIt.registerSingletonIfAbsent<Logger>(
    () => Logger(
      level: Level.all,
      printer: PrettyPrinter(dateTimeFormat: DateTimeFormat.dateAndTime),
    ),
    dispose: (Logger logger) => logger.close(),
  );
  getIt.registerSingletonIfAbsent<SharedPrefAsyncSource>(() => SharedPrefAsyncSourceImpl(SharedPreferencesAsync()));
  getIt.registerSingletonIfAbsent<MaxiPocketNavigatorObserver>(() => MaxiPocketNavigatorObserver());
  getIt.registerSingletonIfAbsent<RoutingService>(
    () => RoutingService(getDI<MaxiPocketNavigatorObserver>(), Routes.routes),
  );

  if (kDebugMode) {
    getIt.registerSingletonIfAbsent<ProviderLogger>(() => ProviderLogger());
  }

  /// Data Layer
  getIt.registerSingletonIfAbsent<AppInfoSource>(() => AppInfoSourceImpl());

  /// Repository Layer
  getIt.registerLazySingleton<SharedPrefAsyncRepo>(() => SharedPrefAsyncRepoImpl(getDI<SharedPrefAsyncSource>()));
  getIt.registerLazySingleton<SharedPrefWithCacheRepo>(
    () => SharedPrefWithCacheRepoImpl(getDI<SharedPrefWithCacheSource>()),
  );
  getIt.registerSingletonIfAbsent<AppInfoRepo>(() => AppInfoRepoImpl(getDI<AppInfoSource>()));

  /// Service Layer
  getIt.registerLazySingleton<SharedPrefAsyncService>(() => SharedPrefAsyncService(getDI<SharedPrefAsyncRepo>()));
  getIt.registerLazySingleton<SharedPrefWithCacheService>(
    () => SharedPrefWithCacheService(getDI<SharedPrefWithCacheRepo>()),
  );
  getIt.registerSingletonIfAbsent<AppInfoService>(() => AppInfoService(getDI<AppInfoRepo>()));
}
