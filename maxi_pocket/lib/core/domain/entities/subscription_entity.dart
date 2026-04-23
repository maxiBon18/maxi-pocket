import 'package:flutter/foundation.dart' show immutable;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketExpensesFrequency;
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart';

@immutable
class SubscriptionEntity implements CommitmentsEntity {
  final ExpenseCommitmentEntity commitmentEntity;
  final double amount;
  final MaxiPocketExpensesFrequency frequency;

  const SubscriptionEntity({required this.commitmentEntity, required this.amount, required this.frequency});
}
