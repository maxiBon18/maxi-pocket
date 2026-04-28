import 'package:maxi_pocket/core/data/repo/source/expenses_db_source.dart';
import 'package:maxi_pocket/core/domain/services/repo/expenses_db_repo.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/entity_dto_extensions.dart'
    show AppointmentEntityExtension, FinancingEntityExtension, SubscriptionEntityExtension;
import 'package:maxi_pocket/core/domain/entities/appointment_entity.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart' show CommitmentsEntity;
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';

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

  /// Delegates to [ExpensesDbSource.clearAllRowsTableQuery].
  @override
  Future<void> clearAllRowsTableQuery() => _expensesSource.clearAllRowsTableQuery();
}
