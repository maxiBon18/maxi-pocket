import 'package:maxi_pocket/core/data/repo/source/expenses_db_source.dart';
import 'package:maxi_pocket/core/domain/services/repo/expenses_db_repo.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/entity_dto_extensions.dart'
    show AppointmentEntityExtension, FinancingEntityExtension, SubscriptionEntityExtension;
import 'package:maxi_pocket/core/domain/entities/appointment_entity.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart' show CommitmentsEntity;
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketExpensesType;

/// [ExpensesDbRepo] implementation that forwards to [ExpensesDbSource].
///
/// Keeps the domain layer free of Drift types while preserving one-to-one
/// behavior with the underlying data source.
class ExpensesDbRepoImpl implements ExpensesDbRepo {
  final ExpensesDbSource _expensesSource;

  const ExpensesDbRepoImpl(this._expensesSource);

  /// Dispatches [object] to the correct [ExpensesDbSource] insert path based on its runtime type.
  @override
  Future<void> insertQuery({required CommitmentsEntity object}) async {
    switch (object) {
      case final AppointmentEntity appointment:
        await _expensesSource.insertQuery(object: appointment.toDto());
      case final SubscriptionEntity subscription:
        await _expensesSource.insertQuery(object: subscription.toDto());
      case final FinancingEntity financing:
        await _expensesSource.insertQuery(object: financing.toDto());
    }
  }

  /// Removes all expense rows from every table by delegating to [ExpensesDbSource].
  @override
  Future<void> clearAllRowsTableQuery() => _expensesSource.clearAllRowsTableQuery();

  /// Deletes the expense identified by [commonId] and [type] from the data source.
  @override
  Future<void> deleteQuery({required BigInt commonId, required MaxiPocketExpensesType type}) =>
      _expensesSource.deleteQuery(commonId: commonId, type: type);

  /// Converts [object] to the appropriate DTO and forwards the update to [ExpensesDbSource].
  @override
  Future<void> updateQuery({required BigInt commonId, required CommitmentsEntity object}) async {
    switch (object) {
      case final AppointmentEntity appointment:
        await _expensesSource.updateQuery(commonId: commonId, object: appointment.toDto());
      case final SubscriptionEntity subscription:
        await _expensesSource.updateQuery(commonId: commonId, object: subscription.toDto());
      case final FinancingEntity financing:
        await _expensesSource.updateQuery(commonId: commonId, object: financing.toDto());
    }
  }
}
