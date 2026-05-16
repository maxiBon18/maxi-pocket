import 'package:maxi_pocket/core/data/repo/source/dto/appointment_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/expense_db_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/financing_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/subscription_dto.dart';
import 'package:maxi_pocket/core/domain/entities/appointment_entity.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart';
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';

/// Converts [ExpenseCommitmentEntity] to its Drift-compatible DTO.
extension ExpenseCommitmentEntityExtension on ExpenseCommitmentEntity {
  /// Maps this entity to an [ExpenseDbDto] for database persistence.
  ExpenseDbDto toDto() => ExpenseDbDto(
    name: name,
    eventDate: eventDate,
    eventType: eventType,
    id: id,
  );
}

/// Converts [AppointmentEntity] to its Drift-compatible DTO.
extension AppointmentEntityExtension on AppointmentEntity {
  /// Maps this entity to an [AppointmentDto] for database persistence.
  AppointmentDto toDto() =>
      AppointmentDto(expense: commitmentEntity.toDto(), location: location);
}

/// Converts [SubscriptionEntity] to its Drift-compatible DTO.
extension SubscriptionEntityExtension on SubscriptionEntity {
  /// Maps this entity to a [SubscriptionDto] for database persistence.
  SubscriptionDto toDto() => SubscriptionDto(
    expense: commitmentEntity.toDto(),
    amount: amount,
    frequency: frequency,
    nextPaymentDate: nextPaymentDate,
  );
}

/// Converts [FinancingEntity] to its Drift-compatible DTO.
extension FinancingEntityExtension on FinancingEntity {
  /// Maps this entity to a [FinancingDto] for database persistence.
  FinancingDto toDto() => FinancingDto(
    expense: commitmentEntity.toDto(),
    amount: amount,
    numberOfInstallments: numberOfInstallments,
    numberOfPaidInstallments: numberOfPaidInstallments,
    nextPaymentDate: nextPaymentDate,
  );
}
