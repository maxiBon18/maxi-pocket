import 'package:drift/drift.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketExpensesType, MaxiPocketExpensesFrequency;

@DataClassName('CommonData')
class CommonDataTable extends Table {
  Int64Column get primaryId => int64().autoIncrement()();
  TextColumn get name => text().check(name.length.isBiggerThanValue(0))();
  IntColumn get eventType => intEnum<MaxiPocketExpensesType>()();
  DateTimeColumn get eventDate => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('Subscriptions')
class SubscriptionsTable extends Table {
  Int64Column get primaryId => int64().autoIncrement()();
  RealColumn get amount => real().check(amount.isBiggerOrEqualValue(0))();
  IntColumn get expensesFrequency => intEnum<MaxiPocketExpensesFrequency>()();
  DateTimeColumn get nextPaymentDate => dateTime().withDefault(currentDateAndTime)();
  Int64Column get foreignId => int64().unique().references(CommonDataTable, #primaryId)();
}

@DataClassName('Financing')
class FinancingTable extends Table {
  Int64Column get primaryId => int64().autoIncrement()();
  RealColumn get amount => real().check(amount.isBiggerOrEqualValue(0))();
  IntColumn get numberOfInstallments => integer().check(numberOfInstallments.isBiggerOrEqualValue(0))();
  IntColumn get numberOfPaidInstallments => integer().check(numberOfPaidInstallments.isBiggerOrEqualValue(0))();
  DateTimeColumn get nextPaymentDate => dateTime().withDefault(currentDateAndTime)();
  Int64Column get foreignId => int64().unique().references(CommonDataTable, #primaryId)();
}

@DataClassName('Appointment')
class AppointmentsTable extends Table {
  Int64Column get primaryId => int64().autoIncrement()();
  TextColumn get location => text().check(location.length.isBiggerThanValue(0))();
  Int64Column get foreignId => int64().unique().references(CommonDataTable, #primaryId)();
}
