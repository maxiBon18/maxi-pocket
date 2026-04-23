import 'package:maxi_pocket/core/data/repo/source/dto/expense_db_dto.dart' show ExpenseDbInsertDto;

/// Contract for persisting expense records to the local database.
///
/// The single [insertQuery] entry point handles every expense type by
/// dispatching on the concrete [ExpenseDbInsertDto] subtype received.
abstract class ExpensesDbSource {
  /// Persists [object] to the appropriate table based on its concrete type.
  Future<void> insertQuery({required ExpenseDbInsertDto object});

  /// Deletes every row from all expense tables within a single transaction.
  Future<void> clearAllRowsTableQuery();
}
