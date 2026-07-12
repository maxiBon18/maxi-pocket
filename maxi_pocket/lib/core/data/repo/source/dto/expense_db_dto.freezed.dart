// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_db_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExpenseDbDto {

 String get name; MaxiPocketExpensesType get eventType; DateTime get eventDate; String get localeTimezone; BigInt? get id;
/// Create a copy of ExpenseDbDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseDbDtoCopyWith<ExpenseDbDto> get copyWith => _$ExpenseDbDtoCopyWithImpl<ExpenseDbDto>(this as ExpenseDbDto, _$identity);

  /// Serializes this ExpenseDbDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseDbDto&&(identical(other.name, name) || other.name == name)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.eventDate, eventDate) || other.eventDate == eventDate)&&(identical(other.localeTimezone, localeTimezone) || other.localeTimezone == localeTimezone)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,eventType,eventDate,localeTimezone,id);

@override
String toString() {
  return 'ExpenseDbDto(name: $name, eventType: $eventType, eventDate: $eventDate, localeTimezone: $localeTimezone, id: $id)';
}


}

/// @nodoc
abstract mixin class $ExpenseDbDtoCopyWith<$Res>  {
  factory $ExpenseDbDtoCopyWith(ExpenseDbDto value, $Res Function(ExpenseDbDto) _then) = _$ExpenseDbDtoCopyWithImpl;
@useResult
$Res call({
 String name, MaxiPocketExpensesType eventType, DateTime eventDate, String localeTimezone, BigInt? id
});




}
/// @nodoc
class _$ExpenseDbDtoCopyWithImpl<$Res>
    implements $ExpenseDbDtoCopyWith<$Res> {
  _$ExpenseDbDtoCopyWithImpl(this._self, this._then);

  final ExpenseDbDto _self;
  final $Res Function(ExpenseDbDto) _then;

/// Create a copy of ExpenseDbDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? eventType = null,Object? eventDate = null,Object? localeTimezone = null,Object? id = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as MaxiPocketExpensesType,eventDate: null == eventDate ? _self.eventDate : eventDate // ignore: cast_nullable_to_non_nullable
as DateTime,localeTimezone: null == localeTimezone ? _self.localeTimezone : localeTimezone // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as BigInt?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseDbDto].
extension ExpenseDbDtoPatterns on ExpenseDbDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseDbDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseDbDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseDbDto value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseDbDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseDbDto value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseDbDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  MaxiPocketExpensesType eventType,  DateTime eventDate,  String localeTimezone,  BigInt? id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseDbDto() when $default != null:
return $default(_that.name,_that.eventType,_that.eventDate,_that.localeTimezone,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  MaxiPocketExpensesType eventType,  DateTime eventDate,  String localeTimezone,  BigInt? id)  $default,) {final _that = this;
switch (_that) {
case _ExpenseDbDto():
return $default(_that.name,_that.eventType,_that.eventDate,_that.localeTimezone,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  MaxiPocketExpensesType eventType,  DateTime eventDate,  String localeTimezone,  BigInt? id)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseDbDto() when $default != null:
return $default(_that.name,_that.eventType,_that.eventDate,_that.localeTimezone,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseDbDto extends ExpenseDbDto {
  const _ExpenseDbDto({required this.name, required this.eventType, required this.eventDate, required this.localeTimezone, this.id}): super._();
  factory _ExpenseDbDto.fromJson(Map<String, dynamic> json) => _$ExpenseDbDtoFromJson(json);

@override final  String name;
@override final  MaxiPocketExpensesType eventType;
@override final  DateTime eventDate;
@override final  String localeTimezone;
@override final  BigInt? id;

/// Create a copy of ExpenseDbDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseDbDtoCopyWith<_ExpenseDbDto> get copyWith => __$ExpenseDbDtoCopyWithImpl<_ExpenseDbDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseDbDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseDbDto&&(identical(other.name, name) || other.name == name)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.eventDate, eventDate) || other.eventDate == eventDate)&&(identical(other.localeTimezone, localeTimezone) || other.localeTimezone == localeTimezone)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,eventType,eventDate,localeTimezone,id);

@override
String toString() {
  return 'ExpenseDbDto(name: $name, eventType: $eventType, eventDate: $eventDate, localeTimezone: $localeTimezone, id: $id)';
}


}

/// @nodoc
abstract mixin class _$ExpenseDbDtoCopyWith<$Res> implements $ExpenseDbDtoCopyWith<$Res> {
  factory _$ExpenseDbDtoCopyWith(_ExpenseDbDto value, $Res Function(_ExpenseDbDto) _then) = __$ExpenseDbDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, MaxiPocketExpensesType eventType, DateTime eventDate, String localeTimezone, BigInt? id
});




}
/// @nodoc
class __$ExpenseDbDtoCopyWithImpl<$Res>
    implements _$ExpenseDbDtoCopyWith<$Res> {
  __$ExpenseDbDtoCopyWithImpl(this._self, this._then);

  final _ExpenseDbDto _self;
  final $Res Function(_ExpenseDbDto) _then;

/// Create a copy of ExpenseDbDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? eventType = null,Object? eventDate = null,Object? localeTimezone = null,Object? id = freezed,}) {
  return _then(_ExpenseDbDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as MaxiPocketExpensesType,eventDate: null == eventDate ? _self.eventDate : eventDate // ignore: cast_nullable_to_non_nullable
as DateTime,localeTimezone: null == localeTimezone ? _self.localeTimezone : localeTimezone // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as BigInt?,
  ));
}


}

// dart format on
