import 'package:flutter/foundation.dart';
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';
import 'package:maxi_pocket/home/domain/services/repo/home_db_repo.dart';

@immutable
class HomeService {
  final HomeDbRepo _homeDbRepo;

  const HomeService(this._homeDbRepo);

  Future<List<SubscriptionEntity>> getSubscriptionsData() => _homeDbRepo.getSubscriptionsData();

  Future<List<FinancingEntity>> getFinancingsData() => _homeDbRepo.getFinancingsData();
}
