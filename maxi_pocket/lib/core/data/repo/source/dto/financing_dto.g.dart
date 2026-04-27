// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financing_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FinancingDto _$FinancingDtoFromJson(Map<String, dynamic> json) =>
    _FinancingDto(
      expense: ExpenseDbDto.fromJson(json['expense'] as Map<String, dynamic>),
      numberOfInstallments: (json['numberOfInstallments'] as num).toInt(),
      numberOfPaidInstallments: (json['numberOfPaidInstallments'] as num)
          .toInt(),
      amount: (json['amount'] as num).toDouble(),
      nextPaymentDate: json['nextPaymentDate'] == null
          ? null
          : DateTime.parse(json['nextPaymentDate'] as String),
    );

Map<String, dynamic> _$FinancingDtoToJson(_FinancingDto instance) =>
    <String, dynamic>{
      'expense': instance.expense,
      'numberOfInstallments': instance.numberOfInstallments,
      'numberOfPaidInstallments': instance.numberOfPaidInstallments,
      'amount': instance.amount,
      'nextPaymentDate': instance.nextPaymentDate?.toIso8601String(),
    };
