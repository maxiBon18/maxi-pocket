import 'package:drift/drift.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/expense_db_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/financing_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/subscription_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/table/data_table.dart';
import 'package:maxi_pocket/core/data/source/database_source_impl.dart';
import 'package:maxi_pocket/core/data/repo/source/home_db_source.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketExpensesFrequency;
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show DateTimeExtension;

part 'home_db_source_impl.g.dart';

/// Drift data source implementation that executes joined queries against the home-screen tables.
@DriftAccessor(tables: <Type>[CommonDataTable, SubscriptionsTable, FinancingTable])
class HomeDbSourceImpl extends DatabaseAccessor<MaxiPocketDatabase>
    with _$HomeDbSourceImplMixin
    implements HomeDbSource {
  HomeDbSourceImpl(super.database);

  /// Fetches all subscriptions joined with their common expense data.
  @override
  Future<List<SubscriptionDto>> getSubscriptionsData() async {
    await _updateNextPaymentDateSubscription();

    final JoinedSelectStatement<HasResultSet, dynamic> querySubscription = select(commonDataTable).join(
      <Join<HasResultSet, dynamic>>[
        innerJoin(subscriptionsTable, commonDataTable.primaryId.equalsExp(subscriptionsTable.foreignId)),
      ],
    )..orderBy(<OrderingTerm>[OrderingTerm.asc(subscriptionsTable.nextPaymentDate)]);

    final List<TypedResult> subscriptionRows = await querySubscription.get();

    final List<SubscriptionDto> subscriptionDto = subscriptionRows.map((TypedResult row) {
      final CommonData commonData = row.readTable(commonDataTable);
      final Subscriptions subscriptionData = row.readTable(subscriptionsTable);
      final ExpenseDbDto expenseDbDto = ExpenseDbDto(
        name: commonData.name,
        eventType: commonData.eventType,
        eventDate: commonData.eventDate,
        id: commonData.primaryId,
        localeTimezone: commonData.localeTimezone,
      );
      return SubscriptionDto(
        expense: expenseDbDto,
        amount: subscriptionData.amount,
        frequency: subscriptionData.expensesFrequency,
        nextPaymentDate: subscriptionData.nextPaymentDate,
        commonId: commonData.primaryId,
      );
    }).toList();

    return subscriptionDto;
  }

  /// Fetches all financing records joined with their common expense data.
  @override
  Future<List<FinancingDto>> getFinancingsData() async {
    await _updateNextPaymentDateFinancing();

    final JoinedSelectStatement<HasResultSet, dynamic> queryFinancing = select(commonDataTable).join(
      <Join<HasResultSet, dynamic>>[
        innerJoin(financingTable, commonDataTable.primaryId.equalsExp(financingTable.foreignId)),
      ],
    )..orderBy(<OrderingTerm>[OrderingTerm.asc(financingTable.nextPaymentDate)]);

    final List<TypedResult> financingRows = await queryFinancing.get();

    final List<FinancingDto> financingDto = financingRows.map((TypedResult row) {
      final CommonData commonData = row.readTable(commonDataTable);
      final Financing financingData = row.readTable(financingTable);
      final ExpenseDbDto expenseDbDto = ExpenseDbDto(
        id: commonData.primaryId,
        name: commonData.name,
        eventType: commonData.eventType,
        eventDate: commonData.eventDate,
        localeTimezone: commonData.localeTimezone,
      );
      return FinancingDto(
        expense: expenseDbDto,
        amount: financingData.amount,
        numberOfInstallments: financingData.numberOfInstallments,
        numberOfPaidInstallments: financingData.numberOfPaidInstallments,
        nextPaymentDate: financingData.nextPaymentDate,
        commonId: commonData.primaryId,
      );
    }).toList();

    return financingDto;
  }

  /// Advances [next] by one period until it is strictly after [now].
  ///
  /// Table-agnostic: callers supply fetch, date/frequency extractors, and the update callback.
  Future<void> _updateExpiredPaymentDates<R>({
    required Future<List<R>> Function() fetchOverdue,
    required DateTime Function(R) getDate,
    required MaxiPocketExpensesFrequency Function(R) getFrequency,
    required Future<void> Function(R, DateTime) performUpdate,
  }) async {
    final List<R> overdueRows = await fetchOverdue();
    if (overdueRows.isEmpty) return;

    final DateTime now = DateTime.now();
    for (final R row in overdueRows) {
      DateTime next = getDate(row);
      final MaxiPocketExpensesFrequency frequency = getFrequency(row);
      do {
        next = next.nextPaymentDate(frequency);
      } while (!next.isAfter(now));
      await performUpdate(row, next);
    }
  }

  /// Rolls forward overdue subscription next-payment dates inside a transaction.
  Future<void> _updateNextPaymentDateSubscription() => transaction(
    () => _updateExpiredPaymentDates<Subscriptions>(
      fetchOverdue: () => (select(
        subscriptionsTable,
      )..where(($SubscriptionsTableTable t) => t.nextPaymentDate.isSmallerOrEqualValue(DateTime.now()))).get(),
      getDate: (Subscriptions row) => row.nextPaymentDate,
      getFrequency: (Subscriptions row) => row.expensesFrequency,
      performUpdate: (Subscriptions row, DateTime newDate) =>
          (update(subscriptionsTable)..where(($SubscriptionsTableTable t) => t.foreignId.equals(row.foreignId))).write(
            SubscriptionsTableCompanion(nextPaymentDate: Value<DateTime>(newDate)),
          ),
    ),
  );

  /// Rolls forward overdue financing next-payment dates inside a transaction.
  Future<void> _updateNextPaymentDateFinancing() => transaction(
    () => _updateExpiredPaymentDates<Financing>(
      fetchOverdue: () => (select(
        financingTable,
      )..where(($FinancingTableTable t) => t.nextPaymentDate.isSmallerOrEqualValue(DateTime.now()))).get(),
      getDate: (Financing row) => row.nextPaymentDate,
      getFrequency: (Financing _) => MaxiPocketExpensesFrequency.monthly,
      performUpdate: (Financing row, DateTime newDate) =>
          (update(financingTable)..where(($FinancingTableTable t) => t.foreignId.equals(row.foreignId))).write(
            FinancingTableCompanion(nextPaymentDate: Value<DateTime>(newDate)),
          ),
    ),
  );
}
