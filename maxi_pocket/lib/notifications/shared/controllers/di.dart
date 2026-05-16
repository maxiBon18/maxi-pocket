import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/appointments/data/repo/source/appointment_db_source.dart';
import 'package:maxi_pocket/core/data/repo/source/home_db_source.dart';
import 'package:maxi_pocket/core/domain/services/repo/shared_pref_repo.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart';
import 'package:maxi_pocket/notifications/data/repo/notification_plugin_repo_impl.dart';
import 'package:maxi_pocket/notifications/data/repo/source/notification_plugin_source.dart';
import 'package:maxi_pocket/notifications/data/source/notification_plugin_source_impl.dart';
import 'package:maxi_pocket/notifications/domain/services/notification_service.dart';
import 'package:maxi_pocket/notifications/domain/services/repo/notification_plugin_repo.dart';

/// Registers all notification feature dependencies into the provided [GetIt] container.
///
/// Registration order: data source → repository → service.
void setupNotificationsDependencies(GetIt getIt) {
  getIt.registerLazySingleton<NotificationPluginSource>(
    () =>
        NotificationPluginSourceImpl(getDI<FlutterLocalNotificationsPlugin>()),
  );
  getIt.registerLazySingleton<NotificationPluginRepo>(
    () => NotificationPluginRepoImpl(
      getDI<NotificationPluginSource>(),
      getDI<AppointmentDbSource>(),
      getDI<HomeDbSource>(),
    ),
  );
  getIt.registerLazySingleton<NotificationService>(
    () => NotificationService(
      getDI<NotificationPluginRepo>(),
      getDI<SharedPrefWithCacheRepo>(),
      getDI<Logger>(),
    ),
  );
}
