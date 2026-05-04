// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_db_repo_impl.dart';

// ignore_for_file: type=lint
mixin _$AppointmentDbRepoImplMixin on DatabaseAccessor<MaxiPocketDatabase> {
  $CommonDataTableTable get commonDataTable => attachedDatabase.commonDataTable;
  $AppointmentsTableTable get appointmentsTable =>
      attachedDatabase.appointmentsTable;
  AppointmentDbRepoImplManager get managers =>
      AppointmentDbRepoImplManager(this);
}

class AppointmentDbRepoImplManager {
  final _$AppointmentDbRepoImplMixin _db;
  AppointmentDbRepoImplManager(this._db);
  $$CommonDataTableTableTableManager get commonDataTable =>
      $$CommonDataTableTableTableManager(
        _db.attachedDatabase,
        _db.commonDataTable,
      );
  $$AppointmentsTableTableTableManager get appointmentsTable =>
      $$AppointmentsTableTableTableManager(
        _db.attachedDatabase,
        _db.appointmentsTable,
      );
}
