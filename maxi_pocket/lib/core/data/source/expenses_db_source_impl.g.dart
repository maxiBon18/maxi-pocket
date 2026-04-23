// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_db_source_impl.dart';

// ignore_for_file: type=lint
mixin _$ExpensesDbSourceImplMixin on DatabaseAccessor<MaxiPocketDatabase> {
  $CommonDataTableTable get commonDataTable => attachedDatabase.commonDataTable;
  $SubscriptionsTableTable get subscriptionsTable => attachedDatabase.subscriptionsTable;
  $FinancingTableTable get financingTable => attachedDatabase.financingTable;
  $AppointmentsTableTable get appointmentsTable => attachedDatabase.appointmentsTable;
  ExpensesDbSourceImplManager get managers => ExpensesDbSourceImplManager(this);
}

class ExpensesDbSourceImplManager {
  final _$ExpensesDbSourceImplMixin _db;
  ExpensesDbSourceImplManager(this._db);
  $$CommonDataTableTableTableManager get commonDataTable =>
      $$CommonDataTableTableTableManager(_db.attachedDatabase, _db.commonDataTable);
  $$SubscriptionsTableTableTableManager get subscriptionsTable =>
      $$SubscriptionsTableTableTableManager(_db.attachedDatabase, _db.subscriptionsTable);
  $$FinancingTableTableTableManager get financingTable =>
      $$FinancingTableTableTableManager(_db.attachedDatabase, _db.financingTable);
  $$AppointmentsTableTableTableManager get appointmentsTable =>
      $$AppointmentsTableTableTableManager(_db.attachedDatabase, _db.appointmentsTable);
}
