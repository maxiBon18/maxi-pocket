import 'package:drift/drift.dart';
import 'package:maxi_pocket/appointments/data/repo/source/appointment_db_source.dart';
import 'package:maxi_pocket/appointments/domain/services/repo/appointment_db_repo.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/appointment_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/table/data_table.dart';
import 'package:maxi_pocket/core/data/source/database_source_impl.dart';
import 'package:maxi_pocket/core/domain/entities/appointment_entity.dart';

part 'appointment_db_repo_impl.g.dart';

/// Drift-backed implementation of [AppointmentDbRepo] that delegates raw queries to [AppointmentDbSource].
@DriftAccessor(tables: <Type>[CommonDataTable, AppointmentsTable])
class AppointmentDbRepoImpl extends DatabaseAccessor<MaxiPocketDatabase>
    with _$AppointmentDbRepoImplMixin
    implements AppointmentDbRepo {
  final AppointmentDbSource _appointmentDbSource;

  AppointmentDbRepoImpl(super.database, this._appointmentDbSource);

  /// Fetches all appointments and maps each [AppointmentDto] to an [AppointmentEntity].
  @override
  Future<List<AppointmentEntity>> getAppointmentsData() async {
    final List<AppointmentDto> subscriptions = await _appointmentDbSource.getAppointmentsData();

    final List<AppointmentEntity> appointmentEntities = subscriptions
        .map((AppointmentDto dto) => dto.toEntity())
        .toList();

    return appointmentEntities;
  }
}
