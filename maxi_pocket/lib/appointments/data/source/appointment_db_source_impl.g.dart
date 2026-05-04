// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_db_source_impl.dart';

// ignore_for_file: type=lint
mixin _$AppointmentDbSourceImplMixin on DatabaseAccessor<MaxiPocketDatabase> {
  $CommonDataTableTable get commonDataTable => attachedDatabase.commonDataTable;
  $AppointmentsTableTable get appointmentsTable =>
      attachedDatabase.appointmentsTable;
  AppointmentDbSourceImplManager get managers =>
      AppointmentDbSourceImplManager(this);
}

class AppointmentDbSourceImplManager {
  final _$AppointmentDbSourceImplMixin _db;
  AppointmentDbSourceImplManager(this._db);
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
