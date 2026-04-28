import 'package:drift/drift.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/expense_db_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/financing_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/subscription_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/table/data_table.dart';
import 'package:maxi_pocket/core/data/source/database_source_impl.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/home_db_source.dart';

part 'home_db_source_impl.g.dart';

/// Drift data source implementation that executes joined queries against the home-screen tables.
///
/// Both queries filter by the current calendar month so only upcoming expenses are returned.
@DriftAccessor(tables: <Type>[CommonDataTable, SubscriptionsTable, FinancingTable])
class HomeDbSourceImpl extends DatabaseAccessor<MaxiPocketDatabase>
    with _$HomeDbSourceImplMixin
    implements HomeDbSource {
  HomeDbSourceImpl(super.database);

  /// Fetches all subscriptions joined with their common expense data.
  @override
  Future<List<SubscriptionDto>> getSubscriptionsData() async {
    final JoinedSelectStatement<HasResultSet, dynamic> querySubscription = select(commonDataTable).join(
      <Join<HasResultSet, dynamic>>[
        innerJoin(subscriptionsTable, commonDataTable.primaryId.equalsExp(subscriptionsTable.foreignId)),
      ],
    );

    final List<TypedResult> subscriptionRows = await querySubscription.get();

    final List<SubscriptionDto> subscriptionDto = subscriptionRows.map((TypedResult row) {
      final CommonData commonData = row.readTable(commonDataTable);
      final Subscriptions subscriptionData = row.readTable(subscriptionsTable);
      final ExpenseDbDto expenseDbDto = ExpenseDbDto(
        name: commonData.name,
        eventType: commonData.eventType,
        eventDate: commonData.eventDate,
      );
      return SubscriptionDto(
        expense: expenseDbDto,
        amount: subscriptionData.amount,
        frequency: subscriptionData.expensesFrequency,
        nextPaymentDate: subscriptionData.nextPaymentDate,
      );
    }).toList();

    return subscriptionDto;
  }

  /// Fetches all financing records joined with their common expense data.
  @override
  Future<List<FinancingDto>> getFinancingsData() async {
    final JoinedSelectStatement<HasResultSet, dynamic> queryFinancing = select(commonDataTable).join(
      <Join<HasResultSet, dynamic>>[
        innerJoin(financingTable, commonDataTable.primaryId.equalsExp(financingTable.foreignId)),
      ],
    );

    final List<TypedResult> financingRows = await queryFinancing.get();

    final List<FinancingDto> financingDto = financingRows.map((TypedResult row) {
      final CommonData commonData = row.readTable(commonDataTable);
      final Financing financingData = row.readTable(financingTable);
      final ExpenseDbDto expenseDbDto = ExpenseDbDto(
        name: commonData.name,
        eventType: commonData.eventType,
        eventDate: commonData.eventDate,
      );
      return FinancingDto(
        expense: expenseDbDto,
        amount: financingData.amount,
        numberOfInstallments: financingData.numberOfInstallments,
        numberOfPaidInstallments: financingData.numberOfPaidInstallments,
        nextPaymentDate: financingData.nextPaymentDate,
      );
    }).toList();

    return financingDto;
  }
}
