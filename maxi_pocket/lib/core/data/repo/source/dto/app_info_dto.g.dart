// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppInfoDto _$AppInfoDtoFromJson(Map<String, dynamic> json) => _AppInfoDto(
  buildNumber: json['buildNumber'] as String?,
  version: json['version'] as String?,
  appName: json['appName'] as String?,
  packageName: json['packageName'] as String?,
);

Map<String, dynamic> _$AppInfoDtoToJson(_AppInfoDto instance) =>
    <String, dynamic>{
      'buildNumber': instance.buildNumber,
      'version': instance.version,
      'appName': instance.appName,
      'packageName': instance.packageName,
    };
