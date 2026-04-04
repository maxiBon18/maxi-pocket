import 'package:flutter/foundation.dart' show immutable;

/// Snapshot of the app's package metadata retrieved at runtime.
///
/// All fields are nullable because [PackageInfo.fromPlatform] may not return
/// every value on all platforms.
@immutable
class AppInfo {
  final String? version;
  final String? buildNumber;
  final String? packageName;
  final String? appName;

  const AppInfo({this.version, this.buildNumber, this.packageName, this.appName});

  @override
  String toString() {
    return 'AppInfo(version: $version, buildNumber: $buildNumber, packageName: $packageName, appName: $appName)';
  }
}
