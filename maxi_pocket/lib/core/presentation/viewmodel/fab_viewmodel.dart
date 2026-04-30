import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/domain/services/expenses_db_service.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketExpensesType;

/// Riverpod provider that exposes [FabViewmodel].
///
/// Retry is disabled because write operations (insert, update, delete) must not
/// be retried automatically — the result of a failed write is ambiguous.
final AsyncNotifierProvider<FabViewmodel, void> fabViewmodelProvider = AsyncNotifierProvider<FabViewmodel, void>(
  FabViewmodel.new,
  retry: (int retryCount, Object error) => null,
);

/// Handles all mutating expense operations triggered from the FAB and expense pages.
///
/// Wraps [ExpensesDbService] calls with loading/error/success state transitions
/// so the UI can react without owning any persistence logic.
class FabViewmodel extends AsyncNotifier<void> {
  final ExpensesDbService _expensesDbService = getDI<ExpensesDbService>();
  final Logger _logger = getDI<Logger>();

  @override
  Future<void> build() async {
    // Do nothing
  }

  /// Persists [commitmentEntity] and transitions state to data or error.
  Future<void> insertCommitments(CommitmentsEntity commitmentEntity) async {
    state = const AsyncLoading<void>();
    try {
      await _expensesDbService.insertQuery(object: commitmentEntity);
      state = const AsyncData<void>(null);
    } catch (e, st) {
      _logger.e('Error inserting commitment', error: e, stackTrace: st);
      state = AsyncError<void>(e, st);
    }
  }

  /// Removes every expense row from all tables.
  Future<void> clearAllRowsTableQuery() async {
    state = const AsyncLoading<void>();
    try {
      await _expensesDbService.clearAllRowsTableQuery();
      state = const AsyncData<void>(null);
    } catch (e, st) {
      _logger.e('Error clearing all table query', error: e, stackTrace: st);
      state = AsyncError<void>(e, st);
    }
  }

  /// Deletes the commitment identified by [commonId] and [type].
  Future<void> deleteCommitment({required BigInt commonId, required MaxiPocketExpensesType type}) async {
    state = const AsyncLoading<void>();
    try {
      await _expensesDbService.deleteQuery(commonId: commonId, type: type);
      state = const AsyncData<void>(null);
    } catch (e, st) {
      _logger.e('Error deleting commitment', error: e, stackTrace: st);
      state = AsyncError<void>(e, st);
    }
  }

  /// Replaces the stored fields of [commonId] with the data in [object].
  Future<void> updateCommitment({required BigInt commonId, required CommitmentsEntity object}) async {
    state = const AsyncLoading<void>();
    try {
      await _expensesDbService.updateQuery(commonId: commonId, object: object);
      state = const AsyncData<void>(null);
    } catch (e, st) {
      _logger.e('Error updating commitment', error: e, stackTrace: st);
      state = AsyncError<void>(e, st);
    }
  }
}
