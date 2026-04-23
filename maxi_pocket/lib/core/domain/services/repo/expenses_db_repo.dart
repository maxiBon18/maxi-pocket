import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart' show CommitmentsEntity;

/// Repository contract for expenses persistence exposed to the domain layer.
///
/// The single [insertQuery] entry point handles every expense type by
/// dispatching on the concrete [CommitmentsEntity] subtype received.
/// Implementations live under `lib/core/data/repo/`.
abstract class ExpensesDbRepo {
  Future<void> insertQuery({required CommitmentsEntity object});
  Future<void> clearAllRowsTableQuery();
}
