// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppointmentDto _$AppointmentDtoFromJson(Map<String, dynamic> json) =>
    _AppointmentDto(
      expense: ExpenseDbDto.fromJson(json['expense'] as Map<String, dynamic>),
      location: json['location'] as String,
      commonId: json['commonId'] == null
          ? null
          : BigInt.parse(json['commonId'] as String),
    );

Map<String, dynamic> _$AppointmentDtoToJson(_AppointmentDto instance) =>
    <String, dynamic>{
      'expense': instance.expense,
      'location': instance.location,
      'commonId': instance.commonId?.toString(),
    };
