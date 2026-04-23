import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/expense_db_dto.dart';
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart' show FinancingEntity;

part 'financing_dto.freezed.dart';
part 'financing_dto.g.dart';

/// DTO for a financing expense, embedding shared fields via [ExpenseDbDto].
@Freezed()
abstract class FinancingDto with _$FinancingDto implements ExpenseDbInsertDto {
  const FinancingDto._();

  const factory FinancingDto({
    required ExpenseDbDto expense,
    required int numberOfInstallments,
    required int numberOfPaidInstallments,
    required double amount,
  }) = _FinancingDto;

  factory FinancingDto.fromJson(Map<String, Object?> json) => _$FinancingDtoFromJson(json);

  /// Reconstructs a [FinancingEntity] from this DTO.
  FinancingEntity toEntity() => FinancingEntity(
    commitmentEntity: expense.toEntity(),
    numberOfInstallments: numberOfInstallments,
    numberOfPaidInstallments: numberOfPaidInstallments,
    amount: amount,
  );
}
