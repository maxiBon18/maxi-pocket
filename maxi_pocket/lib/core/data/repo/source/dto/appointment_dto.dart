import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/expense_db_dto.dart';

part 'appointment_dto.freezed.dart';
part 'appointment_dto.g.dart';

/// DTO for an appointment expense, embedding shared fields via [ExpenseDbDto].
@Freezed()
abstract class AppointmentDto with _$AppointmentDto implements ExpenseDbInsertDto {
  const AppointmentDto._();

  const factory AppointmentDto({required ExpenseDbDto expense, required String location}) = _AppointmentDto;

  factory AppointmentDto.fromJson(Map<String, Object?> json) => _$AppointmentDtoFromJson(json);
}
