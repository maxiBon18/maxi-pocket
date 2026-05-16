import 'package:drift/drift.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/appointment_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/expense_db_dto.dart'
    show ExpenseDbDto, ExpenseDbInsertDto;
import 'package:maxi_pocket/core/data/repo/source/dto/financing_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/subscription_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/table/data_table.dart';
import 'package:maxi_pocket/core/data/repo/source/expenses_db_source.dart';
import 'package:maxi_pocket/core/data/source/database_source_impl.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart' show getDI;
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketExpensesFrequency, MaxiPocketExpensesType;
import 'package:maxi_pocket/core/shared/utils/extensions.dart'
    show DateTimeExtension;

part 'expenses_db_source_impl.g.dart';

/// Drift accessor that implements [ExpensesDbSource] for all expense types.
///
/// Each [insertQuery] call runs inside a transaction: a shared row is written
/// to [CommonDataTable] first, then the type-specific row is linked via a
/// foreign-key reference to the generated ID.
@DriftAccessor(
  tables: <Type>[
    CommonDataTable,
    SubscriptionsTable,
    FinancingTable,
    AppointmentsTable,
  ],
)
class ExpensesDbSourceImpl extends DatabaseAccessor<MaxiPocketDatabase>
    with _$ExpensesDbSourceImplMixin
    implements ExpensesDbSource {
  final Logger _logger = getDI<Logger>();

  ExpensesDbSourceImpl(super.database);

  /// Inserts [object] into the shared table and its type-specific table atomically.
  @override
  Future<void> insertQuery({required ExpenseDbInsertDto object}) async {
    int insertedCommonId = -1;

    await transaction(() async {
      switch (object) {
        case final SubscriptionDto dto:
          insertedCommonId = await _insertCommonData(dto.expense);
          await into(subscriptionsTable).insert(
            SubscriptionsTableCompanion.insert(
              amount: dto.amount,
              expensesFrequency: dto.frequency,
              nextPaymentDate: Value<DateTime>(
                dto.expense.eventDate.nextPaymentDate(dto.frequency),
              ),
              foreignId: BigInt.from(insertedCommonId),
            ),
          );
        case final FinancingDto dto:
          insertedCommonId = await _insertCommonData(dto.expense);
          await into(financingTable).insert(
            FinancingTableCompanion.insert(
              amount: dto.amount,
              numberOfInstallments: dto.numberOfInstallments,
              numberOfPaidInstallments: dto.numberOfPaidInstallments,
              nextPaymentDate: Value<DateTime>(
                dto.expense.eventDate.nextPaymentDate(
                  MaxiPocketExpensesFrequency.monthly,
                ),
              ),
              foreignId: BigInt.from(insertedCommonId),
            ),
          );
        case final AppointmentDto dto:
          insertedCommonId = await _insertCommonData(dto.expense);
          await into(appointmentsTable).insert(
            AppointmentsTableCompanion.insert(
              location: dto.location,
              foreignId: BigInt.from(insertedCommonId),
            ),
          );
        default:
          throw ArgumentError('Unsupported DTO type: ${object.runtimeType}');
      }
    });

    await _logInsertedRow(object, insertedCommonId);
  }

  /// Deletes all rows from every managed table within a single transaction.
  @override
  Future<void> clearAllRowsTableQuery() => transaction(() async {
    for (final TableInfo<Table, Object?> table in db.allTables) {
      await delete(table).go();
    }
  });

  /// Deletes the type-specific row and its shared [CommonDataTable] row within a transaction.
  @override
  Future<void> deleteQuery({
    required BigInt commonId,
    required MaxiPocketExpensesType type,
  }) => transaction(() async {
    switch (type) {
      case MaxiPocketExpensesType.subscription:
        await (delete(subscriptionsTable)..where(
              ($SubscriptionsTableTable t) => t.foreignId.equals(commonId),
            ))
            .go();
      case MaxiPocketExpensesType.financing:
        await (delete(financingTable)
              ..where(($FinancingTableTable t) => t.foreignId.equals(commonId)))
            .go();
      case MaxiPocketExpensesType.appointments:
        await (delete(appointmentsTable)..where(
              ($AppointmentsTableTable t) => t.foreignId.equals(commonId),
            ))
            .go();
      default:
        break;
    }
    await (delete(
      commonDataTable,
    )..where(($CommonDataTableTable t) => t.primaryId.equals(commonId))).go();
  });

  /// Updates the common row and the type-specific row for [commonId] within a transaction.
  @override
  Future<void> updateQuery({
    required BigInt commonId,
    required ExpenseDbInsertDto object,
  }) => transaction(() async {
    switch (object) {
      case final SubscriptionDto dto:
        await (update(
              commonDataTable,
            )..where(($CommonDataTableTable t) => t.primaryId.equals(commonId)))
            .write(
              CommonDataTableCompanion(
                name: Value<String>(dto.expense.name),
                eventDate: Value<DateTime>(dto.expense.eventDate),
                updatedAt: Value<DateTime>(DateTime.now()),
              ),
            );
        await (update(subscriptionsTable)..where(
              ($SubscriptionsTableTable t) => t.foreignId.equals(commonId),
            ))
            .write(
              SubscriptionsTableCompanion(
                amount: Value<double>(dto.amount),
                expensesFrequency: Value<MaxiPocketExpensesFrequency>(
                  dto.frequency,
                ),
                nextPaymentDate: Value<DateTime>(
                  dto.nextPaymentDate ??
                      dto.expense.eventDate.nextPaymentDate(dto.frequency),
                ),
              ),
            );
      case final FinancingDto dto:
        await (update(
              commonDataTable,
            )..where(($CommonDataTableTable t) => t.primaryId.equals(commonId)))
            .write(
              CommonDataTableCompanion(
                name: Value<String>(dto.expense.name),
                eventDate: Value<DateTime>(dto.expense.eventDate),
                updatedAt: Value<DateTime>(DateTime.now()),
              ),
            );
        await (update(financingTable)
              ..where(($FinancingTableTable t) => t.foreignId.equals(commonId)))
            .write(
              FinancingTableCompanion(
                amount: Value<double>(dto.amount),
                numberOfInstallments: Value<int>(dto.numberOfInstallments),
                numberOfPaidInstallments: Value<int>(
                  dto.numberOfPaidInstallments,
                ),
                nextPaymentDate: Value<DateTime>(
                  dto.nextPaymentDate ??
                      dto.expense.eventDate.nextPaymentDate(
                        MaxiPocketExpensesFrequency.monthly,
                      ),
                ),
              ),
            );
      case final AppointmentDto dto:
        await (update(
              commonDataTable,
            )..where(($CommonDataTableTable t) => t.primaryId.equals(commonId)))
            .write(
              CommonDataTableCompanion(
                name: Value<String>(dto.expense.name),
                eventDate: Value<DateTime>(dto.expense.eventDate),
                updatedAt: Value<DateTime>(DateTime.now()),
              ),
            );
        await (update(appointmentsTable)..where(
              ($AppointmentsTableTable t) => t.foreignId.equals(commonId),
            ))
            .write(
              AppointmentsTableCompanion(location: Value<String>(dto.location)),
            );
      default:
        break;
    }
  });

  /// Reads back the just-inserted rows and emits a debug log entry.
  Future<void> _logInsertedRow(ExpenseDbInsertDto object, int commonId) async {
    try {
      final BigInt id = BigInt.from(commonId);
      final CommonData common =
          await (select(commonDataTable)
                ..where(($CommonDataTableTable t) => t.primaryId.equals(id)))
              .getSingle();

      switch (object) {
        case SubscriptionDto _:
          final Subscriptions sub =
              await (select(subscriptionsTable)..where(
                    ($SubscriptionsTableTable t) => t.foreignId.equals(id),
                  ))
                  .getSingle();
          _logger.d(
            '[insertQuery] Subscription — common: $common, subscription: $sub',
          );
        case FinancingDto _:
          final Financing fin =
              await (select(financingTable)
                    ..where(($FinancingTableTable t) => t.foreignId.equals(id)))
                  .getSingle();
          _logger.d(
            '[insertQuery] Financing — common: $common, financing: $fin',
          );
        case AppointmentDto _:
          final Appointment apt =
              await (select(appointmentsTable)..where(
                    ($AppointmentsTableTable t) => t.foreignId.equals(id),
                  ))
                  .getSingle();
          _logger.d(
            '[insertQuery] Appointment — common: $common, appointment: $apt',
          );
        default:
          break;
      }
    } catch (e, st) {
      _logger.e(
        '[_logInsertedRow] Failed to read back inserted row',
        error: e,
        stackTrace: st,
      );
    }
  }

  /// Writes shared expense fields to [CommonDataTable] and returns the generated primary key.
  Future<int> _insertCommonData(ExpenseDbDto expense) =>
      into(commonDataTable).insert(
        CommonDataTableCompanion.insert(
          name: expense.name,
          eventType: expense.eventType,
          eventDate: Value<DateTime>(expense.eventDate),
          createdAt: Value<DateTime>(DateTime.now()),
          updatedAt: Value<DateTime>(DateTime.now()),
        ),
      );
}
