import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';

abstract class HomeDbRepo {
  Future<List<SubscriptionEntity>> getSubscriptionsData();
  Future<List<FinancingEntity>> getFinancingsData();
}
