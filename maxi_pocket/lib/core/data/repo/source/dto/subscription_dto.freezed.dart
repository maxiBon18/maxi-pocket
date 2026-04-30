// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionDto {

 ExpenseDbDto get expense; double get amount; MaxiPocketExpensesFrequency get frequency; DateTime? get nextPaymentDate; BigInt? get commonId;
/// Create a copy of SubscriptionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionDtoCopyWith<SubscriptionDto> get copyWith => _$SubscriptionDtoCopyWithImpl<SubscriptionDto>(this as SubscriptionDto, _$identity);

  /// Serializes this SubscriptionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionDto&&(identical(other.expense, expense) || other.expense == expense)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.nextPaymentDate, nextPaymentDate) || other.nextPaymentDate == nextPaymentDate)&&(identical(other.commonId, commonId) || other.commonId == commonId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expense,amount,frequency,nextPaymentDate,commonId);

@override
String toString() {
  return 'SubscriptionDto(expense: $expense, amount: $amount, frequency: $frequency, nextPaymentDate: $nextPaymentDate, commonId: $commonId)';
}


}

/// @nodoc
abstract mixin class $SubscriptionDtoCopyWith<$Res>  {
  factory $SubscriptionDtoCopyWith(SubscriptionDto value, $Res Function(SubscriptionDto) _then) = _$SubscriptionDtoCopyWithImpl;
@useResult
$Res call({
 ExpenseDbDto expense, double amount, MaxiPocketExpensesFrequency frequency, DateTime? nextPaymentDate, BigInt? commonId
});


$ExpenseDbDtoCopyWith<$Res> get expense;

}
/// @nodoc
class _$SubscriptionDtoCopyWithImpl<$Res>
    implements $SubscriptionDtoCopyWith<$Res> {
  _$SubscriptionDtoCopyWithImpl(this._self, this._then);

  final SubscriptionDto _self;
  final $Res Function(SubscriptionDto) _then;

/// Create a copy of SubscriptionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expense = null,Object? amount = null,Object? frequency = null,Object? nextPaymentDate = freezed,Object? commonId = freezed,}) {
  return _then(_self.copyWith(
expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as ExpenseDbDto,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as MaxiPocketExpensesFrequency,nextPaymentDate: freezed == nextPaymentDate ? _self.nextPaymentDate : nextPaymentDate // ignore: cast_nullable_to_non_nullable
as DateTime?,commonId: freezed == commonId ? _self.commonId : commonId // ignore: cast_nullable_to_non_nullable
as BigInt?,
  ));
}
/// Create a copy of SubscriptionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseDbDtoCopyWith<$Res> get expense {
  
  return $ExpenseDbDtoCopyWith<$Res>(_self.expense, (value) {
    return _then(_self.copyWith(expense: value));
  });
}
}


/// Adds pattern-matching-related methods to [SubscriptionDto].
extension SubscriptionDtoPatterns on SubscriptionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionDto value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionDto value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ExpenseDbDto expense,  double amount,  MaxiPocketExpensesFrequency frequency,  DateTime? nextPaymentDate,  BigInt? commonId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionDto() when $default != null:
return $default(_that.expense,_that.amount,_that.frequency,_that.nextPaymentDate,_that.commonId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ExpenseDbDto expense,  double amount,  MaxiPocketExpensesFrequency frequency,  DateTime? nextPaymentDate,  BigInt? commonId)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionDto():
return $default(_that.expense,_that.amount,_that.frequency,_that.nextPaymentDate,_that.commonId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ExpenseDbDto expense,  double amount,  MaxiPocketExpensesFrequency frequency,  DateTime? nextPaymentDate,  BigInt? commonId)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionDto() when $default != null:
return $default(_that.expense,_that.amount,_that.frequency,_that.nextPaymentDate,_that.commonId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionDto extends SubscriptionDto {
  const _SubscriptionDto({required this.expense, required this.amount, required this.frequency, required this.nextPaymentDate, this.commonId}): super._();
  factory _SubscriptionDto.fromJson(Map<String, dynamic> json) => _$SubscriptionDtoFromJson(json);

@override final  ExpenseDbDto expense;
@override final  double amount;
@override final  MaxiPocketExpensesFrequency frequency;
@override final  DateTime? nextPaymentDate;
@override final  BigInt? commonId;

/// Create a copy of SubscriptionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionDtoCopyWith<_SubscriptionDto> get copyWith => __$SubscriptionDtoCopyWithImpl<_SubscriptionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionDto&&(identical(other.expense, expense) || other.expense == expense)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.nextPaymentDate, nextPaymentDate) || other.nextPaymentDate == nextPaymentDate)&&(identical(other.commonId, commonId) || other.commonId == commonId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expense,amount,frequency,nextPaymentDate,commonId);

@override
String toString() {
  return 'SubscriptionDto(expense: $expense, amount: $amount, frequency: $frequency, nextPaymentDate: $nextPaymentDate, commonId: $commonId)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionDtoCopyWith<$Res> implements $SubscriptionDtoCopyWith<$Res> {
  factory _$SubscriptionDtoCopyWith(_SubscriptionDto value, $Res Function(_SubscriptionDto) _then) = __$SubscriptionDtoCopyWithImpl;
@override @useResult
$Res call({
 ExpenseDbDto expense, double amount, MaxiPocketExpensesFrequency frequency, DateTime? nextPaymentDate, BigInt? commonId
});


@override $ExpenseDbDtoCopyWith<$Res> get expense;

}
/// @nodoc
class __$SubscriptionDtoCopyWithImpl<$Res>
    implements _$SubscriptionDtoCopyWith<$Res> {
  __$SubscriptionDtoCopyWithImpl(this._self, this._then);

  final _SubscriptionDto _self;
  final $Res Function(_SubscriptionDto) _then;

/// Create a copy of SubscriptionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expense = null,Object? amount = null,Object? frequency = null,Object? nextPaymentDate = freezed,Object? commonId = freezed,}) {
  return _then(_SubscriptionDto(
expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as ExpenseDbDto,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as MaxiPocketExpensesFrequency,nextPaymentDate: freezed == nextPaymentDate ? _self.nextPaymentDate : nextPaymentDate // ignore: cast_nullable_to_non_nullable
as DateTime?,commonId: freezed == commonId ? _self.commonId : commonId // ignore: cast_nullable_to_non_nullable
as BigInt?,
  ));
}

/// Create a copy of SubscriptionDto
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
