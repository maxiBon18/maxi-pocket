/// Domain services that wrap shared preference repositories for use cases and UI.
library;

import 'package:maxi_pocket/core/domain/services/repo/shared_pref_repo.dart';

/// Domain-facing API for asynchronous preference access via [SharedPrefAsyncRepo].
///
/// View models and use cases depend on this type instead of the repository
/// interface when you want a named service in dependency injection. Behavior
/// matches [SharedPrefAsyncRepo]: missing keys yield `null` from getters.
///
/// Example:
///
/// ```dart
/// final greeting = await sharedPrefAsyncService.getStringAsync('greeting_key');
/// ```
class SharedPrefAsyncService {
  final SharedPrefAsyncRepo _sharedPrefAsyncRepo;

  const SharedPrefAsyncService(this._sharedPrefAsyncRepo);

  Future<String?> getStringAsync(String key) =>
      _sharedPrefAsyncRepo.getStringAsync(key);
  Future<int?> getIntAsync(String key) => _sharedPrefAsyncRepo.getIntAsync(key);
  Future<double?> getDoubleAsync(String key) =>
      _sharedPrefAsyncRepo.getDoubleAsync(key);
  Future<bool?> getBoolAsync(String key) =>
      _sharedPrefAsyncRepo.getBoolAsync(key);
  Future<List<String>?> getStringListAsync(String key) =>
      _sharedPrefAsyncRepo.getStringListAsync(key);
  Future<Map<String, Object?>> getAllAsync() =>
      _sharedPrefAsyncRepo.getAllAsync();
  Future<Set<String>> getKeysAsync() => _sharedPrefAsyncRepo.getKeysAsync();

  Future<void> setStringAsync(String key, String value) =>
      _sharedPrefAsyncRepo.setStringAsync(key, value);
  Future<void> setIntAsync(String key, int value) =>
      _sharedPrefAsyncRepo.setIntAsync(key, value);
  Future<void> setDoubleAsync(String key, double value) =>
      _sharedPrefAsyncRepo.setDoubleAsync(key, value);
  Future<void> setBoolAsync(String key, bool value) =>
      _sharedPrefAsyncRepo.setBoolAsync(key, value);
  Future<void> setStringListAsync(String key, List<String> value) =>
      _sharedPrefAsyncRepo.setStringListAsync(key, value);

  Future<void> removeAsync(String key) => _sharedPrefAsyncRepo.removeAsync(key);
  Future<void> clearAsync() => _sharedPrefAsyncRepo.clearAsync();
}

/// Domain-facing API for cached preference reads, implementing [SharedPrefWithCacheRepo].
///
/// Exposes the same operations as the repository so callers can treat the
/// service as the abstraction. Prefer this in composition roots that already
/// provide a [SharedPrefWithCacheRepo] implementation.
class SharedPrefWithCacheService {
  final SharedPrefWithCacheRepo _sharedPrefWithCacheRepo;

  const SharedPrefWithCacheService(this._sharedPrefWithCacheRepo);

  String? getStringWithCache(String key) =>
      _sharedPrefWithCacheRepo.getStringWithCache(key);

  int? getIntWithCache(String key) =>
      _sharedPrefWithCacheRepo.getIntWithCache(key);

  double? getDoubleWithCache(String key) =>
      _sharedPrefWithCacheRepo.getDoubleWithCache(key);

  bool? getBoolWithCache(String key) =>
      _sharedPrefWithCacheRepo.getBoolWithCache(key);

  List<String>? getStringListWithCache(String key) =>
      _sharedPrefWithCacheRepo.getStringListWithCache(key);

  Object? getValueWithCache(String key) =>
      _sharedPrefWithCacheRepo.getValueWithCache(key);

  Future<void> setStringWithCache(String key, String value) =>
      _sharedPrefWithCacheRepo.setStringWithCache(key, value);

  Future<void> setIntWithCache(String key, int value) =>
      _sharedPrefWithCacheRepo.setIntWithCache(key, value);

  Future<void> setDoubleWithCache(String key, double value) =>
      _sharedPrefWithCacheRepo.setDoubleWithCache(key, value);

  Future<void> setBoolWithCache(String key, bool value) =>
      _sharedPrefWithCacheRepo.setBoolWithCache(key, value);

  Future<void> setStringListWithCache(String key, List<String> value) =>
      _sharedPrefWithCacheRepo.setStringListWithCache(key, value);

  Future<void> removeWithCache(String key) =>
      _sharedPrefWithCacheRepo.removeWithCache(key);

  Future<void> clear() => _sharedPrefWithCacheRepo.clearWithCache();
}
