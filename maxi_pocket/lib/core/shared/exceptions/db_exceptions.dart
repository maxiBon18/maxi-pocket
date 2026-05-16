import 'package:flutter/foundation.dart' show immutable;

/// Thrown when a Drift join query receives an unsupported or mismatched table type.
@immutable
class WrongTableJoinQueryExceptions implements Exception {
  const WrongTableJoinQueryExceptions();

  @override
  String toString() {
    return 'DbExceptions: Wrong Type section for Join Query';
  }
}
