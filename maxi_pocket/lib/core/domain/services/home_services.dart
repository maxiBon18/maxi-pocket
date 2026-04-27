import 'package:flutter/foundation.dart';
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';
import 'package:maxi_pocket/core/domain/services/repo/home_db_repo.dart';

/// Domain service that fetches subscription and financing data for the home screen.
@immutable
class HomeService {
  final HomeDbRepo _homeDbRepo;

  const HomeService(this._homeDbRepo);

  /// Returns all subscription records relevant to the current display period.
  Future<List<SubscriptionEntity>> getSubscriptionsData() => _homeDbRepo.getSubscriptionsData();

  /// Returns all financing records relevant to the current display period.
  Future<List<FinancingEntity>> getFinancingsData() => _homeDbRepo.getFinancingsData();
}
