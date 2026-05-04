import 'package:flutter/foundation.dart' show immutable;
import 'package:maxi_pocket/appointments/domain/services/repo/appointment_db_repo.dart';
import 'package:maxi_pocket/core/domain/entities/appointment_entity.dart';

/// Domain service that fetches appointment data for the appointments screen.
@immutable
class AppointmentService {
  final AppointmentDbRepo _appointmentDbRepo;

  const AppointmentService(this._appointmentDbRepo);

  /// Returns all appointment records relevant to the current display period.
  Future<List<AppointmentEntity>> getAppointmentsData() => _appointmentDbRepo.getAppointmentsData();
}
