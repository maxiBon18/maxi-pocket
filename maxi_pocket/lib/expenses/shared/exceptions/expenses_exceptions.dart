import 'package:flutter/foundation.dart';

/// Thrown when the expenses data source returns an empty or null result set.
///
/// Used by [ExpensesNotifier] to distinguish the "no data" case from a genuine
/// retrieval failure so the UI can show an empty-state widget instead of an error.
@immutable
class NullOrEmptyExpensesExceptions implements Exception {
  const NullOrEmptyExpensesExceptions();

  @override
  String toString() {
    return 'ExpensesExceptions: Null or Empty Expenses';
  }
}

/// Wraps an unexpected error and its stack trace that occurred while fetching expenses.
///
/// Pages check for this type in the [AsyncValue.error] callback and route to the
/// error-content widget rather than the empty-state widget.
class ErrorRetrievingExpensesExceptions implements Exception {
  final Object error;
  final StackTrace stackTrace;

  ErrorRetrievingExpensesExceptions({
    required this.error,
    required this.stackTrace,
  });

  @override
  String toString() {
    return 'ExpensesExceptions: Error retrieving Expenses';
  }
}
