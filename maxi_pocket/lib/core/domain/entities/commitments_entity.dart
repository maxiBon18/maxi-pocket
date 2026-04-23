import 'package:flutter/foundation.dart' show immutable;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketExpensesType;

@immutable
abstract class CommitmentsEntity {}

@immutable
class ExpenseCommitmentEntity {
  final String name;
  final DateTime eventDate;
  final MaxiPocketExpensesType eventType;

  const ExpenseCommitmentEntity({required this.name, required this.eventDate, required this.eventType});
}
