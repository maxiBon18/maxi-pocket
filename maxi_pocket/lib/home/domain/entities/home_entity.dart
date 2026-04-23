import 'package:flutter/foundation.dart' show immutable;
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';

@immutable
class HomeEntity {
  final List<SubscriptionEntity> subscriptionEntity;
  final List<FinancingEntity> financingEntity;

  const HomeEntity({required this.subscriptionEntity, required this.financingEntity});
}
