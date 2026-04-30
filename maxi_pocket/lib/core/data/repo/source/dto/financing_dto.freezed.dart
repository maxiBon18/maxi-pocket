// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financing_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FinancingDto {

 ExpenseDbDto get expense; int get numberOfInstallments; int get numberOfPaidInstallments; double get amount; DateTime? get nextPaymentDate; BigInt? get commonId;
/// Create a copy of FinancingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancingDtoCopyWith<FinancingDto> get copyWith => _$FinancingDtoCopyWithImpl<FinancingDto>(this as FinancingDto, _$identity);

  /// Serializes this FinancingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancingDto&&(identical(other.expense, expense) || other.expense == expense)&&(identical(other.numberOfInstallments, numberOfInstallments) || other.numberOfInstallments == numberOfInstallments)&&(identical(other.numberOfPaidInstallments, numberOfPaidInstallments) || other.numberOfPaidInstallments == numberOfPaidInstallments)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.nextPaymentDate, nextPaymentDate) || other.nextPaymentDate == nextPaymentDate)&&(identical(other.commonId, commonId) || other.commonId == commonId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expense,numberOfInstallments,numberOfPaidInstallments,amount,nextPaymentDate,commonId);

@override
String toString() {
  return 'FinancingDto(expense: $expense, numberOfInstallments: $numberOfInstallments, numberOfPaidInstallments: $numberOfPaidInstallments, amount: $amount, nextPaymentDate: $nextPaymentDate, commonId: $commonId)';
}


}

/// @nodoc
abstract mixin class $FinancingDtoCopyWith<$Res>  {
  factory $FinancingDtoCopyWith(FinancingDto value, $Res Function(FinancingDto) _then) = _$FinancingDtoCopyWithImpl;
@useResult
$Res call({
 ExpenseDbDto expense, int numberOfInstallments, int numberOfPaidInstallments, double amount, DateTime? nextPaymentDate, BigInt? commonId
});


$ExpenseDbDtoCopyWith<$Res> get expense;

}
/// @nodoc
class _$FinancingDtoCopyWithImpl<$Res>
    implements $FinancingDtoCopyWith<$Res> {
  _$FinancingDtoCopyWithImpl(this._self, this._then);

  final FinancingDto _self;
  final $Res Function(FinancingDto) _then;

/// Create a copy of FinancingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expense = null,Object? numberOfInstallments = null,Object? numberOfPaidInstallments = null,Object? amount = null,Object? nextPaymentDate = freezed,Object? commonId = freezed,}) {
  return _then(_self.copyWith(
expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as ExpenseDbDto,numberOfInstallments: null == numberOfInstallments ? _self.numberOfInstallments : numberOfInstallments // ignore: cast_nullable_to_non_nullable
as int,numberOfPaidInstallments: null == numberOfPaidInstallments ? _self.numberOfPaidInstallments : numberOfPaidInstallments // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,nextPaymentDate: freezed == nextPaymentDate ? _self.nextPaymentDate : nextPaymentDate // ignore: cast_nullable_to_non_nullable
as DateTime?,commonId: freezed == commonId ? _self.commonId : commonId // ignore: cast_nullable_to_non_nullable
as BigInt?,
  ));
}
/// Create a copy of FinancingDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseDbDtoCopyWith<$Res> get expense {
  
  return $ExpenseDbDtoCopyWith<$Res>(_self.expense, (value) {
    return _then(_self.copyWith(expense: value));
  });
}
}


