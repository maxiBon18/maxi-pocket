import 'package:flutter/foundation.dart' show immutable;
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart';

@immutable
class FinancingEntity implements CommitmentsEntity {
  final ExpenseCommitmentEntity commitmentEntity;
  final int numberOfInstallments;
  final int numberOfPaidInstallments;
  final double amount;

  const FinancingEntity({
    required this.commitmentEntity,
    required this.numberOfInstallments,
    required this.numberOfPaidInstallments,
    required this.amount,
  });
}
