import 'package:flutter/services.dart' show PlatformException;
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:maxi_pocket/core/data/repo/source/app_info_source.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/app_info_dto.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart' show getDI;

/// Reads package metadata from the OS via [PackageInfo.fromPlatform].
class AppInfoSourceImpl implements AppInfoSource {
  @override
  Future<AppInfoDto> getAppInfo() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return AppInfoDto(
        appName: packageInfo.appName,
        packageName: packageInfo.packageName,
        version: packageInfo.version,
        buildNumber: packageInfo.buildNumber,
      );
    } on PlatformException catch (e, st) {
      getDI<Logger>().e(
        'Failed to read package info from platform.',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }
}
