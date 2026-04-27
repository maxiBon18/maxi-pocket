import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';

/// Repository interface for reading home-screen expense data from persistent storage.
abstract class HomeDbRepo {
  /// Fetches all subscription records for the current display period.
  Future<List<SubscriptionEntity>> getSubscriptionsData();

  /// Fetches all financing records for the current display period.
  Future<List<FinancingEntity>> getFinancingsData();
}
