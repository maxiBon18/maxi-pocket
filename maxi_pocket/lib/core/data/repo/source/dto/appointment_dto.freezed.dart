// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppointmentDto {

 ExpenseDbDto get expense; String get location;
/// Create a copy of AppointmentDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppointmentDtoCopyWith<AppointmentDto> get copyWith => _$AppointmentDtoCopyWithImpl<AppointmentDto>(this as AppointmentDto, _$identity);

  /// Serializes this AppointmentDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppointmentDto&&(identical(other.expense, expense) || other.expense == expense)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expense,location);

@override
String toString() {
  return 'AppointmentDto(expense: $expense, location: $location)';
}


}

/// @nodoc
abstract mixin class $AppointmentDtoCopyWith<$Res>  {
  factory $AppointmentDtoCopyWith(AppointmentDto value, $Res Function(AppointmentDto) _then) = _$AppointmentDtoCopyWithImpl;
@useResult
$Res call({
 ExpenseDbDto expense, String location
});


$ExpenseDbDtoCopyWith<$Res> get expense;

}
/// @nodoc
class _$AppointmentDtoCopyWithImpl<$Res>
    implements $AppointmentDtoCopyWith<$Res> {
  _$AppointmentDtoCopyWithImpl(this._self, this._then);

  final AppointmentDto _self;
  final $Res Function(AppointmentDto) _then;

/// Create a copy of AppointmentDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expense = null,Object? location = null,}) {
  return _then(_self.copyWith(
expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as ExpenseDbDto,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of AppointmentDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseDbDtoCopyWith<$Res> get expense {
  
  return $ExpenseDbDtoCopyWith<$Res>(_self.expense, (value) {
    return _then(_self.copyWith(expense: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppointmentDto].
extension AppointmentDtoPatterns on AppointmentDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppointmentDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppointmentDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppointmentDto value)  $default,){
final _that = this;
switch (_that) {
case _AppointmentDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppointmentDto value)?  $default,){
final _that = this;
switch (_that) {
case _AppointmentDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ExpenseDbDto expense,  String location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppointmentDto() when $default != null:
return $default(_that.expense,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ExpenseDbDto expense,  String location)  $default,) {final _that = this;
switch (_that) {
case _AppointmentDto():
return $default(_that.expense,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ExpenseDbDto expense,  String location)?  $default,) {final _that = this;
switch (_that) {
case _AppointmentDto() when $default != null:
return $default(_that.expense,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppointmentDto extends AppointmentDto {
  const _AppointmentDto({required this.expense, required this.location}): super._();
  factory _AppointmentDto.fromJson(Map<String, dynamic> json) => _$AppointmentDtoFromJson(json);

@override final  ExpenseDbDto expense;
@override final  String location;

/// Create a copy of AppointmentDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppointmentDtoCopyWith<_AppointmentDto> get copyWith => __$AppointmentDtoCopyWithImpl<_AppointmentDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppointmentDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppointmentDto&&(identical(other.expense, expense) || other.expense == expense)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expense,location);

@override
String toString() {
  return 'AppointmentDto(expense: $expense, location: $location)';
}


}

/// @nodoc
abstract mixin class _$AppointmentDtoCopyWith<$Res> implements $AppointmentDtoCopyWith<$Res> {
  factory _$AppointmentDtoCopyWith(_AppointmentDto value, $Res Function(_AppointmentDto) _then) = __$AppointmentDtoCopyWithImpl;
@override @useResult
$Res call({
 ExpenseDbDto expense, String location
});


@override $ExpenseDbDtoCopyWith<$Res> get expense;

}
/// @nodoc
class __$AppointmentDtoCopyWithImpl<$Res>
    implements _$AppointmentDtoCopyWith<$Res> {
  __$AppointmentDtoCopyWithImpl(this._self, this._then);

  final _AppointmentDto _self;
  final $Res Function(_AppointmentDto) _then;

/// Create a copy of AppointmentDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expense = null,Object? location = null,}) {
  return _then(_AppointmentDto(
expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as ExpenseDbDto,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of AppointmentDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseDbDtoCopyWith<$Res> get expense {
  
  return $ExpenseDbDtoCopyWith<$Res>(_self.expense, (value) {
    return _then(_self.copyWith(expense: value));
  });
}
}

// dart format on
