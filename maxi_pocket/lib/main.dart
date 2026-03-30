import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/presentation/ux/app.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart';
import 'package:maxi_pocket/core/shared/utils/loggers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _lockOrientationToPortrait();
  setupAllDependencies();
  if (kDebugMode) {
    runApp(ProviderScope(observers: <ProviderObserver>[getDI<ProviderLogger>()], child: const MaxiPocketApp()));
  } else {
    runApp(const ProviderScope(child: MaxiPocketApp()));
  }
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
    getDI<Logger>().f('Failed to lock screen orientation.', error: e, stackTrace: st);
  }
}
