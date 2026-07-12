// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_db_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpenseDbDto _$ExpenseDbDtoFromJson(Map<String, dynamic> json) =>
    _ExpenseDbDto(
      name: json['name'] as String,
      eventType: $enumDecode(
        _$MaxiPocketExpensesTypeEnumMap,
        json['eventType'],
      ),
      eventDate: DateTime.parse(json['eventDate'] as String),
      localeTimezone: json['localeTimezone'] as String,
      id: json['id'] == null ? null : BigInt.parse(json['id'] as String),
    );

Map<String, dynamic> _$ExpenseDbDtoToJson(_ExpenseDbDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'eventType': _$MaxiPocketExpensesTypeEnumMap[instance.eventType]!,
      'eventDate': instance.eventDate.toIso8601String(),
      'localeTimezone': instance.localeTimezone,
      'id': instance.id?.toString(),
    };

const _$MaxiPocketExpensesTypeEnumMap = {
  MaxiPocketExpensesType.subscription: 'subscription',
  MaxiPocketExpensesType.financing: 'financing',
  MaxiPocketExpensesType.appointments: 'appointments',
  MaxiPocketExpensesType.all: 'all',
};
