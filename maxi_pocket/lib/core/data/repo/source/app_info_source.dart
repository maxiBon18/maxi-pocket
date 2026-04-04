import 'package:maxi_pocket/core/data/repo/source/dto/app_info_dto.dart';

/// Data source interface for reading app package metadata.
abstract class AppInfoSource {
  /// Returns raw package metadata as a DTO.
  Future<AppInfoDto> getAppInfo();
}
