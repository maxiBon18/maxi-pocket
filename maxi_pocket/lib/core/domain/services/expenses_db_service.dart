import 'package:maxi_pocket/core/domain/entities/appointment_entity.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart'
    show CommitmentsEntity;
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart'
    show FinancingEntity;
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart'
    show SubscriptionEntity;
import 'package:maxi_pocket/core/domain/services/repo/expenses_db_repo.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketExpensesFrequency, MaxiPocketExpensesType;
import 'package:maxi_pocket/core/shared/utils/extensions.dart'
    show DateTimeExtension;

/// Domain service for persisting new expense records.
///
/// View models depend on this type. All business logic for expense creation
/// lives here; [ExpensesDbRepo] handles persistence.
class ExpensesDbService {
  final ExpensesDbRepo _expensesRepo;

  const ExpensesDbService(this._expensesRepo);

  /// Persists [object], computing [nextPaymentDate] when it is absent.
  ///
  /// Subscriptions derive their first payment date from the event date and
  /// frequency. Financings always use monthly frequency. If the date is already
  /// set it is preserved unchanged.
  Future<void> insertQuery({required CommitmentsEntity object}) async {
    final CommitmentsEntity resolved = switch (object) {
      final SubscriptionEntity s when s.nextPaymentDate == null =>
        SubscriptionEntity(
          commitmentEntity: s.commitmentEntity,
          amount: s.amount,
          frequency: s.frequency,
          nextPaymentDate: s.commitmentEntity.eventDate.nextPaymentDate(
            s.frequency,
          ),
        ),
      final FinancingEntity f when f.nextPaymentDate == null => FinancingEntity(
        commitmentEntity: f.commitmentEntity,
        numberOfInstallments: f.numberOfInstallments,
        numberOfPaidInstallments: f.numberOfPaidInstallments,
        amount: f.amount,
        nextPaymentDate: f.commitmentEntity.eventDate.nextPaymentDate(
          MaxiPocketExpensesFrequency.monthly,
        ),
      ),
      final AppointmentEntity a => AppointmentEntity(
        commitmentEntity: a.commitmentEntity,
        location: a.location,
      ),
      _ => object,
    };
    await _expensesRepo.insertQuery(object: resolved);
  }

  /// Removes all expense rows from persistent storage.
  Future<void> clearAllRowsTableQuery() =>
      _expensesRepo.clearAllRowsTableQuery();

  /// Deletes the expense identified by [commonId] and [type].
  Future<void> deleteQuery({
    required BigInt commonId,
    required MaxiPocketExpensesType type,
  }) => _expensesRepo.deleteQuery(commonId: commonId, type: type);

  /// Persists updated fields for [commonId], deriving [nextPaymentDate] when absent.
  ///
  /// Applies the same derivation logic as [insertQuery]: subscriptions use the
  /// entity's own frequency, financings always use monthly.
  Future<void> updateQuery({
    required BigInt commonId,
    required CommitmentsEntity object,
  }) {
    final CommitmentsEntity resolved = switch (object) {
      final SubscriptionEntity s when s.nextPaymentDate == null =>
        SubscriptionEntity(
          commitmentEntity: s.commitmentEntity,
          amount: s.amount,
          frequency: s.frequency,
          nextPaymentDate: s.commitmentEntity.eventDate.nextPaymentDate(
            s.frequency,
          ),
          id: s.id,
        ),
      final FinancingEntity f when f.nextPaymentDate == null => FinancingEntity(
        commitmentEntity: f.commitmentEntity,
        numberOfInstallments: f.numberOfInstallments,
        numberOfPaidInstallments: f.numberOfPaidInstallments,
        amount: f.amount,
        nextPaymentDate: f.commitmentEntity.eventDate.nextPaymentDate(
          MaxiPocketExpensesFrequency.monthly,
        ),
        id: f.id,
      ),
      final AppointmentEntity a => AppointmentEntity(
        commitmentEntity: a.commitmentEntity,
        location: a.location,
        id: a.id,
      ),
      _ => object,
    };
    return _expensesRepo.updateQuery(commonId: commonId, object: resolved);
  }
}
