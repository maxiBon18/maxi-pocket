import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart' show CommitmentsEntity;
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart' show FinancingEntity;
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart' show SubscriptionEntity;
import 'package:maxi_pocket/core/domain/services/repo/expenses_db_repo.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketExpensesFrequency;
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show DateTimeExtension;

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
      final SubscriptionEntity s when s.nextPaymentDate == null => SubscriptionEntity(
        commitmentEntity: s.commitmentEntity,
        amount: s.amount,
        frequency: s.frequency,
        nextPaymentDate: s.commitmentEntity.eventDate.nextPaymentDate(s.frequency),
      ),
      final FinancingEntity f when f.nextPaymentDate == null => FinancingEntity(
        commitmentEntity: f.commitmentEntity,
        numberOfInstallments: f.numberOfInstallments,
        numberOfPaidInstallments: f.numberOfPaidInstallments,
        amount: f.amount,
        nextPaymentDate: f.commitmentEntity.eventDate.nextPaymentDate(MaxiPocketExpensesFrequency.monthly),
      ),
      _ => object,
    };
    await _expensesRepo.insertQuery(object: resolved);
  }

  /// Deletes all expense rows from every table in the database.
  Future<void> clearAllRowsTableQuery() => _expensesRepo.clearAllRowsTableQuery();
}
