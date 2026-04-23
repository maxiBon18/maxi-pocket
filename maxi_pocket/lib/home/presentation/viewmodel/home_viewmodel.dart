import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart';
import 'package:maxi_pocket/home/domain/entities/home_entity.dart';
import 'package:maxi_pocket/home/domain/services/home_services.dart';

final AsyncNotifierProvider<HomeNotifier, List<HomeEntity>> homeNotifierProvider =
    AsyncNotifierProvider<HomeNotifier, List<HomeEntity>>(HomeNotifier.new);

class HomeNotifier extends AsyncNotifier<List<HomeEntity>> {
  final Logger _logger = getDI<Logger>();
  final HomeService _homeServices = getDI<HomeService>();

  @override
  Future<List<HomeEntity>> build() async {
    try {
      final List<SubscriptionEntity> subscriptionEntities = await _homeServices.getSubscriptionsData();
      final List<FinancingEntity> financingEntities = await _homeServices.getFinancingsData();

      final HomeEntity homeEntity = HomeEntity(
        subscriptionEntity: subscriptionEntities,
        financingEntity: financingEntities,
      );

      return <HomeEntity>[homeEntity];
    } catch (e, st) {
      _logger.e('Error retrieving Home data', error: e, stackTrace: st);
      rethrow;
    }
  }
}
