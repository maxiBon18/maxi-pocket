import 'package:drift/drift.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/financing_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/subscription_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/table/data_table.dart';
import 'package:maxi_pocket/core/data/source/database_source_impl.dart';
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/home_db_source.dart';
import 'package:maxi_pocket/core/domain/services/repo/home_db_repo.dart';

part 'home_db_repo_impl.g.dart';

/// Drift-backed implementation of [HomeDbRepo] that delegates raw queries to [HomeDbSource].
@DriftAccessor(tables: <Type>[CommonDataTable, SubscriptionsTable, FinancingTable])
class HomeDbRepoImpl extends DatabaseAccessor<MaxiPocketDatabase> with _$HomeDbRepoImplMixin implements HomeDbRepo {
  final HomeDbSource _homeDbSource;

  HomeDbRepoImpl(super.database, this._homeDbSource);

  @override
  Future<List<SubscriptionEntity>> getSubscriptionsData() async {
    final List<SubscriptionDto> subscriptions = await _homeDbSource.getSubscriptionsData();

    final List<SubscriptionEntity> subscriptionEntities = subscriptions
        .map((SubscriptionDto dto) => dto.toEntity())
        .toList();

    return subscriptionEntities;
  }

  @override
  Future<List<FinancingEntity>> getFinancingsData() async {
    final List<FinancingDto> financings = await _homeDbSource.getFinancingsData();

    final List<FinancingEntity> financingEntities = financings.map((FinancingDto dto) => dto.toEntity()).toList();

    return financingEntities;
  }
}
