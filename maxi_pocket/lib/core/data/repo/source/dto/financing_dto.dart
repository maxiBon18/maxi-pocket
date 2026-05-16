import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/expense_db_dto.dart';
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart'
    show FinancingEntity;

part 'financing_dto.freezed.dart';
part 'financing_dto.g.dart';

/// Persistence DTO for a financing expense, embedding shared fields via [ExpenseDbDto].
@Freezed()
abstract class FinancingDto with _$FinancingDto implements ExpenseDbInsertDto {
  const FinancingDto._();

  /// Creates a [FinancingDto] with all required instalment fields.
  ///
  /// [expense] carries the shared name, date and type fields.
  /// [numberOfInstallments] is the total agreed instalment count.
  /// [numberOfPaidInstallments] is how many have already been settled.
  /// [amount] is the per-instalment charge.
  /// [nextPaymentDate] is the upcoming due date, or `null` if fully paid.
  const factory FinancingDto({
    required ExpenseDbDto expense,
    required int numberOfInstallments,
    required int numberOfPaidInstallments,
    required double amount,
    required DateTime? nextPaymentDate,
    BigInt? commonId,
  }) = _FinancingDto;

  factory FinancingDto.fromJson(Map<String, Object?> json) =>
      _$FinancingDtoFromJson(json);

  /// Reconstructs a [FinancingEntity] from this DTO.
  FinancingEntity toEntity() => FinancingEntity(
    commitmentEntity: expense.toEntity(),
    numberOfInstallments: numberOfInstallments,
    numberOfPaidInstallments: numberOfPaidInstallments,
    amount: amount,
    nextPaymentDate: nextPaymentDate,
    id: commonId,
  );
}
