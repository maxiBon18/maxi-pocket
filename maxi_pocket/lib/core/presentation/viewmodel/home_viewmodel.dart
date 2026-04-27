import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart' show WrapperCommitmentsEntity;
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart';
import 'package:maxi_pocket/core/domain/entities/home_entity.dart';
import 'package:maxi_pocket/core/domain/services/home_services.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketExpensesType;

/// Riverpod provider for the home screen state.
///
/// Retries up to once after a one-second delay on failure, then stops to
/// avoid indefinite loading loops.
final AsyncNotifierProvider<HomeNotifier, List<HomeEntity>> homeNotifierProvider =
    AsyncNotifierProvider<HomeNotifier, List<HomeEntity>>(
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
class HomeNotifier extends AsyncNotifier<List<HomeEntity>> {
  final Logger _logger = getDI<Logger>();
  final HomeService _homeServices = getDI<HomeService>();

  double _monthlyAmount = 0;
  double _weeklyAmount = 0;
  late final HomeEntity _homeWeeklyEntity;

  /// Total monthly expense amount across subscriptions and financings.
  double get monthlyAmount => _monthlyAmount;

  /// Total expense amount due within the next seven days.
  double get weeklyAmount => _weeklyAmount;

  /// Weekly snapshot entity populated after a successful [build].
  HomeEntity get homeWeeklyEntity => _homeWeeklyEntity;

  @override
  Future<List<HomeEntity>> build() async {
    try {
      final List<SubscriptionEntity> subscriptionEntities = await _homeServices.getSubscriptionsData();
      final List<FinancingEntity> financingEntities = await _homeServices.getFinancingsData();

      final double monthlySubscriptionAmount = subscriptionEntities.fold(
        0,
        (double sum, SubscriptionEntity subscriptionEntity) => sum + subscriptionEntity.amount,
      );
      final double monthlyFinancingAmount = financingEntities.fold(
        0,
        (double sum, FinancingEntity financingEntity) => sum + financingEntity.amount,
      );

      _monthlyAmount = monthlySubscriptionAmount + monthlyFinancingAmount;

      final List<SubscriptionEntity> weeklySubscriptionEntities = subscriptionEntities.where((
        SubscriptionEntity entity,
      ) {
        if (entity.nextPaymentDate == null) return false;
        final int daysUntilNextPayment = entity.nextPaymentDate!.difference(DateTime.now()).inDays;
        return daysUntilNextPayment <= 7;
      }).toList();

      final List<FinancingEntity> weeklyFinancingEntities = financingEntities.where((FinancingEntity entity) {
        if (entity.nextPaymentDate == null) return false;
        final int daysUntilNextPayment = entity.nextPaymentDate!.difference(DateTime.now()).inDays;
        return daysUntilNextPayment <= 7;
      }).toList();

      final double weeklySubscriptionAmount = weeklySubscriptionEntities.fold(
        0,
        (double sum, SubscriptionEntity subscriptionEntity) => sum + subscriptionEntity.amount,
      );
      final double weeklyFinancingAmount = weeklyFinancingEntities.fold(
        0,
        (double sum, FinancingEntity financingEntity) => sum + financingEntity.amount,
      );

      _weeklyAmount = weeklySubscriptionAmount + weeklyFinancingAmount;

      _homeWeeklyEntity = HomeEntity(
        subscriptionEntity: weeklySubscriptionEntities,
        financingEntity: weeklyFinancingEntities,
      );

      return <HomeEntity>[_homeWeeklyEntity];
    } catch (e, st) {
      _logger.e('Error retrieving Home data', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// Returns the total count of weekly expenses (subscriptions + financings).
  int getNumberOfExpenses() {
    return homeWeeklyEntity.subscriptionEntity.length + homeWeeklyEntity.financingEntity.length;
  }

  /// Builds a flat list of [WrapperCommitmentsEntity] from the weekly snapshot for display in the list widget.
  List<WrapperCommitmentsEntity> getHomeWeeklyWrapperCommitments() {
    final List<WrapperCommitmentsEntity> wrapperCommitments = <WrapperCommitmentsEntity>[];
    wrapperCommitments.addAll(
      homeWeeklyEntity.subscriptionEntity.map(
        (SubscriptionEntity entity) =>
            WrapperCommitmentsEntity(type: MaxiPocketExpensesType.subscription, commitments: entity),
      ),
    );
    wrapperCommitments.addAll(
      homeWeeklyEntity.financingEntity.map(
        (FinancingEntity entity) =>
            WrapperCommitmentsEntity(type: MaxiPocketExpensesType.financing, commitments: entity),
      ),
    );
    return wrapperCommitments;
  }
}
