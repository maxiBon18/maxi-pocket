import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/home_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart'
    show SubscriptionEntity;
import 'package:maxi_pocket/core/domain/services/home_services.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart';
import 'package:maxi_pocket/expenses/shared/exceptions/expenses_exceptions.dart';

/// Auto-dispose Riverpod provider that exposes [ExpensesNotifier].
///
/// Retry is disabled because a failed read must surface as an error state rather
/// than silently loop. Auto-dispose frees the state when no expense page is active.
final AsyncNotifierProvider<ExpensesNotifier, HomeEntity> expensesrProvider =
    AsyncNotifierProvider<ExpensesNotifier, HomeEntity>(
      ExpensesNotifier.new,
      retry: (int retryCount, Object error) => null,
      isAutoDispose: true,
    );

/// Loads all subscriptions and financings and exposes per-frequency aggregates.
///
/// On [build], fetches the full dataset, counts monthly and yearly items, and
/// throws [NullOrEmptyExpensesExceptions] when no data is available so the UI
/// can show the appropriate empty-state widget.
class ExpensesNotifier extends AsyncNotifier<HomeEntity> {
  final Logger _logger = getDI<Logger>();
  final HomeService _homeServices = getDI<HomeService>();

  int _numberOfMonthlySubscriptions = 0;
  int _numberOfYearlySubscriptions = 0;
  int _numberOfFinancings = 0;
  int _numberOfMonthlyExpenses = 0;
  int _numberOfYearlyExpenses = 0;

  /// Count of subscriptions billed monthly.
  int get numberOfMonthlySubscriptions => _numberOfMonthlySubscriptions;

  /// Count of subscriptions billed annually.
  int get numberOfYearlySubscriptions => _numberOfYearlySubscriptions;

  /// Total number of financing records.
  int get numberOfFinancings => _numberOfFinancings;

  /// Combined count of monthly subscriptions and financings (both billed monthly).
  int get numberOfMonthlyExpenses => _numberOfMonthlyExpenses;

  /// Count of yearly expenses (annual subscriptions only).
  int get numberOfYearlyExpenses => _numberOfYearlyExpenses;

  @override
  Future<HomeEntity> build() async {
    try {
      final List<SubscriptionEntity> subscriptionEntities = await _homeServices
          .getSubscriptionsData();
      final List<FinancingEntity> financingEntities = await _homeServices
          .getFinancingsData();

      final HomeEntity homeEntities = HomeEntity(
        subscriptionEntity: subscriptionEntities,
        financingEntity: financingEntities,
      );

      if ((subscriptionEntities.isEmpty && financingEntities.isEmpty)) {
        throw const NullOrEmptyExpensesExceptions();
      }
      _getNumberOfMonthlySubscriptions(homeEntities);
      _getNumberOfYearlySubscriptions(homeEntities);
      _numberOfFinancings = financingEntities.length;
      _getTotalNumberOfMonthlyExpenses(homeEntities);
      _getTotalNumberOfYearlyExpenses(homeEntities);

      return homeEntities;
    } catch (e, st) {
      if (e is NullOrEmptyExpensesExceptions) {
        _logger.i('No expenses data found', error: e);
      }
      _logger.e('Error retrieving Expenses data', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// Sums the amounts of all monthly-billed subscriptions in [expensesEntity].
  double getTotalAmountOfMonthlySubscriptions(HomeEntity expensesEntity) {
    return expensesEntity.subscriptionEntity
        .where(
          (SubscriptionEntity subscription) =>
              subscription.frequency == MaxiPocketExpensesFrequency.monthly,
        )
        .fold(
          0,
          (double sum, SubscriptionEntity subscription) =>
              sum + subscription.amount,
        );
  }

  /// Sums the amounts of all annually-billed subscriptions in [expensesEntity].
  double getTotalAmountOfYearlySubscriptions(HomeEntity expensesEntity) {
    return expensesEntity.subscriptionEntity
        .where(
          (SubscriptionEntity subscription) =>
              subscription.frequency == MaxiPocketExpensesFrequency.annual,
        )
        .fold(
          0,
          (double sum, SubscriptionEntity subscription) =>
              sum + subscription.amount,
        );
  }

  /// Sums the instalment amounts across all financings in [expensesEntity].
  double getTotalAmountOfFinancings(HomeEntity expensesEntity) {
    return expensesEntity.financingEntity.fold(
      0,
      (double sum, FinancingEntity financing) => sum + financing.amount,
    );
  }

  /// Returns the combined total of monthly subscriptions and all financing instalments.
  double getTotalAmountOfMonthlyExpenses(HomeEntity expensesEntity) {
    return getTotalAmountOfMonthlySubscriptions(expensesEntity) +
        getTotalAmountOfFinancings(expensesEntity);
  }

  /// Returns the total of annual subscriptions (financings are always monthly).
  double getTotalAmountOfYearlyExpenses(HomeEntity expensesEntity) {
    return getTotalAmountOfYearlySubscriptions(expensesEntity);
  }

  void _getTotalNumberOfMonthlyExpenses(HomeEntity expensesEntity) {
    _numberOfMonthlyExpenses =
        _numberOfMonthlySubscriptions + _numberOfFinancings;
  }

  void _getTotalNumberOfYearlyExpenses(HomeEntity expensesEntity) {
    _numberOfYearlyExpenses = _numberOfYearlySubscriptions;
  }

  void _getNumberOfMonthlySubscriptions(HomeEntity expensesEntity) {
    _numberOfMonthlySubscriptions = expensesEntity.subscriptionEntity
        .where(
          (SubscriptionEntity subscription) =>
              subscription.frequency == MaxiPocketExpensesFrequency.monthly,
        )
        .length;
  }

  void _getNumberOfYearlySubscriptions(HomeEntity expensesEntity) {
    _numberOfYearlySubscriptions = expensesEntity.subscriptionEntity
        .where(
          (SubscriptionEntity subscription) =>
              subscription.frequency == MaxiPocketExpensesFrequency.annual,
        )
        .length;
  }
}
