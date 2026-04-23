import 'package:flutter/foundation.dart' show immutable;

@immutable
class WrongTableJoinQueryExceptions implements Exception {
  const WrongTableJoinQueryExceptions();

  @override
  String toString() {
    return 'DbExceptions: Wrong Type section for Join Query';
  }
}
