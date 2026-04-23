import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/domain/services/expenses_db_service.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart';

final AsyncNotifierProvider<FabViewmodel, void> fabViewmodelProvider = AsyncNotifierProvider<FabViewmodel, void>(
  FabViewmodel.new,
);

class FabViewmodel extends AsyncNotifier<void> {
  final ExpensesDbService _expensesDbService = getDI<ExpensesDbService>();
  final Logger _logger = getDI<Logger>();

  @override
  Future<void> build() async {
    // Do nothing
  }

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
}
