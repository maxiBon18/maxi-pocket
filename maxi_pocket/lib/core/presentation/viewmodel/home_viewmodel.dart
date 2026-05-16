import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';
import 'package:maxi_pocket/core/domain/services/shared_pref_service.dart';
import 'package:maxi_pocket/core/shared/constants/cache_constants.dart'
    show CacheKeys;
import 'package:maxi_pocket/core/shared/controllers/di.dart';
import 'package:maxi_pocket/core/domain/entities/home_entity.dart';
import 'package:maxi_pocket/core/domain/services/home_services.dart';

/// Riverpod provider for the home screen state.
///
/// Retries up to once after a one-second delay on failure, then stops to
/// avoid indefinite loading loops.
final AsyncNotifierProvider<HomeNotifier, HomeEntity?> homeNotifierProvider =
    AsyncNotifierProvider<HomeNotifier, HomeEntity?>(
      HomeNotifier.new,
      retry: (int retryCount, Object error) {
        if (retryCount > 1) return null;
        return Duration(seconds: retryCount + 1);
      },
    );

/// Loads and aggregates expense data for the home screen.
///
/// On [build], fetches all subscriptions and financings for the current month,
/// computes monthly and weekly totals, and filters the weekly snapshot to
/// commitments due within the next seven days.
class HomeNotifier extends AsyncNotifier<HomeEntity?> {
  final Logger _logger = getDI<Logger>();
  final HomeService _homeServices = getDI<HomeService>();
  final SharedPrefWithCacheService _sharedPrefWithCacheService =
      getDI<SharedPrefWithCacheService>();

  double _monthlyAmount = 0;
  double _weeklyAmount = 0;
  HomeEntity? _homeWeeklyEntity;
  bool _onboardingCompleted = false;

  /// Whether the onboarding process has been completed.
  bool get onboardingCompleted => _onboardingCompleted;

  /// Total monthly expense amount across subscriptions and financings.
  double get monthlyAmount => _monthlyAmount;

  /// Total expense amount due within the next seven days.
  double get weeklyAmount => _weeklyAmount;

  /// Weekly snapshot entity populated after a successful [build].
  HomeEntity? get homeWeeklyEntity => _homeWeeklyEntity;

  @override
  Future<HomeEntity?> build() async {
    try {
      _onboardingCompleted =
          _sharedPrefWithCacheService.getBoolWithCache(
            CacheKeys.onboardingCompleted,
          ) ??
          false;

      final List<SubscriptionEntity> subscriptionEntities = await _homeServices
          .getSubscriptionsData();
      final List<FinancingEntity> financingEntities = await _homeServices
          .getFinancingsData();

      _calculateMonthlyAmount(subscriptionEntities, financingEntities);
      _getWeeklyAmount(subscriptionEntities, financingEntities);
      _calculateWeeklyAmount();

      return _homeWeeklyEntity;
    } catch (e, st) {
      _logger.e('Error retrieving Home data', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// Returns the total count of weekly expenses (subscriptions + financings).
  int getNumberOfExpenses() {
    if (homeWeeklyEntity == null) return 0;
    return homeWeeklyEntity!.subscriptionEntity.length +
        homeWeeklyEntity!.financingEntity.length;
  }

  /// Sums amounts for expenses whose [nextPaymentDate] falls in the current calendar month.
  void _calculateMonthlyAmount(
    List<SubscriptionEntity> subscriptionEntities,
    List<FinancingEntity> financingEntities,
  ) {
    final int currentMonth = DateTime.now().month;

    final List<SubscriptionEntity> filteredSubscriptionEntities =
        subscriptionEntities.where((SubscriptionEntity entity) {
          final DateTime? date = entity.nextPaymentDate;
          if (date == null) return false;
          return date.month == currentMonth;
        }).toList();

    final List<FinancingEntity> filteredFinancingEntities = financingEntities
        .where((FinancingEntity entity) {
          final DateTime? date = entity.nextPaymentDate;
          if (date == null) return false;
          return date.month == currentMonth;
        })
        .toList();

    final double monthlySubscriptionAmount = filteredSubscriptionEntities.fold(
      0,
      (double sum, SubscriptionEntity subscriptionEntity) =>
          sum + subscriptionEntity.amount,
    );
    final double monthlyFinancingAmount = filteredFinancingEntities.fold(
      0,
      (double sum, FinancingEntity financingEntity) =>
          sum + financingEntity.amount,
    );

    _monthlyAmount = monthlySubscriptionAmount + monthlyFinancingAmount;
  }

  /// Populates [_homeWeeklyEntity] with commitments due within the next seven days.
  ///
  /// Expenses due today are excluded because the filter uses a strict
  /// `isAfter(today)` comparison.
  void _getWeeklyAmount(
    List<SubscriptionEntity> subscriptionEntities,
    List<FinancingEntity> financingEntities,
  ) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    final List<SubscriptionEntity> filteredSubscriptionEntities =
        subscriptionEntities.where((SubscriptionEntity entity) {
          final DateTime? date = entity.nextPaymentDate;
          if (date == null) return false;
          final DateTime nextPaymentDate = DateTime(
            date.year,
            date.month,
            date.day,
          );
          return nextPaymentDate.isAfter(today);
        }).toList();

    final List<FinancingEntity> filteredFinancingEntities = financingEntities
        .where((FinancingEntity entity) {
          final DateTime? date = entity.nextPaymentDate;
          if (date == null) return false;
          final DateTime nextPaymentDate = DateTime(
            date.year,
            date.month,
            date.day,
          );
          return nextPaymentDate.isAfter(today);
        })
        .toList();

    final List<SubscriptionEntity> weeklySubscriptionEntities =
        filteredSubscriptionEntities.where((SubscriptionEntity entity) {
          final DateTime date = entity.nextPaymentDate!;
          final int daysUntilNextPayment = date.difference(now).inDays;
          return daysUntilNextPayment <= 7;
        }).toList();

    final List<FinancingEntity> weeklyFinancingEntities =
        filteredFinancingEntities.where((FinancingEntity entity) {
          final DateTime date = entity.nextPaymentDate!;
          final int daysUntilNextPayment = date.difference(now).inDays;
          return daysUntilNextPayment <= 7;
        }).toList();

    _homeWeeklyEntity = HomeEntity(
      subscriptionEntity: weeklySubscriptionEntities,
      financingEntity: weeklyFinancingEntities,
    );
  }

  /// Sums amounts for all commitments in [_homeWeeklyEntity] and stores the result in [_weeklyAmount].
  void _calculateWeeklyAmount() {
    if (homeWeeklyEntity == null) {
      _weeklyAmount = 0;
    } else {
      final double weeklySubscriptionAmount = homeWeeklyEntity!
          .subscriptionEntity
          .fold(
            0,
            (double sum, SubscriptionEntity subscriptionEntity) =>
                sum + subscriptionEntity.amount,
          );
      final double weeklyFinancingAmount = homeWeeklyEntity!.financingEntity
          .fold(
            0,
            (double sum, FinancingEntity financingEntity) =>
                sum + financingEntity.amount,
          );

      _weeklyAmount = weeklySubscriptionAmount + weeklyFinancingAmount;
    }
  }
}