/// Adds pattern-matching-related methods to [FinancingDto].
extension FinancingDtoPatterns on FinancingDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancingDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancingDto value)  $default,){
final _that = this;
switch (_that) {
case _FinancingDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancingDto value)?  $default,){
final _that = this;
switch (_that) {
case _FinancingDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ExpenseDbDto expense,  int numberOfInstallments,  int numberOfPaidInstallments,  double amount,  DateTime? nextPaymentDate,  BigInt? commonId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancingDto() when $default != null:
return $default(_that.expense,_that.numberOfInstallments,_that.numberOfPaidInstallments,_that.amount,_that.nextPaymentDate,_that.commonId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ExpenseDbDto expense,  int numberOfInstallments,  int numberOfPaidInstallments,  double amount,  DateTime? nextPaymentDate,  BigInt? commonId)  $default,) {final _that = this;
switch (_that) {
case _FinancingDto():
return $default(_that.expense,_that.numberOfInstallments,_that.numberOfPaidInstallments,_that.amount,_that.nextPaymentDate,_that.commonId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ExpenseDbDto expense,  int numberOfInstallments,  int numberOfPaidInstallments,  double amount,  DateTime? nextPaymentDate,  BigInt? commonId)?  $default,) {final _that = this;
switch (_that) {
case _FinancingDto() when $default != null:
return $default(_that.expense,_that.numberOfInstallments,_that.numberOfPaidInstallments,_that.amount,_that.nextPaymentDate,_that.commonId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FinancingDto extends FinancingDto {
  const _FinancingDto({required this.expense, required this.numberOfInstallments, required this.numberOfPaidInstallments, required this.amount, required this.nextPaymentDate, this.commonId}): super._();
  factory _FinancingDto.fromJson(Map<String, dynamic> json) => _$FinancingDtoFromJson(json);

@override final  ExpenseDbDto expense;
@override final  int numberOfInstallments;
@override final  int numberOfPaidInstallments;
@override final  double amount;
@override final  DateTime? nextPaymentDate;
@override final  BigInt? commonId;

/// Create a copy of FinancingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancingDtoCopyWith<_FinancingDto> get copyWith => __$FinancingDtoCopyWithImpl<_FinancingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FinancingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancingDto&&(identical(other.expense, expense) || other.expense == expense)&&(identical(other.numberOfInstallments, numberOfInstallments) || other.numberOfInstallments == numberOfInstallments)&&(identical(other.numberOfPaidInstallments, numberOfPaidInstallments) || other.numberOfPaidInstallments == numberOfPaidInstallments)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.nextPaymentDate, nextPaymentDate) || other.nextPaymentDate == nextPaymentDate)&&(identical(other.commonId, commonId) || other.commonId == commonId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expense,numberOfInstallments,numberOfPaidInstallments,amount,nextPaymentDate,commonId);

@override
String toString() {
  return 'FinancingDto(expense: $expense, numberOfInstallments: $numberOfInstallments, numberOfPaidInstallments: $numberOfPaidInstallments, amount: $amount, nextPaymentDate: $nextPaymentDate, commonId: $commonId)';
}


}

/// @nodoc
abstract mixin class _$FinancingDtoCopyWith<$Res> implements $FinancingDtoCopyWith<$Res> {
  factory _$FinancingDtoCopyWith(_FinancingDto value, $Res Function(_FinancingDto) _then) = __$FinancingDtoCopyWithImpl;
@override @useResult
$Res call({
 ExpenseDbDto expense, int numberOfInstallments, int numberOfPaidInstallments, double amount, DateTime? nextPaymentDate, BigInt? commonId
});


@override $ExpenseDbDtoCopyWith<$Res> get expense;

}
/// @nodoc
class __$FinancingDtoCopyWithImpl<$Res>
    implements _$FinancingDtoCopyWith<$Res> {
  __$FinancingDtoCopyWithImpl(this._self, this._then);

  final _FinancingDto _self;
  final $Res Function(_FinancingDto) _then;

/// Create a copy of FinancingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expense = null,Object? numberOfInstallments = null,Object? numberOfPaidInstallments = null,Object? amount = null,Object? nextPaymentDate = freezed,Object? commonId = freezed,}) {
  return _then(_FinancingDto(
expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as ExpenseDbDto,numberOfInstallments: null == numberOfInstallments ? _self.numberOfInstallments : numberOfInstallments // ignore: cast_nullable_to_non_nullable
as int,numberOfPaidInstallments: null == numberOfPaidInstallments ? _self.numberOfPaidInstallments : numberOfPaidInstallments // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,nextPaymentDate: freezed == nextPaymentDate ? _self.nextPaymentDate : nextPaymentDate // ignore: cast_nullable_to_non_nullable
as DateTime?,commonId: freezed == commonId ? _self.commonId : commonId // ignore: cast_nullable_to_non_nullable
as BigInt?,
  ));
}

/// Create a copy of FinancingDto
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
