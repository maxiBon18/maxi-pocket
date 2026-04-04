import 'package:maxi_pocket/core/domain/entities/app_info.dart';
import 'package:maxi_pocket/core/domain/services/repo/app_info_repo.dart';

/// Use case for fetching application package information.
class AppInfoService {
  final AppInfoRepo _appInfoRepo;

  const AppInfoService(this._appInfoRepo);

  Future<AppInfo> getAppInfo() => _appInfoRepo.getAppInfo();
}
