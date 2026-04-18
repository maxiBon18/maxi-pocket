import 'package:drift/drift.dart';

class CommonDataTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get amount => real().check(amount.isBiggerOrEqualValue(0))();
}
