import 'package:maxi_pocket/core/data/repo/source/shared_pref_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [SharedPrefAsyncSource] implementation delegating to [SharedPreferencesAsync].
///
/// Construct with an instance from `SharedPreferencesAsync` APIs (for example
/// `SharedPreferencesAsync.instance` or a test fake). Behavior matches the
/// plugin: I/O is asynchronous and reads reflect persisted data after awaits
/// complete.
class SharedPrefAsyncSourceImpl implements SharedPrefAsyncSource {
  final SharedPreferencesAsync _sharedPreferencesAsync;

  const SharedPrefAsyncSourceImpl(this._sharedPreferencesAsync);

  @override
  Future<String?> getStringAsync(String key) async => await _sharedPreferencesAsync.getString(key);

  @override
  Future<int?> getIntAsync(String key) async => await _sharedPreferencesAsync.getInt(key);

  @override
  Future<double?> getDoubleAsync(String key) async => await _sharedPreferencesAsync.getDouble(key);

  @override
  Future<bool?> getBoolAsync(String key) async => await _sharedPreferencesAsync.getBool(key);

  @override
  Future<List<String>?> getStringListAsync(String key) async => await _sharedPreferencesAsync.getStringList(key);

  @override
  Future<Map<String, Object?>> getAllAsync() async => await _sharedPreferencesAsync.getAll();

  @override
  Future<Set<String>> getKeysAsync() async => await _sharedPreferencesAsync.getKeys();

  @override
  Future<void> setStringAsync(String key, String value) async => await _sharedPreferencesAsync.setString(key, value);

  @override
  Future<void> setIntAsync(String key, int value) async => await _sharedPreferencesAsync.setInt(key, value);

  @override
  Future<void> setDoubleAsync(String key, double value) async =>
      await _sharedPreferencesAsync.setDouble(key, value);

  @override
  Future<void> setBoolAsync(String key, bool value) async => await _sharedPreferencesAsync.setBool(key, value);

  @override
  Future<void> setStringListAsync(String key, List<String> value) async =>
      await _sharedPreferencesAsync.setStringList(key, value);

  @override
  Future<void> removeAsync(String key) async => await _sharedPreferencesAsync.remove(key);

  @override
  Future<void> clearAsync() async => await _sharedPreferencesAsync.clear();
}

/// [SharedPrefWithCacheSource] implementation delegating to [SharedPreferencesWithCache].
///
/// Reads use the cache maintained by the plugin; writes still complete
/// asynchronously. Obtain [SharedPreferencesWithCache] via
/// `createSharedPreferencesWithCache` before injecting this implementation.
class SharedPrefWithCacheSourceImpl implements SharedPrefWithCacheSource {
  final SharedPreferencesWithCache _sharedPreferencesWithCache;

  const SharedPrefWithCacheSourceImpl(this._sharedPreferencesWithCache);

  @override
  String? getStringWithCache(String key) => _sharedPreferencesWithCache.getString(key);

  @override
  int? getIntWithCache(String key) => _sharedPreferencesWithCache.getInt(key);

  @override
  double? getDoubleWithCache(String key) => _sharedPreferencesWithCache.getDouble(key);

  @override
  bool? getBoolWithCache(String key) => _sharedPreferencesWithCache.getBool(key);

  @override
  List<String>? getStringListWithCache(String key) => _sharedPreferencesWithCache.getStringList(key);

  @override
  Object? getValueWithCache(String key) => _sharedPreferencesWithCache.get(key);

  @override
  Future<void> setStringWithCache(String key, String value) async =>
      await _sharedPreferencesWithCache.setString(key, value);

  @override
  Future<void> setIntWithCache(String key, int value) async => await _sharedPreferencesWithCache.setInt(key, value);

  @override
  Future<void> setDoubleWithCache(String key, double value) async =>
      await _sharedPreferencesWithCache.setDouble(key, value);

  @override
  Future<void> setBoolWithCache(String key, bool value) async =>
      await _sharedPreferencesWithCache.setBool(key, value);

  @override
  Future<void> setStringListWithCache(String key, List<String> value) async =>
      await _sharedPreferencesWithCache.setStringList(key, value);

  @override
  Future<void> removeWithCache(String key) async => await _sharedPreferencesWithCache.remove(key);

  @override
  Future<void> clearWithCache() async => await _sharedPreferencesWithCache.clear();
}
