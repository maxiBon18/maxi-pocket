import 'package:flutter/foundation.dart' show immutable;
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart';

/// Domain entity representing a scheduled appointment with a physical location.
@immutable
class AppointmentEntity implements CommitmentsEntity {
  /// Shared commitment fields (name, date, event type).
  final ExpenseCommitmentEntity commitmentEntity;

  /// Physical location or venue of the appointment.
  final String location;

  /// Database primary key; `null` before the record is persisted.
  final BigInt? id;

  const AppointmentEntity({required this.commitmentEntity, required this.location, this.id});
}
