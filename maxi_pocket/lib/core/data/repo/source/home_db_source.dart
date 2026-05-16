import 'package:maxi_pocket/core/data/repo/source/dto/financing_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/subscription_dto.dart';

/// Data source interface for reading raw home-screen DTOs from the Drift database.
abstract class HomeDbSource {
  /// Fetches subscription DTOs whose next payment date falls in the current month.
  Future<List<SubscriptionDto>> getSubscriptionsData();

  /// Fetches financing DTOs whose next payment date falls in the current month.
  Future<List<FinancingDto>> getFinancingsData();
}
