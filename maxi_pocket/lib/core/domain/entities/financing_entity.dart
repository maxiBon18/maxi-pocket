import 'package:flutter/foundation.dart' show immutable;
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart';

/// Domain entity representing a fixed-term financing commitment (loan or instalment plan).
@immutable
class FinancingEntity implements CommitmentsEntity {
  /// Shared identity fields (name, date, type) for this commitment.
  final ExpenseCommitmentEntity commitmentEntity;

  /// Total number of instalments agreed at the start of the financing.
  final int numberOfInstallments;

  /// Number of instalments already paid.
  final int numberOfPaidInstallments;

  /// Periodic instalment amount in the user's currency.
  final double amount;

  /// Date of the next scheduled instalment, or `null` if fully paid.
  final DateTime? nextPaymentDate;

  const FinancingEntity({
    required this.commitmentEntity,
    required this.numberOfInstallments,
    required this.numberOfPaidInstallments,
    required this.amount,
    this.nextPaymentDate,
  });
}
