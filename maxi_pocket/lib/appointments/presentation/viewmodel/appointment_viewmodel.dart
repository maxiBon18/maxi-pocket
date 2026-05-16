import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/appointments/domain/services/appointment_service.dart';
import 'package:maxi_pocket/appointments/shared/exceptions/appointment_exceptions.dart'
    show NullOrEmptyAppointmentsExceptions;
import 'package:maxi_pocket/core/domain/entities/appointment_entity.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart';

/// Auto-dispose Riverpod provider that exposes [ExpensesNotifier].
///
/// Retry is disabled because a failed read must surface as an error state rather
/// than silently loop. Auto-dispose frees the state when no expense page is active.
final AsyncNotifierProvider<AppointmentsNotifier, List<AppointmentEntity>>
appointmentProvider =
    AsyncNotifierProvider<AppointmentsNotifier, List<AppointmentEntity>>(
      AppointmentsNotifier.new,
      retry: (int retryCount, Object error) => null,
      isAutoDispose: true,
    );

/// Loads all upcoming appointments and exposes them as an [AsyncValue] list.
///
/// On [build], fetches the full appointment dataset and throws
/// [NullOrEmptyAppointmentsExceptions] when the list is empty so the UI
/// can show the appropriate empty-state widget.
class AppointmentsNotifier extends AsyncNotifier<List<AppointmentEntity>> {
  final Logger _logger = getDI<Logger>();
  final AppointmentService _appointmentService = getDI<AppointmentService>();

  List<AppointmentEntity> _appointmentEntities = <AppointmentEntity>[];

  @override
  Future<List<AppointmentEntity>> build() async {
    try {
      _appointmentEntities = await _appointmentService.getAppointmentsData();

      if (_appointmentEntities.isEmpty) {
        throw const NullOrEmptyAppointmentsExceptions();
      }

      return _appointmentEntities;
    } catch (e, st) {
      _logger.e('Error retrieving Appointments data', error: e, stackTrace: st);
      rethrow;
    }
  }

  /// Total number of appointments loaded in the last successful [build] call.
  int get numberOfAppointments => _appointmentEntities.length;
}
