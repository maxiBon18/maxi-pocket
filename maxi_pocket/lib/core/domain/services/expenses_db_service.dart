import 'package:maxi_pocket/core/domain/services/repo/expenses_db_repo.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart' show CommitmentsEntity;

/// Domain service for persisting new expense records.
///
/// View models depend on this type. All business logic for expense creation
/// lives here; [ExpensesDbRepo] handles persistence.
class ExpensesDbService {
  final ExpensesDbRepo _expensesRepo;

  const ExpensesDbService(this._expensesRepo);

  Future<void> insertQuery({required CommitmentsEntity object}) async =>
      await _expensesRepo.insertQuery(object: object);

  Future<void> clearAllRowsTableQuery() async => await _expensesRepo.clearAllRowsTableQuery();
}
