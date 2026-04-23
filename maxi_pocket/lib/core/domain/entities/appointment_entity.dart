import 'package:flutter/foundation.dart' show immutable;
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart';

@immutable
class AppointmentEntity implements CommitmentsEntity {
  final ExpenseCommitmentEntity commitmentEntity;
  final String location;

  const AppointmentEntity({required this.commitmentEntity, required this.location});
}
