import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart'
    show CommitmentsEntity;
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketExpensesType;

/// Repository contract for expenses persistence exposed to the domain layer.
abstract class ExpensesDbRepo {
  /// Persists a new commitment of any supported type.
  Future<void> insertQuery({required CommitmentsEntity object});

  /// Removes all expense rows from the underlying store.
  Future<void> clearAllRowsTableQuery();

  /// Deletes the expense identified by [commonId] and [type].
  Future<void> deleteQuery({
    required BigInt commonId,
    required MaxiPocketExpensesType type,
  });

  /// Replaces the fields of the expense identified by [commonId] with the data in [object].
  Future<void> updateQuery({
    required BigInt commonId,
    required CommitmentsEntity object,
  });
}
