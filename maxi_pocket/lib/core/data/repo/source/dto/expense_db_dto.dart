import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketExpensesType;
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart' show ExpenseCommitmentEntity;

part 'expense_db_dto.freezed.dart';
part 'expense_db_dto.g.dart';

/// Marker for DTOs that can be inserted via [ExpensesDbSourceImpl.insertQuery].
abstract class ExpenseDbInsertDto {}

/// Shared expense fields present in every expense type (subscription and financing).
///
/// Embed this in type-specific DTOs instead of duplicating these fields.
@Freezed()
abstract class ExpenseDbDto with _$ExpenseDbDto {
  const ExpenseDbDto._();

  const factory ExpenseDbDto({
    required String name,
    required MaxiPocketExpensesType eventType,
    required DateTime eventDate,
  }) = _ExpenseDbDto;

  factory ExpenseDbDto.fromJson(Map<String, Object?> json) => _$ExpenseDbDtoFromJson(json);

  /// Reconstructs an [ExpenseCommitmentEntity] from this DTO.
  ExpenseCommitmentEntity toEntity() => ExpenseCommitmentEntity(name: name, eventDate: eventDate, eventType: eventType);
}
