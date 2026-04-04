import 'package:maxi_pocket/core/domain/entities/app_info.dart';

/// Repository interface for reading app package metadata.
abstract class AppInfoRepo {
  /// Returns the current app info from the underlying data source.
  Future<AppInfo> getAppInfo();
}
