import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:maxi_pocket/core/shared/constants/app_constants.dart'
    show AppConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketExpensesFrequency, MaxiPocketExpensesType;
import 'package:path_provider/path_provider.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/table/data_table.dart';

part 'database_source_impl.g.dart';

/// Drift database that owns all expense-related tables.
///
/// Registered as a singleton in DI and injected into [ExpensesDbSourceImpl].
@DriftDatabase(
  tables: <Type>[
    CommonDataTable,
    FinancingTable,
    SubscriptionsTable,
    AppointmentsTable,
  ],
)
class MaxiPocketDatabase extends _$MaxiPocketDatabase {
  MaxiPocketDatabase([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  /// Handles schema upgrades from earlier versions.
  ///
  /// v1/v2 → v3: `amount` moved from `CommonDataTable` to `SubscriptionsTable`
  /// and `FinancingTable`; existing rows receive a 0.0 default.
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 3) {
        // amount moved from CommonDataTable to SubscriptionsTable and FinancingTable
        // from<3 covers v1→3 and v2→3 (v2 DB had no migration applied)
        await m.alterTable(TableMigration(commonDataTable));
        await m.alterTable(
          TableMigration(
            subscriptionsTable,
            columnTransformer: <GeneratedColumn<Object>, Expression<Object>>{
              subscriptionsTable.amount: const Constant<double>(0.0),
            },
          ),
        );
        await m.alterTable(
          TableMigration(
            financingTable,
            columnTransformer: <GeneratedColumn<Object>, Expression<Object>>{
              financingTable.amount: const Constant<double>(0.0),
            },
          ),
        );
      }
    },
  );

  /// Opens the on-device SQLite database using the application support directory.
  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: AppConstants.databaseName,
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
