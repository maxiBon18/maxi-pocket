import 'package:maxi_pocket/core/domain/entities/appointment_entity.dart';

/// Repository interface for querying appointment data from persistent storage.
abstract class AppointmentDbRepo {
  /// Returns all upcoming [AppointmentEntity] records.
  Future<List<AppointmentEntity>> getAppointmentsData();
}
