import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/date_symbol_data_local.dart' show initializeDateFormatting;
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/presentation/ux/app.dart';
import 'package:maxi_pocket/core/shared/constants/app_constants.dart'
    show AppConstants;
import 'package:maxi_pocket/core/shared/controllers/di.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketNotificationPermissionState;
import 'package:maxi_pocket/core/shared/utils/loggers.dart';
import 'package:maxi_pocket/notifications/domain/services/notification_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Entry point — initialises all dependencies, formats, timezone, orientation,
/// and notification scheduling before launching the widget tree.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupAllDependencies();
  await initializeDateFormatting(AppConstants.languageCode);
  await _initializeTimezone();
  await _lockOrientationToPortrait();
  await _scheduleNotifications();
  _runApp();
}

/// Mounts [MaxiPocketApp] inside a [ProviderScope].
///
/// In debug builds the scope is configured with [ProviderLogger] to log
/// every provider state change to the console.
void _runApp() {
  if (kDebugMode) {
    runApp(
      ProviderScope(
        observers: <ProviderObserver>[getDI<ProviderLogger>()],
        child: const MaxiPocketApp(),
      ),
    );
  } else {
    runApp(const ProviderScope(child: MaxiPocketApp()));
  }
}

/// Schedules all pending notifications if the user has granted permission.
Future<void> _scheduleNotifications() async {
  final bool shouldScheduleNotifications = await _shouldScheduleNotifications();
  if (shouldScheduleNotifications) {
    await getDI<NotificationService>().scheduleAllIfEnabled();
    getDI<Logger>().i('Notifications scheduled.');
  } else {
    getDI<Logger>().i('Notifications not scheduled.');
  }
}

/// Returns `true` when the notification permission is currently granted.
///
/// Returns `false` and logs the error if the permission check throws.
Future<bool> _shouldScheduleNotifications() async {
  final NotificationService notificationService = getDI<NotificationService>();
  bool shouldScheduleNotifications = false;
  try {
    final MaxiPocketNotificationPermissionState permissionState =
        await notificationService.getPermissionNotificationStatus();
    shouldScheduleNotifications =
        permissionState == MaxiPocketNotificationPermissionState.granted;
  } catch (e, st) {
    getDI<Logger>().e(
      'Failed to check notification permission.',
      error: e,
      stackTrace: st,
    );
  }
  return shouldScheduleNotifications;
}

/// Loads all timezone data and sets the local timezone for scheduled notifications.
Future<void> _initializeTimezone() async {
  tz.initializeTimeZones();
  final TimezoneInfo localTimezone = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(localTimezone.identifier));
}

/// Locks the device orientation to portrait mode for the entire app.
Future<void> _lockOrientationToPortrait() async {
  try {
    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    getDI<Logger>().i('Screen orientation locked to portrait.');
  } on Exception catch (e, st) {
    getDI<Logger>().f(
      'Failed to lock screen orientation.',
      error: e,
      stackTrace: st,
    );
  }
}
