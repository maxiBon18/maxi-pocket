import 'package:maxi_pocket/core/data/repo/source/app_info_source.dart';
import 'package:maxi_pocket/core/domain/entities/app_info.dart';
import 'package:maxi_pocket/core/domain/services/repo/app_info_repo.dart';

/// Retrieves app info from [AppInfoSource] and maps it to [AppInfo].
class AppInfoRepoImpl implements AppInfoRepo {
  final AppInfoSource _appInfoSource;

  const AppInfoRepoImpl(this._appInfoSource);

  @override
  Future<AppInfo> getAppInfo() async => (await _appInfoSource.getAppInfo()).toEntity();
}
