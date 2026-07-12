import 'package:maxi_pocket/appointments/data/repo/source/appointment_db_source.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/appointment_dto.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/table/data_table.dart';
import 'package:maxi_pocket/core/data/source/database_source_impl.dart';
import 'package:drift/drift.dart';
import 'package:maxi_pocket/core/data/repo/source/dto/expense_db_dto.dart';

part 'appointment_db_source_impl.g.dart';

/// Drift data source implementation that executes joined queries against the appointment tables.
@DriftAccessor(tables: <Type>[CommonDataTable, AppointmentsTable])
class AppointmentDbSourceImpl extends DatabaseAccessor<MaxiPocketDatabase>
    with _$AppointmentDbSourceImplMixin
    implements AppointmentDbSource {
  AppointmentDbSourceImpl(super.database);

  /// Fetches all upcoming appointments joined with their common expense data, ordered by event date.
  @override
  Future<List<AppointmentDto>> getAppointmentsData() async {
    final JoinedSelectStatement<HasResultSet, dynamic> querySubscription = select(commonDataTable).join(
      <Join<HasResultSet, dynamic>>[
        innerJoin(appointmentsTable, commonDataTable.primaryId.equalsExp(appointmentsTable.foreignId)),
      ],
    )..orderBy(<OrderingTerm>[OrderingTerm.asc(commonDataTable.eventDate)]);

    final List<TypedResult> appointmentRows = await (querySubscription).get();

    final List<AppointmentDto> appointmentDto = appointmentRows.map((TypedResult row) {
      final CommonData commonData = row.readTable(commonDataTable);
      final Appointment appointmentData = row.readTable(appointmentsTable);
      final ExpenseDbDto commonDbDto = ExpenseDbDto(
        id: commonData.primaryId,
        name: commonData.name,
        eventType: commonData.eventType,
        eventDate: commonData.eventDate,
        localeTimezone: commonData.localeTimezone,
      );
      return AppointmentDto(
        expense: commonDbDto,
        location: appointmentData.location,
        hour: appointmentData.hour,
        commonId: commonData.primaryId,
      );
    }).toList();

    return appointmentDto;
  }
}
