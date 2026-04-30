import 'package:flutter/foundation.dart' show immutable;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketExpensesFrequency, MaxiPocketExpensesType;

/// Marker interface for all expense and appointment commitment domain objects.
@immutable
abstract class CommitmentsEntity {}

/// Shared identity fields carried by every expense or appointment commitment.
@immutable
class ExpenseCommitmentEntity {
  /// User-defined label for this expense or appointment.
  final String name;

  /// The start date for an expense, or the scheduled date for an appointment.
  final DateTime eventDate;

  /// Classifies the commitment as a subscription, financing, or appointment.
  final MaxiPocketExpensesType eventType;

  const ExpenseCommitmentEntity({required this.name, required this.eventDate, required this.eventType});
}

/// Pairs a [CommitmentsEntity] with its concrete [type] for display in a mixed list.
@immutable
class WrapperCommitmentsEntity {
  /// The expense or appointment category used to select the correct tile layout.
  final MaxiPocketExpensesType type;

  /// Billing cycle carried alongside the commitment so lists can filter by frequency without downcasting.
  final MaxiPocketExpensesFrequency frequency;

  /// The concrete commitment payload.
  final CommitmentsEntity commitments;

  /// The next due date, used for chronological sorting of mixed commitment lists.
  final DateTime nextPaymentDate;

  const WrapperCommitmentsEntity({
    required this.type,
    required this.commitments,
    required this.nextPaymentDate,
    required this.frequency,
  });
}
