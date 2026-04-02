/// Riverpod notifier for persisted light/dark theme mode.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/domain/services/shared_pref_service.dart';
import 'package:maxi_pocket/core/shared/constants/cache_constants.dart' show CacheKeys;
import 'package:maxi_pocket/core/shared/controllers/di.dart' show getDI;
import 'package:maxi_pocket/core/shared/utils/enums.dart';
import 'package:maxi_pocket/core/shared/utils/extensions.dart';
import 'package:maxi_pocket/core/shared/utils/methods.dart' show isDarkMode;

/// Exposes the current [MaxiPocketThemeMode] and persists it via [SharedPrefWithCacheService].
///
/// Watch this in the widget tree (for example [MaxiPocketApp]) so the UI rebuilds when
/// the theme changes.
final themeProvider = NotifierProvider<ThemeViewModel, MaxiPocketThemeMode>(ThemeViewModel.new);

/// Loads and saves the user’s light/dark preference, with a platform default when unset.
///
/// On first launch, if nothing is stored under [CacheKeys.themeMode], [build] returns
/// light or dark based on [isDarkMode]. [setThemeMode] writes the enum name and updates
/// [state]; failures are logged and do not throw to callers.
class ThemeViewModel extends Notifier<MaxiPocketThemeMode> {
  final SharedPrefWithCacheService _sharedPrefWithCacheService = getDI<SharedPrefWithCacheService>();
  final Logger _logger = getDI<Logger>();

  @override
  MaxiPocketThemeMode build() {
    final String? themeMode = _sharedPrefWithCacheService.getStringWithCache(CacheKeys.themeMode);

    if (themeMode == null) {
      return isDarkMode ? MaxiPocketThemeMode.dark : MaxiPocketThemeMode.light;
    }

    return themeMode.toMaxiPocketThemeMode;
  }

  /// Persists [themeMode] and updates notifier [state].
  ///
  /// On storage errors, logs via [Logger] and leaves [state] unchanged.
  Future<void> setThemeMode(MaxiPocketThemeMode themeMode) async {
    try {
      await _sharedPrefWithCacheService.setStringWithCache(CacheKeys.themeMode, themeMode.name);
      state = themeMode;
    } catch (e, stacktrace) {
      _logger.e('Error setting theme mode: $e', stackTrace: stacktrace);
    }
  }
}
