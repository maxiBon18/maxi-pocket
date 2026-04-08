import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/domain/entities/app_info.dart';
import 'package:maxi_pocket/core/domain/services/app_info_service.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart';

final FutureProvider<AppInfo> appInfoProvider = FutureProvider<AppInfo>((Ref ref) async {
  final AppInfo appInfo = await getDI<AppInfoService>().getAppInfo();
  return appInfo;
});
