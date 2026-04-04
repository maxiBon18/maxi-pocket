// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_info_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppInfoDto {

 String? get buildNumber; String? get version; String? get appName; String? get packageName;
/// Create a copy of AppInfoDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppInfoDtoCopyWith<AppInfoDto> get copyWith => _$AppInfoDtoCopyWithImpl<AppInfoDto>(this as AppInfoDto, _$identity);

  /// Serializes this AppInfoDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppInfoDto&&(identical(other.buildNumber, buildNumber) || other.buildNumber == buildNumber)&&(identical(other.version, version) || other.version == version)&&(identical(other.appName, appName) || other.appName == appName)&&(identical(other.packageName, packageName) || other.packageName == packageName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,buildNumber,version,appName,packageName);

@override
String toString() {
  return 'AppInfoDto(buildNumber: $buildNumber, version: $version, appName: $appName, packageName: $packageName)';
}


}

/// @nodoc
abstract mixin class $AppInfoDtoCopyWith<$Res>  {
  factory $AppInfoDtoCopyWith(AppInfoDto value, $Res Function(AppInfoDto) _then) = _$AppInfoDtoCopyWithImpl;
@useResult
$Res call({
 String? buildNumber, String? version, String? appName, String? packageName
});




}
/// @nodoc
class _$AppInfoDtoCopyWithImpl<$Res>
    implements $AppInfoDtoCopyWith<$Res> {
  _$AppInfoDtoCopyWithImpl(this._self, this._then);

  final AppInfoDto _self;
  final $Res Function(AppInfoDto) _then;

/// Create a copy of AppInfoDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? buildNumber = freezed,Object? version = freezed,Object? appName = freezed,Object? packageName = freezed,}) {
  return _then(_self.copyWith(
buildNumber: freezed == buildNumber ? _self.buildNumber : buildNumber // ignore: cast_nullable_to_non_nullable
as String?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,appName: freezed == appName ? _self.appName : appName // ignore: cast_nullable_to_non_nullable
as String?,packageName: freezed == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppInfoDto].
extension AppInfoDtoPatterns on AppInfoDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppInfoDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppInfoDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppInfoDto value)  $default,){
final _that = this;
switch (_that) {
case _AppInfoDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppInfoDto value)?  $default,){
final _that = this;
switch (_that) {
case _AppInfoDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? buildNumber,  String? version,  String? appName,  String? packageName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppInfoDto() when $default != null:
return $default(_that.buildNumber,_that.version,_that.appName,_that.packageName);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? buildNumber,  String? version,  String? appName,  String? packageName)  $default,) {final _that = this;
switch (_that) {
case _AppInfoDto():
return $default(_that.buildNumber,_that.version,_that.appName,_that.packageName);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? buildNumber,  String? version,  String? appName,  String? packageName)?  $default,) {final _that = this;
switch (_that) {
case _AppInfoDto() when $default != null:
return $default(_that.buildNumber,_that.version,_that.appName,_that.packageName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppInfoDto extends AppInfoDto {
  const _AppInfoDto({this.buildNumber, this.version, this.appName, this.packageName}): super._();
  factory _AppInfoDto.fromJson(Map<String, dynamic> json) => _$AppInfoDtoFromJson(json);

@override final  String? buildNumber;
@override final  String? version;
@override final  String? appName;
@override final  String? packageName;

/// Create a copy of AppInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppInfoDtoCopyWith<_AppInfoDto> get copyWith => __$AppInfoDtoCopyWithImpl<_AppInfoDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppInfoDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppInfoDto&&(identical(other.buildNumber, buildNumber) || other.buildNumber == buildNumber)&&(identical(other.version, version) || other.version == version)&&(identical(other.appName, appName) || other.appName == appName)&&(identical(other.packageName, packageName) || other.packageName == packageName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,buildNumber,version,appName,packageName);

@override
String toString() {
  return 'AppInfoDto(buildNumber: $buildNumber, version: $version, appName: $appName, packageName: $packageName)';
}


}

/// @nodoc
abstract mixin class _$AppInfoDtoCopyWith<$Res> implements $AppInfoDtoCopyWith<$Res> {
  factory _$AppInfoDtoCopyWith(_AppInfoDto value, $Res Function(_AppInfoDto) _then) = __$AppInfoDtoCopyWithImpl;
@override @useResult
$Res call({
 String? buildNumber, String? version, String? appName, String? packageName
});




}
/// @nodoc
class __$AppInfoDtoCopyWithImpl<$Res>
    implements _$AppInfoDtoCopyWith<$Res> {
  __$AppInfoDtoCopyWithImpl(this._self, this._then);

  final _AppInfoDto _self;
  final $Res Function(_AppInfoDto) _then;

/// Create a copy of AppInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? buildNumber = freezed,Object? version = freezed,Object? appName = freezed,Object? packageName = freezed,}) {
  return _then(_AppInfoDto(
buildNumber: freezed == buildNumber ? _self.buildNumber : buildNumber // ignore: cast_nullable_to_non_nullable
as String?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,appName: freezed == appName ? _self.appName : appName // ignore: cast_nullable_to_non_nullable
as String?,packageName: freezed == packageName ? _self.packageName : packageName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
