import 'package:maxi_pocket/core/data/repo/source/dto/financing_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/subscription_dto.dart';

abstract class HomeDbSource {
  Future<List<SubscriptionDto>> getSubscriptionsData();
  Future<List<FinancingDto>> getFinancingsData();
}
