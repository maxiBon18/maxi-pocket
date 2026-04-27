// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_db_repo_impl.dart';

// ignore_for_file: type=lint
mixin _$HomeDbRepoImplMixin on DatabaseAccessor<MaxiPocketDatabase> {
  $CommonDataTableTable get commonDataTable => attachedDatabase.commonDataTable;
  $SubscriptionsTableTable get subscriptionsTable =>
      attachedDatabase.subscriptionsTable;
  $FinancingTableTable get financingTable => attachedDatabase.financingTable;
  HomeDbRepoImplManager get managers => HomeDbRepoImplManager(this);
}

class HomeDbRepoImplManager {
  final _$HomeDbRepoImplMixin _db;
  HomeDbRepoImplManager(this._db);
  $$CommonDataTableTableTableManager get commonDataTable =>
      $$CommonDataTableTableTableManager(
        _db.attachedDatabase,
        _db.commonDataTable,
      );
  $$SubscriptionsTableTableTableManager get subscriptionsTable =>
      $$SubscriptionsTableTableTableManager(
        _db.attachedDatabase,
        _db.subscriptionsTable,
      );
  $$FinancingTableTableTableManager get financingTable =>
      $$FinancingTableTableTableManager(
        _db.attachedDatabase,
        _db.financingTable,
      );
}
