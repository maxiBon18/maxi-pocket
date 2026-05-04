import 'package:maxi_pocket/core/data/repo/source/dto/appointment_dto.dart';

/// Data source interface for reading appointment rows from the database.
abstract class AppointmentDbSource {
  /// Returns all appointment DTOs joined with their shared expense data.
  Future<List<AppointmentDto>> getAppointmentsData();
}
