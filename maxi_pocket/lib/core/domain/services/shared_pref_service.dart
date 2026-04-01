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

  Future<String?> getStringAsync(String key) async => await _sharedPrefAsyncRepo.getStringAsync(key);
  Future<int?> getIntAsync(String key) async => await _sharedPrefAsyncRepo.getIntAsync(key);
  Future<double?> getDoubleAsync(String key) async => await _sharedPrefAsyncRepo.getDoubleAsync(key);
  Future<bool?> getBoolAsync(String key) async => await _sharedPrefAsyncRepo.getBoolAsync(key);
  Future<List<String>?> getStringListAsync(String key) async =>
      await _sharedPrefAsyncRepo.getStringListAsync(key);
  Future<Map<String, Object?>> getAllAsync() async => await _sharedPrefAsyncRepo.getAllAsync();
  Future<Set<String>> getKeysAsync() async => await _sharedPrefAsyncRepo.getKeysAsync();

  Future<void> setStringAsync(String key, String value) async =>
      await _sharedPrefAsyncRepo.setStringAsync(key, value);
  Future<void> setIntAsync(String key, int value) async => await _sharedPrefAsyncRepo.setIntAsync(key, value);
  Future<void> setDoubleAsync(String key, double value) async =>
      await _sharedPrefAsyncRepo.setDoubleAsync(key, value);
  Future<void> setBoolAsync(String key, bool value) async => await _sharedPrefAsyncRepo.setBoolAsync(key, value);
  Future<void> setStringListAsync(String key, List<String> value) async =>
      await _sharedPrefAsyncRepo.setStringListAsync(key, value);

  Future<void> removeAsync(String key) async => await _sharedPrefAsyncRepo.removeAsync(key);
  Future<void> clearAsync() async => await _sharedPrefAsyncRepo.clearAsync();
}

/// Domain-facing API for cached preference reads, implementing [SharedPrefWithCacheRepo].
///
/// Exposes the same operations as the repository so callers can treat the
/// service as the abstraction. Prefer this in composition roots that already
/// provide a [SharedPrefWithCacheRepo] implementation.
class SharedPrefWithCacheService implements SharedPrefWithCacheRepo {
  final SharedPrefWithCacheRepo _sharedPrefWithCacheRepo;

  const SharedPrefWithCacheService(this._sharedPrefWithCacheRepo);

  @override
  String? getStringWithCache(String key) => _sharedPrefWithCacheRepo.getStringWithCache(key);

  @override
  int? getIntWithCache(String key) => _sharedPrefWithCacheRepo.getIntWithCache(key);

  @override
  double? getDoubleWithCache(String key) => _sharedPrefWithCacheRepo.getDoubleWithCache(key);

  @override
  bool? getBoolWithCache(String key) => _sharedPrefWithCacheRepo.getBoolWithCache(key);

  @override
  List<String>? getStringListWithCache(String key) => _sharedPrefWithCacheRepo.getStringListWithCache(key);

  @override
  Object? getValueWithCache(String key) => _sharedPrefWithCacheRepo.getValueWithCache(key);

  @override
  Future<void> setStringWithCache(String key, String value) async =>
      await _sharedPrefWithCacheRepo.setStringWithCache(key, value);

  @override
  Future<void> setIntWithCache(String key, int value) async =>
      await _sharedPrefWithCacheRepo.setIntWithCache(key, value);

  @override
  Future<void> setDoubleWithCache(String key, double value) async =>
      await _sharedPrefWithCacheRepo.setDoubleWithCache(key, value);

  @override
  Future<void> setBoolWithCache(String key, bool value) async =>
      await _sharedPrefWithCacheRepo.setBoolWithCache(key, value);

  @override
  Future<void> setStringListWithCache(String key, List<String> value) async =>
      await _sharedPrefWithCacheRepo.setStringListWithCache(key, value);

  @override
  Future<void> removeWithCache(String key) async => await _sharedPrefWithCacheRepo.removeWithCache(key);

  @override
  Future<void> clearWithCache() async => await _sharedPrefWithCacheRepo.clearWithCache();
}
