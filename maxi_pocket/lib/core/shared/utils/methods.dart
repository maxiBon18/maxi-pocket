/// Small platform helpers that do not belong in a specific feature.
library;

import 'dart:ui' show Brightness, PlatformDispatcher;

/// Whether the current platform brightness is dark, from [PlatformDispatcher].
///
/// Used as a fallback when no theme preference is stored yet. This reflects the
/// system setting at read time; it does not listen for changes by itself.
bool get isDarkMode => PlatformDispatcher.instance.platformBrightness == Brightness.dark;
