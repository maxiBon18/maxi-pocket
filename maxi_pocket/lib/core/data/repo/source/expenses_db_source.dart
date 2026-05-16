import 'package:maxi_pocket/core/data/repo/source/dto/expense_db_dto.dart'
    show ExpenseDbInsertDto;
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketExpensesType;

/// Contract for persisting expense records to the local database.
abstract class ExpensesDbSource {
  /// Inserts [object] into the appropriate type-specific table and the shared common table.
  Future<void> insertQuery({required ExpenseDbInsertDto object});

  /// Removes all rows from every managed table.
  Future<void> clearAllRowsTableQuery();

  /// Deletes the expense identified by [commonId] and its type-specific row.
  Future<void> deleteQuery({
    required BigInt commonId,
    required MaxiPocketExpensesType type,
  });

  /// Updates the expense identified by [commonId] with the data in [object].
  Future<void> updateQuery({
    required BigInt commonId,
    required ExpenseDbInsertDto object,
  });
}
