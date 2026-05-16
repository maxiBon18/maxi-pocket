/// SharedPreferences key strings used to persist app state across sessions.
class CacheKeys {
  /// Key for the persisted theme mode selection (light / dark / system).
  static const String themeMode = 'themeMode';

  /// Key for the flag indicating whether push notifications are enabled by the user.
  static const String notificationsEnabled = 'notificationsEnabled';

  /// Key for the flag recording whether the user has completed the onboarding flow.
  static const String onboardingCompleted = 'onboardingCompleted';

  /// Convenience set containing every key, useful for cache invalidation or inspection.
  static const Set<String> allKeys = <String>{
    themeMode,
    notificationsEnabled,
    onboardingCompleted,
  };
}
