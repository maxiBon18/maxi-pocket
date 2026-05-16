import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maxi_pocket/core/domain/entities/app_info.dart';

part 'app_info_dto.freezed.dart';
part 'app_info_dto.g.dart';

/// DTO for app package metadata returned by [AppInfoSource].
@Freezed()
abstract class AppInfoDto with _$AppInfoDto {
  const AppInfoDto._();

  const factory AppInfoDto({
    String? buildNumber,
    String? version,
    String? appName,
    String? packageName,
  }) = _AppInfoDto;

  factory AppInfoDto.fromJson(Map<String, Object?> json) =>
      _$AppInfoDtoFromJson(json);

  AppInfo toEntity() => AppInfo(
    buildNumber: buildNumber,
    version: version,
    appName: appName,
    packageName: packageName,
  );
}
