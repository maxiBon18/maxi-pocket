import 'package:flutter/foundation.dart' show immutable;
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart';
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';

/// Aggregated domain entity holding all expenses loaded for the home screen.
@immutable
class HomeEntity implements CommitmentsEntity {
  /// Recurring subscription expenses included in this snapshot.
  final List<SubscriptionEntity> subscriptionEntity;

  /// Fixed-term financing commitments included in this snapshot.
  final List<FinancingEntity> financingEntity;

  const HomeEntity({required this.subscriptionEntity, required this.financingEntity});
}
