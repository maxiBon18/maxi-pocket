// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_db_source_impl.dart';

// ignore_for_file: type=lint
mixin _$HomeDbSourceImplMixin on DatabaseAccessor<MaxiPocketDatabase> {
  $CommonDataTableTable get commonDataTable => attachedDatabase.commonDataTable;
  $SubscriptionsTableTable get subscriptionsTable => attachedDatabase.subscriptionsTable;
  $FinancingTableTable get financingTable => attachedDatabase.financingTable;
  HomeDbSourceImplManager get managers => HomeDbSourceImplManager(this);
}

class HomeDbSourceImplManager {
  final _$HomeDbSourceImplMixin _db;
  HomeDbSourceImplManager(this._db);
  $$CommonDataTableTableTableManager get commonDataTable =>
      $$CommonDataTableTableTableManager(_db.attachedDatabase, _db.commonDataTable);
  $$SubscriptionsTableTableTableManager get subscriptionsTable =>
      $$SubscriptionsTableTableTableManager(_db.attachedDatabase, _db.subscriptionsTable);
  $$FinancingTableTableTableManager get financingTable =>
      $$FinancingTableTableTableManager(_db.attachedDatabase, _db.financingTable);
}
