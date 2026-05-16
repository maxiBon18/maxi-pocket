import 'package:flutter/foundation.dart';

/// Thrown when the expenses data source returns an empty or null result set.
///
/// Used by [AppointmentsNotifier] to distinguish the "no data" case from a genuine
/// retrieval failure so the UI can show an empty-state widget instead of an error.
@immutable
class NullOrEmptyAppointmentsExceptions implements Exception {
  const NullOrEmptyAppointmentsExceptions();

  @override
  String toString() {
    return 'AppointmentsExceptions: Null or Empty Appointments';
  }
}

/// Wraps an unexpected error and its stack trace that occurred while fetching expenses.
///
/// Pages check for this type in the [AsyncValue.error] callback and route to the
/// error-content widget rather than the empty-state widget.
class ErrorRetrievingAppointmentsExceptions implements Exception {
  final Object error;
  final StackTrace stackTrace;

  ErrorRetrievingAppointmentsExceptions({
    required this.error,
    required this.stackTrace,
  });

  @override
  String toString() {
    return 'AppointmentsExceptions: Error retrieving Appointments';
  }
}
