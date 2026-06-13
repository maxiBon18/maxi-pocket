import 'package:drift/drift.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketExpensesType, MaxiPocketExpensesFrequency;

/// Drift table holding shared metadata for every expense record (subscriptions, financing, appointments).
///
/// Each feature-specific table references this table via a foreign key on [primaryId].
@DataClassName('CommonData')
class CommonDataTable extends Table {
  /// Auto-incremented surrogate key shared by all expense types.
  Int64Column get primaryId => int64().autoIncrement()();

  /// Human-readable label for the expense entry; must be non-empty.
  TextColumn get name => text().check(name.length.isBiggerThanValue(0))();

  /// Discriminator storing which feature table this row belongs to.
  IntColumn get eventType => intEnum<MaxiPocketExpensesType>()();

  /// Date of the tracked event or first payment.
  DateTimeColumn get eventDate => dateTime().withDefault(currentDateAndTime)();

  /// Timestamp when the row was first inserted.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Timestamp of the most recent update to this row.
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Drift table for recurring subscription expenses, joined to [CommonDataTable] via [foreignId].
@DataClassName('Subscriptions')
class SubscriptionsTable extends Table {
  /// Auto-incremented primary key for this table.
  Int64Column get primaryId => int64().autoIncrement()();

  /// Monthly or annual charge amount; must be non-negative.
  RealColumn get amount => real().check(amount.isBiggerOrEqualValue(0))();

  /// Billing cycle (monthly or annual) stored as an integer enum.
  IntColumn get expensesFrequency => intEnum<MaxiPocketExpensesFrequency>()();

  /// Date of the upcoming payment for this subscription.
  DateTimeColumn get nextPaymentDate =>
      dateTime().withDefault(currentDateAndTime)();

  /// Foreign key linking this row to its [CommonDataTable] parent record.
  Int64Column get foreignId =>
      int64().unique().references(CommonDataTable, #primaryId)();
}

/// Drift table for instalment-based financing expenses, joined to [CommonDataTable] via [foreignId].
@DataClassName('Financing')
class FinancingTable extends Table {
  /// Auto-incremented primary key for this table.
  Int64Column get primaryId => int64().autoIncrement()();

  /// Per-instalment charge amount; must be non-negative.
  RealColumn get amount => real().check(amount.isBiggerOrEqualValue(0))();

  /// Total number of instalments for this financing agreement.
  IntColumn get numberOfInstallments =>
      integer().check(numberOfInstallments.isBiggerOrEqualValue(0))();

  /// Count of instalments already paid off.
  IntColumn get numberOfPaidInstallments =>
      integer().check(numberOfPaidInstallments.isBiggerOrEqualValue(0))();

  /// Date of the next scheduled instalment payment.
  DateTimeColumn get nextPaymentDate =>
      dateTime().withDefault(currentDateAndTime)();

  /// Foreign key linking this row to its [CommonDataTable] parent record.
  Int64Column get foreignId =>
      int64().unique().references(CommonDataTable, #primaryId)();
}

/// Drift table for appointment records, joined to [CommonDataTable] via [foreignId].
@DataClassName('Appointment')
class AppointmentsTable extends Table {
  /// Auto-incremented primary key for this table.
  Int64Column get primaryId => int64().autoIncrement()();

  /// Physical or virtual venue for the appointment; must be non-empty.
  TextColumn get location =>
      text().check(location.length.isBiggerThanValue(0))();

  /// Hour of the appointment; must be non-empty.
  TextColumn get hour => text().check(hour.length.isBiggerThanValue(0))();

  /// Foreign key linking this row to its [CommonDataTable] parent record.
  Int64Column get foreignId =>
      int64().unique().references(CommonDataTable, #primaryId)();
}
