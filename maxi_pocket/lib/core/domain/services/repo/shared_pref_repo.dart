/// Repository contracts for app preferences exposed to the domain layer.
///
/// [SharedPrefAsyncRepo] is for code that can await every read and write.
/// [SharedPrefWithCacheRepo] is for code that needs immediate reads from a
/// cache after the instance has been opened. Implementations live under
/// `lib/core/data/repo/`.
library;

/// Persists and loads preference values using asynchronous reads and writes.
///
/// Missing keys are represented as `null` from `get*` methods.
abstract class SharedPrefAsyncRepo {
  Future<String?> getStringAsync(String key);
  Future<int?> getIntAsync(String key);
  Future<double?> getDoubleAsync(String key);
  Future<bool?> getBoolAsync(String key);
  Future<List<String>?> getStringListAsync(String key);
  Future<Map<String, Object?>> getAllAsync();
  Future<Set<String>> getKeysAsync();

  Future<void> setStringAsync(String key, String value);
  Future<void> setIntAsync(String key, int value);
  Future<void> setDoubleAsync(String key, double value);
  Future<void> setBoolAsync(String key, bool value);
  Future<void> setStringListAsync(String key, List<String> value);

  Future<void> removeAsync(String key);
  Future<void> clearAsync();
}

/// Loads preference values synchronously from cache and persists changes asynchronously.
///
/// Use when the backing [SharedPreferencesWithCache] has already been obtained
/// (for example after `createSharedPreferencesWithCache`). Typed getters return
/// `null` if [key] is missing or the stored type does not match.
abstract class SharedPrefWithCacheRepo {
  String? getStringWithCache(String key);
  int? getIntWithCache(String key);
  double? getDoubleWithCache(String key);
  bool? getBoolWithCache(String key);
  List<String>? getStringListWithCache(String key);
  Object? getValueWithCache(String key);

  Future<void> setStringWithCache(String key, String value);
  Future<void> setIntWithCache(String key, int value);
  Future<void> setDoubleWithCache(String key, double value);
  Future<void> setBoolWithCache(String key, bool value);
  Future<void> setStringListWithCache(String key, List<String> value);

  Future<void> removeWithCache(String key);
  Future<void> clearWithCache();
}
