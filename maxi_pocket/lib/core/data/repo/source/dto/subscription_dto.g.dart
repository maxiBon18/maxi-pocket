// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionDto _$SubscriptionDtoFromJson(Map<String, dynamic> json) => _SubscriptionDto(
  expense: ExpenseDbDto.fromJson(json['expense'] as Map<String, dynamic>),
  amount: (json['amount'] as num).toDouble(),
  frequency: $enumDecode(_$MaxiPocketExpensesFrequencyEnumMap, json['frequency']),
);

Map<String, dynamic> _$SubscriptionDtoToJson(_SubscriptionDto instance) => <String, dynamic>{
  'expense': instance.expense,
  'amount': instance.amount,
  'frequency': _$MaxiPocketExpensesFrequencyEnumMap[instance.frequency]!,
};

const _$MaxiPocketExpensesFrequencyEnumMap = {
  MaxiPocketExpensesFrequency.annual: 'annual',
  MaxiPocketExpensesFrequency.monthly: 'monthly',
};
