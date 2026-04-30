import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/expense_db_dto.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketExpensesFrequency;
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart' show SubscriptionEntity;

part 'subscription_dto.freezed.dart';
part 'subscription_dto.g.dart';

/// Persistence DTO for a subscription expense, embedding shared fields via [ExpenseDbDto].
@Freezed()
abstract class SubscriptionDto with _$SubscriptionDto implements ExpenseDbInsertDto {
  const SubscriptionDto._();

  /// Creates a [SubscriptionDto] with all required recurring-charge fields.
  ///
  /// [expense] carries the shared name, date and type fields.
  /// [amount] is the recurring charge amount.
  /// [frequency] is the billing cycle (monthly or annual).
  /// [nextPaymentDate] is the upcoming due date, or `null` if not yet calculated.
  const factory SubscriptionDto({
    required ExpenseDbDto expense,
    required double amount,
    required MaxiPocketExpensesFrequency frequency,
    required DateTime? nextPaymentDate,
    BigInt? commonId,
  }) = _SubscriptionDto;

  factory SubscriptionDto.fromJson(Map<String, Object?> json) => _$SubscriptionDtoFromJson(json);

  /// Reconstructs a [SubscriptionEntity] from this DTO.
  SubscriptionEntity toEntity() => SubscriptionEntity(
    commitmentEntity: expense.toEntity(),
    amount: amount,
    frequency: frequency,
    nextPaymentDate: nextPaymentDate,
    id: commonId,
  );
}
