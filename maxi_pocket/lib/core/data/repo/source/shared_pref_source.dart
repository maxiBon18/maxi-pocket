/// Contracts for reading and writing app preferences via the data layer.
///
/// Two variants mirror the `shared_preferences` plugin: fully asynchronous
/// operations ([SharedPrefAsyncSource]) and synchronous reads with cached
/// values ([SharedPrefWithCacheSource]). Inject implementations from the data
/// layer; domain code should depend on repository interfaces instead.
library;

/// Reads and writes preference keys using asynchronous platform storage.
///
/// Each `get*` method returns `null` when [key] has no stored value. Writes
/// persist to disk according to the underlying [SharedPreferencesAsync] rules.
abstract class SharedPrefAsyncSource {
  Future<String?> getStringAsync(String key);
  Future<int?> getIntAsync(String key);
  Future<double?> getDoubleAsync(String key);
  Future<bool?> getBoolAsync(String key);
  Future<List<String>?> getStringListAsync(String key);

  /// All key-value pairs currently stored in this preferences instance.
  Future<Map<String, Object?>> getAllAsync();

  /// All keys currently stored in this preferences instance.
  Future<Set<String>> getKeysAsync();

  Future<void> setStringAsync(String key, String value);
  Future<void> setIntAsync(String key, int value);
  Future<void> setDoubleAsync(String key, double value);
  Future<void> setBoolAsync(String key, bool value);
  Future<void> setStringListAsync(String key, List<String> value);

  Future<void> removeAsync(String key);

  /// Removes every key-value pair in this preferences instance.
  Future<void> clearAsync();
}

/// Reads preferences synchronously from an in-memory cache and writes asynchronously.
///
/// [getValueWithCache] returns the raw stored object when the type is not
/// covered by typed getters. Read methods return `null` when [key] is missing
/// or the type does not match.
abstract class SharedPrefWithCacheSource {
  String? getStringWithCache(String key);
  int? getIntWithCache(String key);
  double? getDoubleWithCache(String key);
  bool? getBoolWithCache(String key);
  List<String>? getStringListWithCache(String key);

  /// The stored value for [key], or `null` if absent or not representable.
  Object? getValueWithCache(String key);

  Future<void> setStringWithCache(String key, String value);
  Future<void> setIntWithCache(String key, int value);
  Future<void> setDoubleWithCache(String key, double value);
  Future<void> setBoolWithCache(String key, bool value);
  Future<void> setStringListWithCache(String key, List<String> value);

  Future<void> removeWithCache(String key);
  Future<void> clearWithCache();
}
