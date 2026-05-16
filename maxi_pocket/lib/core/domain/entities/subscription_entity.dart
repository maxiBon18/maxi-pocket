import 'package:flutter/foundation.dart' show immutable;
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketExpensesFrequency;
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart';

/// Domain entity representing a recurring subscription expense.
@immutable
class SubscriptionEntity implements CommitmentsEntity {
  /// Shared identity fields (name, date, type) for this commitment.
  final ExpenseCommitmentEntity commitmentEntity;

  /// Recurring charge amount in the user's currency.
  final double amount;

  /// Date of the next scheduled charge, or `null` if not yet calculated.
  final DateTime? nextPaymentDate;

  /// Billing cycle — monthly or annual.
  final MaxiPocketExpensesFrequency frequency;

  /// Database primary key from [CommonDataTable], populated when reading from DB.
  final BigInt? id;

  const SubscriptionEntity({
    required this.commitmentEntity,
    required this.amount,
    required this.frequency,
    this.nextPaymentDate,
    this.id,
  });
}
