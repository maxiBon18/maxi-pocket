import 'package:maxi_pocket/core/data/repo/source/shared_pref_source.dart';
import 'package:maxi_pocket/core/domain/services/repo/shared_pref_repo.dart';

/// [SharedPrefAsyncRepo] implementation that forwards to [SharedPrefAsyncSource].
///
/// Keeps the domain repository free of `shared_preferences` types while
/// preserving one-to-one behavior with the underlying source.
class SharedPrefAsyncRepoImpl implements SharedPrefAsyncRepo {
  final SharedPrefAsyncSource _sharedPrefAsyncSource;

  const SharedPrefAsyncRepoImpl(this._sharedPrefAsyncSource);

  @override
  Future<String?> getStringAsync(String key) async => await _sharedPrefAsyncSource.getStringAsync(key);

  @override
  Future<int?> getIntAsync(String key) async => await _sharedPrefAsyncSource.getIntAsync(key);

  @override
  Future<double?> getDoubleAsync(String key) async => await _sharedPrefAsyncSource.getDoubleAsync(key);

  @override
  Future<bool?> getBoolAsync(String key) async => await _sharedPrefAsyncSource.getBoolAsync(key);

  @override
  Future<List<String>?> getStringListAsync(String key) async =>
      await _sharedPrefAsyncSource.getStringListAsync(key);

  @override
  Future<Map<String, Object?>> getAllAsync() async => await _sharedPrefAsyncSource.getAllAsync();

  @override
  Future<Set<String>> getKeysAsync() async => await _sharedPrefAsyncSource.getKeysAsync();

  @override
  Future<void> setStringAsync(String key, String value) async =>
      await _sharedPrefAsyncSource.setStringAsync(key, value);

  @override
  Future<void> setIntAsync(String key, int value) async => await _sharedPrefAsyncSource.setIntAsync(key, value);

  @override
  Future<void> setDoubleAsync(String key, double value) async =>
      await _sharedPrefAsyncSource.setDoubleAsync(key, value);

  @override
  Future<void> setBoolAsync(String key, bool value) async =>
      await _sharedPrefAsyncSource.setBoolAsync(key, value);

  @override
  Future<void> setStringListAsync(String key, List<String> value) async =>
      await _sharedPrefAsyncSource.setStringListAsync(key, value);

  @override
  Future<void> removeAsync(String key) async => await _sharedPrefAsyncSource.removeAsync(key);

  @override
  Future<void> clearAsync() async => await _sharedPrefAsyncSource.clearAsync();
}

/// [SharedPrefWithCacheRepo] implementation that forwards to [SharedPrefWithCacheSource].
class SharedPrefWithCacheRepoImpl implements SharedPrefWithCacheRepo {
  final SharedPrefWithCacheSource _sharedPrefWithCacheSource;

  const SharedPrefWithCacheRepoImpl(this._sharedPrefWithCacheSource);

  @override
  String? getStringWithCache(String key) => _sharedPrefWithCacheSource.getStringWithCache(key);

  @override
  int? getIntWithCache(String key) => _sharedPrefWithCacheSource.getIntWithCache(key);

  @override
  double? getDoubleWithCache(String key) => _sharedPrefWithCacheSource.getDoubleWithCache(key);

  @override
  bool? getBoolWithCache(String key) => _sharedPrefWithCacheSource.getBoolWithCache(key);

  @override
  List<String>? getStringListWithCache(String key) => _sharedPrefWithCacheSource.getStringListWithCache(key);

  @override
  Object? getValueWithCache(String key) => _sharedPrefWithCacheSource.getValueWithCache(key);

  @override
  Future<void> setStringWithCache(String key, String value) async =>
      await _sharedPrefWithCacheSource.setStringWithCache(key, value);

  @override
  Future<void> setIntWithCache(String key, int value) async =>
      await _sharedPrefWithCacheSource.setIntWithCache(key, value);

  @override
  Future<void> setDoubleWithCache(String key, double value) async =>
      await _sharedPrefWithCacheSource.setDoubleWithCache(key, value);

  @override
  Future<void> setBoolWithCache(String key, bool value) async =>
      await _sharedPrefWithCacheSource.setBoolWithCache(key, value);

  @override
  Future<void> setStringListWithCache(String key, List<String> value) async =>
      await _sharedPrefWithCacheSource.setStringListWithCache(key, value);

  @override
  Future<void> removeWithCache(String key) async => await _sharedPrefWithCacheSource.removeWithCache(key);

  @override
  Future<void> clearWithCache() async => await _sharedPrefWithCacheSource.clearWithCache();
}
