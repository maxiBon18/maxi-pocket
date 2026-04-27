// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_source_impl.dart';

// ignore_for_file: type=lint
class $CommonDataTableTable extends CommonDataTable
    with TableInfo<$CommonDataTableTable, CommonData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommonDataTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _primaryIdMeta = const VerificationMeta(
    'primaryId',
  );
  @override
  late final GeneratedColumn<BigInt> primaryId = GeneratedColumn<BigInt>(
    'primary_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    check: () => ComparableExpr(name.length).isBiggerThanValue(0),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MaxiPocketExpensesType, int>
  eventType =
      GeneratedColumn<int>(
        'event_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<MaxiPocketExpensesType>(
        $CommonDataTableTable.$convertereventType,
      );
  static const VerificationMeta _eventDateMeta = const VerificationMeta(
    'eventDate',
  );
  @override
  late final GeneratedColumn<DateTime> eventDate = GeneratedColumn<DateTime>(
    'event_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    primaryId,
    name,
    eventType,
    eventDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'common_data_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CommonData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('primary_id')) {
      context.handle(
        _primaryIdMeta,
        primaryId.isAcceptableOrUnknown(data['primary_id']!, _primaryIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('event_date')) {
      context.handle(
        _eventDateMeta,
        eventDate.isAcceptableOrUnknown(data['event_date']!, _eventDateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {primaryId};
  @override
  CommonData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommonData(
      primaryId: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}primary_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      eventType: $CommonDataTableTable.$convertereventType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}event_type'],
        )!,
      ),
      eventDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}event_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CommonDataTableTable createAlias(String alias) {
    return $CommonDataTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MaxiPocketExpensesType, int, int>
  $convertereventType = const EnumIndexConverter<MaxiPocketExpensesType>(
    MaxiPocketExpensesType.values,
  );
}

class CommonData extends DataClass implements Insertable<CommonData> {
  final BigInt primaryId;
  final String name;
  final MaxiPocketExpensesType eventType;
  final DateTime eventDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CommonData({
    required this.primaryId,
    required this.name,
    required this.eventType,
    required this.eventDate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['primary_id'] = Variable<BigInt>(primaryId);
    map['name'] = Variable<String>(name);
    {
      map['event_type'] = Variable<int>(
        $CommonDataTableTable.$convertereventType.toSql(eventType),
      );
    }
    map['event_date'] = Variable<DateTime>(eventDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CommonDataTableCompanion toCompanion(bool nullToAbsent) {
    return CommonDataTableCompanion(
      primaryId: Value(primaryId),
      name: Value(name),
      eventType: Value(eventType),
      eventDate: Value(eventDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CommonData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommonData(
      primaryId: serializer.fromJson<BigInt>(json['primaryId']),
      name: serializer.fromJson<String>(json['name']),
      eventType: $CommonDataTableTable.$convertereventType.fromJson(
        serializer.fromJson<int>(json['eventType']),
      ),
      eventDate: serializer.fromJson<DateTime>(json['eventDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'primaryId': serializer.toJson<BigInt>(primaryId),
      'name': serializer.toJson<String>(name),
      'eventType': serializer.toJson<int>(
        $CommonDataTableTable.$convertereventType.toJson(eventType),
      ),
      'eventDate': serializer.toJson<DateTime>(eventDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CommonData copyWith({
    BigInt? primaryId,
    String? name,
    MaxiPocketExpensesType? eventType,
    DateTime? eventDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CommonData(
    primaryId: primaryId ?? this.primaryId,
    name: name ?? this.name,
    eventType: eventType ?? this.eventType,
    eventDate: eventDate ?? this.eventDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CommonData copyWithCompanion(CommonDataTableCompanion data) {
    return CommonData(
      primaryId: data.primaryId.present ? data.primaryId.value : this.primaryId,
      name: data.name.present ? data.name.value : this.name,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      eventDate: data.eventDate.present ? data.eventDate.value : this.eventDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommonData(')
          ..write('primaryId: $primaryId, ')
          ..write('name: $name, ')
          ..write('eventType: $eventType, ')
          ..write('eventDate: $eventDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(primaryId, name, eventType, eventDate, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommonData &&
          other.primaryId == this.primaryId &&
          other.name == this.name &&
          other.eventType == this.eventType &&
          other.eventDate == this.eventDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CommonDataTableCompanion extends UpdateCompanion<CommonData> {
  final Value<BigInt> primaryId;
  final Value<String> name;
  final Value<MaxiPocketExpensesType> eventType;
  final Value<DateTime> eventDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CommonDataTableCompanion({
    this.primaryId = const Value.absent(),
    this.name = const Value.absent(),
    this.eventType = const Value.absent(),
    this.eventDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CommonDataTableCompanion.insert({
    this.primaryId = const Value.absent(),
    required String name,
    required MaxiPocketExpensesType eventType,
    this.eventDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       eventType = Value(eventType);
  static Insertable<CommonData> custom({
    Expression<BigInt>? primaryId,
    Expression<String>? name,
    Expression<int>? eventType,
    Expression<DateTime>? eventDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (primaryId != null) 'primary_id': primaryId,
      if (name != null) 'name': name,
      if (eventType != null) 'event_type': eventType,
      if (eventDate != null) 'event_date': eventDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CommonDataTableCompanion copyWith({
    Value<BigInt>? primaryId,
    Value<String>? name,
    Value<MaxiPocketExpensesType>? eventType,
    Value<DateTime>? eventDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CommonDataTableCompanion(
      primaryId: primaryId ?? this.primaryId,
      name: name ?? this.name,
      eventType: eventType ?? this.eventType,
      eventDate: eventDate ?? this.eventDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (primaryId.present) {
      map['primary_id'] = Variable<BigInt>(primaryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<int>(
        $CommonDataTableTable.$convertereventType.toSql(eventType.value),
      );
    }
    if (eventDate.present) {
      map['event_date'] = Variable<DateTime>(eventDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommonDataTableCompanion(')
          ..write('primaryId: $primaryId, ')
          ..write('name: $name, ')
          ..write('eventType: $eventType, ')
          ..write('eventDate: $eventDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FinancingTableTable extends FinancingTable
    with TableInfo<$FinancingTableTable, Financing> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinancingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _primaryIdMeta = const VerificationMeta(
    'primaryId',
  );
  @override
  late final GeneratedColumn<BigInt> primaryId = GeneratedColumn<BigInt>(
    'primary_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    check: () => ComparableExpr(amount).isBiggerOrEqualValue(0),
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberOfInstallmentsMeta =
      const VerificationMeta('numberOfInstallments');
  @override
  late final GeneratedColumn<int> numberOfInstallments = GeneratedColumn<int>(
    'number_of_installments',
    aliasedName,
    false,
    check: () => ComparableExpr(numberOfInstallments).isBiggerOrEqualValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberOfPaidInstallmentsMeta =
      const VerificationMeta('numberOfPaidInstallments');
  @override
  late final GeneratedColumn<int> numberOfPaidInstallments =
      GeneratedColumn<int>(
        'number_of_paid_installments',
        aliasedName,
        false,
        check: () =>
            ComparableExpr(numberOfPaidInstallments).isBiggerOrEqualValue(0),
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _nextPaymentDateMeta = const VerificationMeta(
    'nextPaymentDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextPaymentDate =
      GeneratedColumn<DateTime>(
        'next_payment_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  static const VerificationMeta _foreignIdMeta = const VerificationMeta(
    'foreignId',
  );
  @override
  late final GeneratedColumn<BigInt> foreignId = GeneratedColumn<BigInt>(
    'foreign_id',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES common_data_table (primary_id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    primaryId,
    amount,
    numberOfInstallments,
    numberOfPaidInstallments,
    nextPaymentDate,
    foreignId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'financing_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<Financing> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('primary_id')) {
      context.handle(
        _primaryIdMeta,
        primaryId.isAcceptableOrUnknown(data['primary_id']!, _primaryIdMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('number_of_installments')) {
      context.handle(
        _numberOfInstallmentsMeta,
        numberOfInstallments.isAcceptableOrUnknown(
          data['number_of_installments']!,
          _numberOfInstallmentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numberOfInstallmentsMeta);
    }
    if (data.containsKey('number_of_paid_installments')) {
      context.handle(
        _numberOfPaidInstallmentsMeta,
        numberOfPaidInstallments.isAcceptableOrUnknown(
          data['number_of_paid_installments']!,
          _numberOfPaidInstallmentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numberOfPaidInstallmentsMeta);
    }
    if (data.containsKey('next_payment_date')) {
      context.handle(
        _nextPaymentDateMeta,
        nextPaymentDate.isAcceptableOrUnknown(
          data['next_payment_date']!,
          _nextPaymentDateMeta,
        ),
      );
    }
    if (data.containsKey('foreign_id')) {
      context.handle(
        _foreignIdMeta,
        foreignId.isAcceptableOrUnknown(data['foreign_id']!, _foreignIdMeta),
      );
    } else if (isInserting) {
      context.missing(_foreignIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {primaryId};
  @override
  Financing map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Financing(
      primaryId: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}primary_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      numberOfInstallments: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_of_installments'],
      )!,
      numberOfPaidInstallments: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_of_paid_installments'],
      )!,
      nextPaymentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_payment_date'],
      )!,
      foreignId: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}foreign_id'],
      )!,
    );
  }

  @override
  $FinancingTableTable createAlias(String alias) {
    return $FinancingTableTable(attachedDatabase, alias);
  }
}

class Financing extends DataClass implements Insertable<Financing> {
  final BigInt primaryId;
  final double amount;
  final int numberOfInstallments;
  final int numberOfPaidInstallments;
  final DateTime nextPaymentDate;
  final BigInt foreignId;
  const Financing({
    required this.primaryId,
    required this.amount,
    required this.numberOfInstallments,
    required this.numberOfPaidInstallments,
    required this.nextPaymentDate,
    required this.foreignId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['primary_id'] = Variable<BigInt>(primaryId);
    map['amount'] = Variable<double>(amount);
    map['number_of_installments'] = Variable<int>(numberOfInstallments);
    map['number_of_paid_installments'] = Variable<int>(
      numberOfPaidInstallments,
    );
    map['next_payment_date'] = Variable<DateTime>(nextPaymentDate);
    map['foreign_id'] = Variable<BigInt>(foreignId);
    return map;
  }

  FinancingTableCompanion toCompanion(bool nullToAbsent) {
    return FinancingTableCompanion(
      primaryId: Value(primaryId),
      amount: Value(amount),
      numberOfInstallments: Value(numberOfInstallments),
      numberOfPaidInstallments: Value(numberOfPaidInstallments),
      nextPaymentDate: Value(nextPaymentDate),
      foreignId: Value(foreignId),
    );
  }

  factory Financing.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Financing(
      primaryId: serializer.fromJson<BigInt>(json['primaryId']),
      amount: serializer.fromJson<double>(json['amount']),
      numberOfInstallments: serializer.fromJson<int>(
        json['numberOfInstallments'],
      ),
      numberOfPaidInstallments: serializer.fromJson<int>(
        json['numberOfPaidInstallments'],
      ),
      nextPaymentDate: serializer.fromJson<DateTime>(json['nextPaymentDate']),
      foreignId: serializer.fromJson<BigInt>(json['foreignId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'primaryId': serializer.toJson<BigInt>(primaryId),
      'amount': serializer.toJson<double>(amount),
      'numberOfInstallments': serializer.toJson<int>(numberOfInstallments),
      'numberOfPaidInstallments': serializer.toJson<int>(
        numberOfPaidInstallments,
      ),
      'nextPaymentDate': serializer.toJson<DateTime>(nextPaymentDate),
      'foreignId': serializer.toJson<BigInt>(foreignId),
    };
  }

  Financing copyWith({
    BigInt? primaryId,
    double? amount,
    int? numberOfInstallments,
    int? numberOfPaidInstallments,
    DateTime? nextPaymentDate,
    BigInt? foreignId,
  }) => Financing(
    primaryId: primaryId ?? this.primaryId,
    amount: amount ?? this.amount,
    numberOfInstallments: numberOfInstallments ?? this.numberOfInstallments,
    numberOfPaidInstallments:
        numberOfPaidInstallments ?? this.numberOfPaidInstallments,
    nextPaymentDate: nextPaymentDate ?? this.nextPaymentDate,
    foreignId: foreignId ?? this.foreignId,
  );
  Financing copyWithCompanion(FinancingTableCompanion data) {
    return Financing(
      primaryId: data.primaryId.present ? data.primaryId.value : this.primaryId,
      amount: data.amount.present ? data.amount.value : this.amount,
      numberOfInstallments: data.numberOfInstallments.present
          ? data.numberOfInstallments.value
          : this.numberOfInstallments,
      numberOfPaidInstallments: data.numberOfPaidInstallments.present
          ? data.numberOfPaidInstallments.value
          : this.numberOfPaidInstallments,
      nextPaymentDate: data.nextPaymentDate.present
          ? data.nextPaymentDate.value
          : this.nextPaymentDate,
      foreignId: data.foreignId.present ? data.foreignId.value : this.foreignId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Financing(')
          ..write('primaryId: $primaryId, ')
          ..write('amount: $amount, ')
          ..write('numberOfInstallments: $numberOfInstallments, ')
          ..write('numberOfPaidInstallments: $numberOfPaidInstallments, ')
          ..write('nextPaymentDate: $nextPaymentDate, ')
          ..write('foreignId: $foreignId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    primaryId,
    amount,
    numberOfInstallments,
    numberOfPaidInstallments,
    nextPaymentDate,
    foreignId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Financing &&
          other.primaryId == this.primaryId &&
          other.amount == this.amount &&
          other.numberOfInstallments == this.numberOfInstallments &&
          other.numberOfPaidInstallments == this.numberOfPaidInstallments &&
          other.nextPaymentDate == this.nextPaymentDate &&
          other.foreignId == this.foreignId);
}

class FinancingTableCompanion extends UpdateCompanion<Financing> {
  final Value<BigInt> primaryId;
  final Value<double> amount;
  final Value<int> numberOfInstallments;
  final Value<int> numberOfPaidInstallments;
  final Value<DateTime> nextPaymentDate;
  final Value<BigInt> foreignId;
  const FinancingTableCompanion({
    this.primaryId = const Value.absent(),
    this.amount = const Value.absent(),
    this.numberOfInstallments = const Value.absent(),
    this.numberOfPaidInstallments = const Value.absent(),
    this.nextPaymentDate = const Value.absent(),
    this.foreignId = const Value.absent(),
  });
  FinancingTableCompanion.insert({
    this.primaryId = const Value.absent(),
    required double amount,
    required int numberOfInstallments,
    required int numberOfPaidInstallments,
    this.nextPaymentDate = const Value.absent(),
    required BigInt foreignId,
  }) : amount = Value(amount),
       numberOfInstallments = Value(numberOfInstallments),
       numberOfPaidInstallments = Value(numberOfPaidInstallments),
       foreignId = Value(foreignId);
  static Insertable<Financing> custom({
    Expression<BigInt>? primaryId,
    Expression<double>? amount,
    Expression<int>? numberOfInstallments,
    Expression<int>? numberOfPaidInstallments,
    Expression<DateTime>? nextPaymentDate,
    Expression<BigInt>? foreignId,
  }) {
    return RawValuesInsertable({
      if (primaryId != null) 'primary_id': primaryId,
      if (amount != null) 'amount': amount,
      if (numberOfInstallments != null)
        'number_of_installments': numberOfInstallments,
      if (numberOfPaidInstallments != null)
        'number_of_paid_installments': numberOfPaidInstallments,
      if (nextPaymentDate != null) 'next_payment_date': nextPaymentDate,
      if (foreignId != null) 'foreign_id': foreignId,
    });
  }

  FinancingTableCompanion copyWith({
    Value<BigInt>? primaryId,
    Value<double>? amount,
    Value<int>? numberOfInstallments,
    Value<int>? numberOfPaidInstallments,
    Value<DateTime>? nextPaymentDate,
    Value<BigInt>? foreignId,
  }) {
    return FinancingTableCompanion(
      primaryId: primaryId ?? this.primaryId,
      amount: amount ?? this.amount,
      numberOfInstallments: numberOfInstallments ?? this.numberOfInstallments,
      numberOfPaidInstallments:
          numberOfPaidInstallments ?? this.numberOfPaidInstallments,
      nextPaymentDate: nextPaymentDate ?? this.nextPaymentDate,
      foreignId: foreignId ?? this.foreignId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (primaryId.present) {
      map['primary_id'] = Variable<BigInt>(primaryId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (numberOfInstallments.present) {
      map['number_of_installments'] = Variable<int>(numberOfInstallments.value);
    }
    if (numberOfPaidInstallments.present) {
      map['number_of_paid_installments'] = Variable<int>(
        numberOfPaidInstallments.value,
      );
    }
    if (nextPaymentDate.present) {
      map['next_payment_date'] = Variable<DateTime>(nextPaymentDate.value);
    }
    if (foreignId.present) {
      map['foreign_id'] = Variable<BigInt>(foreignId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinancingTableCompanion(')
          ..write('primaryId: $primaryId, ')
          ..write('amount: $amount, ')
          ..write('numberOfInstallments: $numberOfInstallments, ')
          ..write('numberOfPaidInstallments: $numberOfPaidInstallments, ')
          ..write('nextPaymentDate: $nextPaymentDate, ')
          ..write('foreignId: $foreignId')
          ..write(')'))
        .toString();
  }
}

class $SubscriptionsTableTable extends SubscriptionsTable
    with TableInfo<$SubscriptionsTableTable, Subscriptions> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubscriptionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _primaryIdMeta = const VerificationMeta(
    'primaryId',
  );
  @override
  late final GeneratedColumn<BigInt> primaryId = GeneratedColumn<BigInt>(
    'primary_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    check: () => ComparableExpr(amount).isBiggerOrEqualValue(0),
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MaxiPocketExpensesFrequency, int>
  expensesFrequency =
      GeneratedColumn<int>(
        'expenses_frequency',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<MaxiPocketExpensesFrequency>(
        $SubscriptionsTableTable.$converterexpensesFrequency,
      );
  static const VerificationMeta _nextPaymentDateMeta = const VerificationMeta(
    'nextPaymentDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextPaymentDate =
      GeneratedColumn<DateTime>(
        'next_payment_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  static const VerificationMeta _foreignIdMeta = const VerificationMeta(
    'foreignId',
  );
  @override
  late final GeneratedColumn<BigInt> foreignId = GeneratedColumn<BigInt>(
    'foreign_id',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES common_data_table (primary_id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    primaryId,
    amount,
    expensesFrequency,
    nextPaymentDate,
    foreignId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subscriptions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<Subscriptions> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('primary_id')) {
      context.handle(
        _primaryIdMeta,
        primaryId.isAcceptableOrUnknown(data['primary_id']!, _primaryIdMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('next_payment_date')) {
      context.handle(
        _nextPaymentDateMeta,
        nextPaymentDate.isAcceptableOrUnknown(
          data['next_payment_date']!,
          _nextPaymentDateMeta,
        ),
      );
    }
    if (data.containsKey('foreign_id')) {
      context.handle(
        _foreignIdMeta,
        foreignId.isAcceptableOrUnknown(data['foreign_id']!, _foreignIdMeta),
      );
    } else if (isInserting) {
      context.missing(_foreignIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {primaryId};
  @override
  Subscriptions map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subscriptions(
      primaryId: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}primary_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      expensesFrequency: $SubscriptionsTableTable.$converterexpensesFrequency
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.int,
              data['${effectivePrefix}expenses_frequency'],
            )!,
          ),
      nextPaymentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_payment_date'],
      )!,
      foreignId: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}foreign_id'],
      )!,
    );
  }

  @override
  $SubscriptionsTableTable createAlias(String alias) {
    return $SubscriptionsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MaxiPocketExpensesFrequency, int, int>
  $converterexpensesFrequency =
      const EnumIndexConverter<MaxiPocketExpensesFrequency>(
        MaxiPocketExpensesFrequency.values,
      );
}

class Subscriptions extends DataClass implements Insertable<Subscriptions> {
  final BigInt primaryId;
  final double amount;
  final MaxiPocketExpensesFrequency expensesFrequency;
  final DateTime nextPaymentDate;
  final BigInt foreignId;
  const Subscriptions({
    required this.primaryId,
    required this.amount,
    required this.expensesFrequency,
    required this.nextPaymentDate,
    required this.foreignId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['primary_id'] = Variable<BigInt>(primaryId);
    map['amount'] = Variable<double>(amount);
    {
      map['expenses_frequency'] = Variable<int>(
        $SubscriptionsTableTable.$converterexpensesFrequency.toSql(
          expensesFrequency,
        ),
      );
    }
    map['next_payment_date'] = Variable<DateTime>(nextPaymentDate);
    map['foreign_id'] = Variable<BigInt>(foreignId);
    return map;
  }

  SubscriptionsTableCompanion toCompanion(bool nullToAbsent) {
    return SubscriptionsTableCompanion(
      primaryId: Value(primaryId),
      amount: Value(amount),
      expensesFrequency: Value(expensesFrequency),
      nextPaymentDate: Value(nextPaymentDate),
      foreignId: Value(foreignId),
    );
  }

  factory Subscriptions.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subscriptions(
      primaryId: serializer.fromJson<BigInt>(json['primaryId']),
      amount: serializer.fromJson<double>(json['amount']),
      expensesFrequency: $SubscriptionsTableTable.$converterexpensesFrequency
          .fromJson(serializer.fromJson<int>(json['expensesFrequency'])),
      nextPaymentDate: serializer.fromJson<DateTime>(json['nextPaymentDate']),
      foreignId: serializer.fromJson<BigInt>(json['foreignId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'primaryId': serializer.toJson<BigInt>(primaryId),
      'amount': serializer.toJson<double>(amount),
      'expensesFrequency': serializer.toJson<int>(
        $SubscriptionsTableTable.$converterexpensesFrequency.toJson(
          expensesFrequency,
        ),
      ),
      'nextPaymentDate': serializer.toJson<DateTime>(nextPaymentDate),
      'foreignId': serializer.toJson<BigInt>(foreignId),
    };
  }

  Subscriptions copyWith({
    BigInt? primaryId,
    double? amount,
    MaxiPocketExpensesFrequency? expensesFrequency,
    DateTime? nextPaymentDate,
    BigInt? foreignId,
  }) => Subscriptions(
    primaryId: primaryId ?? this.primaryId,
    amount: amount ?? this.amount,
    expensesFrequency: expensesFrequency ?? this.expensesFrequency,
    nextPaymentDate: nextPaymentDate ?? this.nextPaymentDate,
    foreignId: foreignId ?? this.foreignId,
  );
  Subscriptions copyWithCompanion(SubscriptionsTableCompanion data) {
    return Subscriptions(
      primaryId: data.primaryId.present ? data.primaryId.value : this.primaryId,
      amount: data.amount.present ? data.amount.value : this.amount,
      expensesFrequency: data.expensesFrequency.present
          ? data.expensesFrequency.value
          : this.expensesFrequency,
      nextPaymentDate: data.nextPaymentDate.present
          ? data.nextPaymentDate.value
          : this.nextPaymentDate,
      foreignId: data.foreignId.present ? data.foreignId.value : this.foreignId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subscriptions(')
          ..write('primaryId: $primaryId, ')
          ..write('amount: $amount, ')
          ..write('expensesFrequency: $expensesFrequency, ')
          ..write('nextPaymentDate: $nextPaymentDate, ')
          ..write('foreignId: $foreignId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    primaryId,
    amount,
    expensesFrequency,
    nextPaymentDate,
    foreignId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subscriptions &&
          other.primaryId == this.primaryId &&
          other.amount == this.amount &&
          other.expensesFrequency == this.expensesFrequency &&
          other.nextPaymentDate == this.nextPaymentDate &&
          other.foreignId == this.foreignId);
}

class SubscriptionsTableCompanion extends UpdateCompanion<Subscriptions> {
  final Value<BigInt> primaryId;
  final Value<double> amount;
  final Value<MaxiPocketExpensesFrequency> expensesFrequency;
  final Value<DateTime> nextPaymentDate;
  final Value<BigInt> foreignId;
  const SubscriptionsTableCompanion({
    this.primaryId = const Value.absent(),
    this.amount = const Value.absent(),
    this.expensesFrequency = const Value.absent(),
    this.nextPaymentDate = const Value.absent(),
    this.foreignId = const Value.absent(),
  });
  SubscriptionsTableCompanion.insert({
    this.primaryId = const Value.absent(),
    required double amount,
    required MaxiPocketExpensesFrequency expensesFrequency,
    this.nextPaymentDate = const Value.absent(),
    required BigInt foreignId,
  }) : amount = Value(amount),
       expensesFrequency = Value(expensesFrequency),
       foreignId = Value(foreignId);
  static Insertable<Subscriptions> custom({
    Expression<BigInt>? primaryId,
    Expression<double>? amount,
    Expression<int>? expensesFrequency,
    Expression<DateTime>? nextPaymentDate,
    Expression<BigInt>? foreignId,
  }) {
    return RawValuesInsertable({
      if (primaryId != null) 'primary_id': primaryId,
      if (amount != null) 'amount': amount,
      if (expensesFrequency != null) 'expenses_frequency': expensesFrequency,
      if (nextPaymentDate != null) 'next_payment_date': nextPaymentDate,
      if (foreignId != null) 'foreign_id': foreignId,
    });
  }

  SubscriptionsTableCompanion copyWith({
    Value<BigInt>? primaryId,
    Value<double>? amount,
    Value<MaxiPocketExpensesFrequency>? expensesFrequency,
    Value<DateTime>? nextPaymentDate,
    Value<BigInt>? foreignId,
  }) {
    return SubscriptionsTableCompanion(
      primaryId: primaryId ?? this.primaryId,
      amount: amount ?? this.amount,
      expensesFrequency: expensesFrequency ?? this.expensesFrequency,
      nextPaymentDate: nextPaymentDate ?? this.nextPaymentDate,
      foreignId: foreignId ?? this.foreignId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (primaryId.present) {
      map['primary_id'] = Variable<BigInt>(primaryId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (expensesFrequency.present) {
      map['expenses_frequency'] = Variable<int>(
        $SubscriptionsTableTable.$converterexpensesFrequency.toSql(
          expensesFrequency.value,
        ),
      );
    }
    if (nextPaymentDate.present) {
      map['next_payment_date'] = Variable<DateTime>(nextPaymentDate.value);
    }
    if (foreignId.present) {
      map['foreign_id'] = Variable<BigInt>(foreignId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubscriptionsTableCompanion(')
          ..write('primaryId: $primaryId, ')
          ..write('amount: $amount, ')
          ..write('expensesFrequency: $expensesFrequency, ')
          ..write('nextPaymentDate: $nextPaymentDate, ')
          ..write('foreignId: $foreignId')
          ..write(')'))
        .toString();
  }
}

class $AppointmentsTableTable extends AppointmentsTable
    with TableInfo<$AppointmentsTableTable, Appointment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppointmentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _primaryIdMeta = const VerificationMeta(
    'primaryId',
  );
  @override
  late final GeneratedColumn<BigInt> primaryId = GeneratedColumn<BigInt>(
    'primary_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    check: () => ComparableExpr(location.length).isBiggerThanValue(0),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foreignIdMeta = const VerificationMeta(
    'foreignId',
  );
  @override
  late final GeneratedColumn<BigInt> foreignId = GeneratedColumn<BigInt>(
    'foreign_id',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES common_data_table (primary_id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [primaryId, location, foreignId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'appointments_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<Appointment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('primary_id')) {
      context.handle(
        _primaryIdMeta,
        primaryId.isAcceptableOrUnknown(data['primary_id']!, _primaryIdMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('foreign_id')) {
      context.handle(
        _foreignIdMeta,
        foreignId.isAcceptableOrUnknown(data['foreign_id']!, _foreignIdMeta),
      );
    } else if (isInserting) {
      context.missing(_foreignIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {primaryId};
  @override
  Appointment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Appointment(
      primaryId: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}primary_id'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      foreignId: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}foreign_id'],
      )!,
    );
  }

  @override
  $AppointmentsTableTable createAlias(String alias) {
    return $AppointmentsTableTable(attachedDatabase, alias);
  }
}

class Appointment extends DataClass implements Insertable<Appointment> {
  final BigInt primaryId;
  final String location;
  final BigInt foreignId;
  const Appointment({
    required this.primaryId,
    required this.location,
    required this.foreignId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['primary_id'] = Variable<BigInt>(primaryId);
    map['location'] = Variable<String>(location);
    map['foreign_id'] = Variable<BigInt>(foreignId);
    return map;
  }

  AppointmentsTableCompanion toCompanion(bool nullToAbsent) {
    return AppointmentsTableCompanion(
      primaryId: Value(primaryId),
      location: Value(location),
      foreignId: Value(foreignId),
    );
  }

  factory Appointment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Appointment(
      primaryId: serializer.fromJson<BigInt>(json['primaryId']),
      location: serializer.fromJson<String>(json['location']),
      foreignId: serializer.fromJson<BigInt>(json['foreignId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'primaryId': serializer.toJson<BigInt>(primaryId),
      'location': serializer.toJson<String>(location),
      'foreignId': serializer.toJson<BigInt>(foreignId),
    };
  }

  Appointment copyWith({
    BigInt? primaryId,
    String? location,
    BigInt? foreignId,
  }) => Appointment(
    primaryId: primaryId ?? this.primaryId,
    location: location ?? this.location,
    foreignId: foreignId ?? this.foreignId,
  );
  Appointment copyWithCompanion(AppointmentsTableCompanion data) {
    return Appointment(
      primaryId: data.primaryId.present ? data.primaryId.value : this.primaryId,
      location: data.location.present ? data.location.value : this.location,
      foreignId: data.foreignId.present ? data.foreignId.value : this.foreignId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Appointment(')
          ..write('primaryId: $primaryId, ')
          ..write('location: $location, ')
          ..write('foreignId: $foreignId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(primaryId, location, foreignId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Appointment &&
          other.primaryId == this.primaryId &&
          other.location == this.location &&
          other.foreignId == this.foreignId);
}

class AppointmentsTableCompanion extends UpdateCompanion<Appointment> {
  final Value<BigInt> primaryId;
  final Value<String> location;
  final Value<BigInt> foreignId;
  const AppointmentsTableCompanion({
    this.primaryId = const Value.absent(),
    this.location = const Value.absent(),
    this.foreignId = const Value.absent(),
  });
  AppointmentsTableCompanion.insert({
    this.primaryId = const Value.absent(),
    required String location,
    required BigInt foreignId,
  }) : location = Value(location),
       foreignId = Value(foreignId);
  static Insertable<Appointment> custom({
    Expression<BigInt>? primaryId,
    Expression<String>? location,
    Expression<BigInt>? foreignId,
  }) {
    return RawValuesInsertable({
      if (primaryId != null) 'primary_id': primaryId,
      if (location != null) 'location': location,
      if (foreignId != null) 'foreign_id': foreignId,
    });
  }

  AppointmentsTableCompanion copyWith({
    Value<BigInt>? primaryId,
    Value<String>? location,
    Value<BigInt>? foreignId,
  }) {
    return AppointmentsTableCompanion(
      primaryId: primaryId ?? this.primaryId,
      location: location ?? this.location,
      foreignId: foreignId ?? this.foreignId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (primaryId.present) {
      map['primary_id'] = Variable<BigInt>(primaryId.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (foreignId.present) {
      map['foreign_id'] = Variable<BigInt>(foreignId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppointmentsTableCompanion(')
          ..write('primaryId: $primaryId, ')
          ..write('location: $location, ')
          ..write('foreignId: $foreignId')
          ..write(')'))
        .toString();
  }
}

abstract class _$MaxiPocketDatabase extends GeneratedDatabase {
  _$MaxiPocketDatabase(QueryExecutor e) : super(e);
  $MaxiPocketDatabaseManager get managers => $MaxiPocketDatabaseManager(this);
  late final $CommonDataTableTable commonDataTable = $CommonDataTableTable(
    this,
  );
  late final $FinancingTableTable financingTable = $FinancingTableTable(this);
  late final $SubscriptionsTableTable subscriptionsTable =
      $SubscriptionsTableTable(this);
  late final $AppointmentsTableTable appointmentsTable =
      $AppointmentsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    commonDataTable,
    financingTable,
    subscriptionsTable,
    appointmentsTable,
  ];
}

typedef $$CommonDataTableTableCreateCompanionBuilder =
    CommonDataTableCompanion Function({
      Value<BigInt> primaryId,
      required String name,
      required MaxiPocketExpensesType eventType,
      Value<DateTime> eventDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CommonDataTableTableUpdateCompanionBuilder =
    CommonDataTableCompanion Function({
      Value<BigInt> primaryId,
      Value<String> name,
      Value<MaxiPocketExpensesType> eventType,
      Value<DateTime> eventDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$CommonDataTableTableReferences
    extends
        BaseReferences<
          _$MaxiPocketDatabase,
          $CommonDataTableTable,
          CommonData
        > {
  $$CommonDataTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$FinancingTableTable, List<Financing>>
  _financingTableRefsTable(_$MaxiPocketDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.financingTable,
        aliasName: $_aliasNameGenerator(
          db.commonDataTable.primaryId,
          db.financingTable.foreignId,
        ),
      );

  $$FinancingTableTableProcessedTableManager get financingTableRefs {
    final manager = $$FinancingTableTableTableManager($_db, $_db.financingTable)
        .filter(
          (f) => f.foreignId.primaryId.sqlEquals(
            $_itemColumn<BigInt>('primary_id')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(_financingTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SubscriptionsTableTable, List<Subscriptions>>
  _subscriptionsTableRefsTable(_$MaxiPocketDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.subscriptionsTable,
        aliasName: $_aliasNameGenerator(
          db.commonDataTable.primaryId,
          db.subscriptionsTable.foreignId,
        ),
      );

  $$SubscriptionsTableTableProcessedTableManager get subscriptionsTableRefs {
    final manager =
        $$SubscriptionsTableTableTableManager(
          $_db,
          $_db.subscriptionsTable,
        ).filter(
          (f) => f.foreignId.primaryId.sqlEquals(
            $_itemColumn<BigInt>('primary_id')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(
      _subscriptionsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AppointmentsTableTable, List<Appointment>>
  _appointmentsTableRefsTable(_$MaxiPocketDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.appointmentsTable,
        aliasName: $_aliasNameGenerator(
          db.commonDataTable.primaryId,
          db.appointmentsTable.foreignId,
        ),
      );

  $$AppointmentsTableTableProcessedTableManager get appointmentsTableRefs {
    final manager =
        $$AppointmentsTableTableTableManager(
          $_db,
          $_db.appointmentsTable,
        ).filter(
          (f) => f.foreignId.primaryId.sqlEquals(
            $_itemColumn<BigInt>('primary_id')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(
      _appointmentsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CommonDataTableTableFilterComposer
    extends Composer<_$MaxiPocketDatabase, $CommonDataTableTable> {
  $$CommonDataTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get primaryId => $composableBuilder(
    column: $table.primaryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    MaxiPocketExpensesType,
    MaxiPocketExpensesType,
    int
  >
  get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get eventDate => $composableBuilder(
    column: $table.eventDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> financingTableRefs(
    Expression<bool> Function($$FinancingTableTableFilterComposer f) f,
  ) {
    final $$FinancingTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.primaryId,
      referencedTable: $db.financingTable,
      getReferencedColumn: (t) => t.foreignId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancingTableTableFilterComposer(
            $db: $db,
            $table: $db.financingTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> subscriptionsTableRefs(
    Expression<bool> Function($$SubscriptionsTableTableFilterComposer f) f,
  ) {
    final $$SubscriptionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.primaryId,
      referencedTable: $db.subscriptionsTable,
      getReferencedColumn: (t) => t.foreignId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubscriptionsTableTableFilterComposer(
            $db: $db,
            $table: $db.subscriptionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> appointmentsTableRefs(
    Expression<bool> Function($$AppointmentsTableTableFilterComposer f) f,
  ) {
    final $$AppointmentsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.primaryId,
      referencedTable: $db.appointmentsTable,
      getReferencedColumn: (t) => t.foreignId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppointmentsTableTableFilterComposer(
            $db: $db,
            $table: $db.appointmentsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CommonDataTableTableOrderingComposer
    extends Composer<_$MaxiPocketDatabase, $CommonDataTableTable> {
  $$CommonDataTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get primaryId => $composableBuilder(
    column: $table.primaryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get eventDate => $composableBuilder(
    column: $table.eventDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CommonDataTableTableAnnotationComposer
    extends Composer<_$MaxiPocketDatabase, $CommonDataTableTable> {
  $$CommonDataTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get primaryId =>
      $composableBuilder(column: $table.primaryId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MaxiPocketExpensesType, int> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<DateTime> get eventDate =>
      $composableBuilder(column: $table.eventDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> financingTableRefs<T extends Object>(
    Expression<T> Function($$FinancingTableTableAnnotationComposer a) f,
  ) {
    final $$FinancingTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.primaryId,
      referencedTable: $db.financingTable,
      getReferencedColumn: (t) => t.foreignId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinancingTableTableAnnotationComposer(
            $db: $db,
            $table: $db.financingTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> subscriptionsTableRefs<T extends Object>(
    Expression<T> Function($$SubscriptionsTableTableAnnotationComposer a) f,
  ) {
    final $$SubscriptionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.primaryId,
          referencedTable: $db.subscriptionsTable,
          getReferencedColumn: (t) => t.foreignId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SubscriptionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.subscriptionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> appointmentsTableRefs<T extends Object>(
    Expression<T> Function($$AppointmentsTableTableAnnotationComposer a) f,
  ) {
    final $$AppointmentsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.primaryId,
          referencedTable: $db.appointmentsTable,
          getReferencedColumn: (t) => t.foreignId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AppointmentsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.appointmentsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CommonDataTableTableTableManager
    extends
        RootTableManager<
          _$MaxiPocketDatabase,
          $CommonDataTableTable,
          CommonData,
          $$CommonDataTableTableFilterComposer,
          $$CommonDataTableTableOrderingComposer,
          $$CommonDataTableTableAnnotationComposer,
          $$CommonDataTableTableCreateCompanionBuilder,
          $$CommonDataTableTableUpdateCompanionBuilder,
          (CommonData, $$CommonDataTableTableReferences),
          CommonData,
          PrefetchHooks Function({
            bool financingTableRefs,
            bool subscriptionsTableRefs,
            bool appointmentsTableRefs,
          })
        > {
  $$CommonDataTableTableTableManager(
    _$MaxiPocketDatabase db,
    $CommonDataTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommonDataTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommonDataTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommonDataTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<BigInt> primaryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<MaxiPocketExpensesType> eventType = const Value.absent(),
                Value<DateTime> eventDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CommonDataTableCompanion(
                primaryId: primaryId,
                name: name,
                eventType: eventType,
                eventDate: eventDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<BigInt> primaryId = const Value.absent(),
                required String name,
                required MaxiPocketExpensesType eventType,
                Value<DateTime> eventDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CommonDataTableCompanion.insert(
                primaryId: primaryId,
                name: name,
                eventType: eventType,
                eventDate: eventDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CommonDataTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                financingTableRefs = false,
                subscriptionsTableRefs = false,
                appointmentsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (financingTableRefs) db.financingTable,
                    if (subscriptionsTableRefs) db.subscriptionsTable,
                    if (appointmentsTableRefs) db.appointmentsTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (financingTableRefs)
                        await $_getPrefetchedData<
                          CommonData,
                          $CommonDataTableTable,
                          Financing
                        >(
                          currentTable: table,
                          referencedTable: $$CommonDataTableTableReferences
                              ._financingTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CommonDataTableTableReferences(
                                db,
                                table,
                                p0,
                              ).financingTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.foreignId == item.primaryId,
                              ),
                          typedResults: items,
                        ),
                      if (subscriptionsTableRefs)
                        await $_getPrefetchedData<
                          CommonData,
                          $CommonDataTableTable,
                          Subscriptions
                        >(
                          currentTable: table,
                          referencedTable: $$CommonDataTableTableReferences
                              ._subscriptionsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CommonDataTableTableReferences(
                                db,
                                table,
                                p0,
                              ).subscriptionsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.foreignId == item.primaryId,
                              ),
                          typedResults: items,
                        ),
                      if (appointmentsTableRefs)
                        await $_getPrefetchedData<
                          CommonData,
                          $CommonDataTableTable,
                          Appointment
                        >(
                          currentTable: table,
                          referencedTable: $$CommonDataTableTableReferences
                              ._appointmentsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CommonDataTableTableReferences(
                                db,
                                table,
                                p0,
                              ).appointmentsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.foreignId == item.primaryId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CommonDataTableTableProcessedTableManager =
    ProcessedTableManager<
      _$MaxiPocketDatabase,
      $CommonDataTableTable,
      CommonData,
      $$CommonDataTableTableFilterComposer,
      $$CommonDataTableTableOrderingComposer,
      $$CommonDataTableTableAnnotationComposer,
      $$CommonDataTableTableCreateCompanionBuilder,
      $$CommonDataTableTableUpdateCompanionBuilder,
      (CommonData, $$CommonDataTableTableReferences),
      CommonData,
      PrefetchHooks Function({
        bool financingTableRefs,
        bool subscriptionsTableRefs,
        bool appointmentsTableRefs,
      })
    >;
typedef $$FinancingTableTableCreateCompanionBuilder =
    FinancingTableCompanion Function({
      Value<BigInt> primaryId,
      required double amount,
      required int numberOfInstallments,
      required int numberOfPaidInstallments,
      Value<DateTime> nextPaymentDate,
      required BigInt foreignId,
    });
typedef $$FinancingTableTableUpdateCompanionBuilder =
    FinancingTableCompanion Function({
      Value<BigInt> primaryId,
      Value<double> amount,
      Value<int> numberOfInstallments,
      Value<int> numberOfPaidInstallments,
      Value<DateTime> nextPaymentDate,
      Value<BigInt> foreignId,
    });

final class $$FinancingTableTableReferences
    extends
        BaseReferences<_$MaxiPocketDatabase, $FinancingTableTable, Financing> {
  $$FinancingTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CommonDataTableTable _foreignIdTable(_$MaxiPocketDatabase db) =>
      db.commonDataTable.createAlias(
        $_aliasNameGenerator(
          db.financingTable.foreignId,
          db.commonDataTable.primaryId,
        ),
      );

  $$CommonDataTableTableProcessedTableManager get foreignId {
    final $_column = $_itemColumn<BigInt>('foreign_id')!;

    final manager = $$CommonDataTableTableTableManager(
      $_db,
      $_db.commonDataTable,
    ).filter((f) => f.primaryId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foreignIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FinancingTableTableFilterComposer
    extends Composer<_$MaxiPocketDatabase, $FinancingTableTable> {
  $$FinancingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get primaryId => $composableBuilder(
    column: $table.primaryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberOfInstallments => $composableBuilder(
    column: $table.numberOfInstallments,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberOfPaidInstallments => $composableBuilder(
    column: $table.numberOfPaidInstallments,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextPaymentDate => $composableBuilder(
    column: $table.nextPaymentDate,
    builder: (column) => ColumnFilters(column),
  );

  $$CommonDataTableTableFilterComposer get foreignId {
    final $$CommonDataTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foreignId,
      referencedTable: $db.commonDataTable,
      getReferencedColumn: (t) => t.primaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommonDataTableTableFilterComposer(
            $db: $db,
            $table: $db.commonDataTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FinancingTableTableOrderingComposer
    extends Composer<_$MaxiPocketDatabase, $FinancingTableTable> {
  $$FinancingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get primaryId => $composableBuilder(
    column: $table.primaryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberOfInstallments => $composableBuilder(
    column: $table.numberOfInstallments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberOfPaidInstallments => $composableBuilder(
    column: $table.numberOfPaidInstallments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextPaymentDate => $composableBuilder(
    column: $table.nextPaymentDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$CommonDataTableTableOrderingComposer get foreignId {
    final $$CommonDataTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foreignId,
      referencedTable: $db.commonDataTable,
      getReferencedColumn: (t) => t.primaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommonDataTableTableOrderingComposer(
            $db: $db,
            $table: $db.commonDataTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FinancingTableTableAnnotationComposer
    extends Composer<_$MaxiPocketDatabase, $FinancingTableTable> {
  $$FinancingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get primaryId =>
      $composableBuilder(column: $table.primaryId, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<int> get numberOfInstallments => $composableBuilder(
    column: $table.numberOfInstallments,
    builder: (column) => column,
  );

  GeneratedColumn<int> get numberOfPaidInstallments => $composableBuilder(
    column: $table.numberOfPaidInstallments,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextPaymentDate => $composableBuilder(
    column: $table.nextPaymentDate,
    builder: (column) => column,
  );

  $$CommonDataTableTableAnnotationComposer get foreignId {
    final $$CommonDataTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foreignId,
      referencedTable: $db.commonDataTable,
      getReferencedColumn: (t) => t.primaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommonDataTableTableAnnotationComposer(
            $db: $db,
            $table: $db.commonDataTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FinancingTableTableTableManager
    extends
        RootTableManager<
          _$MaxiPocketDatabase,
          $FinancingTableTable,
          Financing,
          $$FinancingTableTableFilterComposer,
          $$FinancingTableTableOrderingComposer,
          $$FinancingTableTableAnnotationComposer,
          $$FinancingTableTableCreateCompanionBuilder,
          $$FinancingTableTableUpdateCompanionBuilder,
          (Financing, $$FinancingTableTableReferences),
          Financing,
          PrefetchHooks Function({bool foreignId})
        > {
  $$FinancingTableTableTableManager(
    _$MaxiPocketDatabase db,
    $FinancingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinancingTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FinancingTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FinancingTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<BigInt> primaryId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<int> numberOfInstallments = const Value.absent(),
                Value<int> numberOfPaidInstallments = const Value.absent(),
                Value<DateTime> nextPaymentDate = const Value.absent(),
                Value<BigInt> foreignId = const Value.absent(),
              }) => FinancingTableCompanion(
                primaryId: primaryId,
                amount: amount,
                numberOfInstallments: numberOfInstallments,
                numberOfPaidInstallments: numberOfPaidInstallments,
                nextPaymentDate: nextPaymentDate,
                foreignId: foreignId,
              ),
          createCompanionCallback:
              ({
                Value<BigInt> primaryId = const Value.absent(),
                required double amount,
                required int numberOfInstallments,
                required int numberOfPaidInstallments,
                Value<DateTime> nextPaymentDate = const Value.absent(),
                required BigInt foreignId,
              }) => FinancingTableCompanion.insert(
                primaryId: primaryId,
                amount: amount,
                numberOfInstallments: numberOfInstallments,
                numberOfPaidInstallments: numberOfPaidInstallments,
                nextPaymentDate: nextPaymentDate,
                foreignId: foreignId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FinancingTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({foreignId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (foreignId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.foreignId,
                                referencedTable: $$FinancingTableTableReferences
                                    ._foreignIdTable(db),
                                referencedColumn:
                                    $$FinancingTableTableReferences
                                        ._foreignIdTable(db)
                                        .primaryId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FinancingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$MaxiPocketDatabase,
      $FinancingTableTable,
      Financing,
      $$FinancingTableTableFilterComposer,
      $$FinancingTableTableOrderingComposer,
      $$FinancingTableTableAnnotationComposer,
      $$FinancingTableTableCreateCompanionBuilder,
      $$FinancingTableTableUpdateCompanionBuilder,
      (Financing, $$FinancingTableTableReferences),
      Financing,
      PrefetchHooks Function({bool foreignId})
    >;
typedef $$SubscriptionsTableTableCreateCompanionBuilder =
    SubscriptionsTableCompanion Function({
      Value<BigInt> primaryId,
      required double amount,
      required MaxiPocketExpensesFrequency expensesFrequency,
      Value<DateTime> nextPaymentDate,
      required BigInt foreignId,
    });
typedef $$SubscriptionsTableTableUpdateCompanionBuilder =
    SubscriptionsTableCompanion Function({
      Value<BigInt> primaryId,
      Value<double> amount,
      Value<MaxiPocketExpensesFrequency> expensesFrequency,
      Value<DateTime> nextPaymentDate,
      Value<BigInt> foreignId,
    });

final class $$SubscriptionsTableTableReferences
    extends
        BaseReferences<
          _$MaxiPocketDatabase,
          $SubscriptionsTableTable,
          Subscriptions
        > {
  $$SubscriptionsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CommonDataTableTable _foreignIdTable(_$MaxiPocketDatabase db) =>
      db.commonDataTable.createAlias(
        $_aliasNameGenerator(
          db.subscriptionsTable.foreignId,
          db.commonDataTable.primaryId,
        ),
      );

  $$CommonDataTableTableProcessedTableManager get foreignId {
    final $_column = $_itemColumn<BigInt>('foreign_id')!;

    final manager = $$CommonDataTableTableTableManager(
      $_db,
      $_db.commonDataTable,
    ).filter((f) => f.primaryId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foreignIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SubscriptionsTableTableFilterComposer
    extends Composer<_$MaxiPocketDatabase, $SubscriptionsTableTable> {
  $$SubscriptionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get primaryId => $composableBuilder(
    column: $table.primaryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    MaxiPocketExpensesFrequency,
    MaxiPocketExpensesFrequency,
    int
  >
  get expensesFrequency => $composableBuilder(
    column: $table.expensesFrequency,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get nextPaymentDate => $composableBuilder(
    column: $table.nextPaymentDate,
    builder: (column) => ColumnFilters(column),
  );

  $$CommonDataTableTableFilterComposer get foreignId {
    final $$CommonDataTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foreignId,
      referencedTable: $db.commonDataTable,
      getReferencedColumn: (t) => t.primaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommonDataTableTableFilterComposer(
            $db: $db,
            $table: $db.commonDataTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubscriptionsTableTableOrderingComposer
    extends Composer<_$MaxiPocketDatabase, $SubscriptionsTableTable> {
  $$SubscriptionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get primaryId => $composableBuilder(
    column: $table.primaryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expensesFrequency => $composableBuilder(
    column: $table.expensesFrequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextPaymentDate => $composableBuilder(
    column: $table.nextPaymentDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$CommonDataTableTableOrderingComposer get foreignId {
    final $$CommonDataTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foreignId,
      referencedTable: $db.commonDataTable,
      getReferencedColumn: (t) => t.primaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommonDataTableTableOrderingComposer(
            $db: $db,
            $table: $db.commonDataTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubscriptionsTableTableAnnotationComposer
    extends Composer<_$MaxiPocketDatabase, $SubscriptionsTableTable> {
  $$SubscriptionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get primaryId =>
      $composableBuilder(column: $table.primaryId, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MaxiPocketExpensesFrequency, int>
  get expensesFrequency => $composableBuilder(
    column: $table.expensesFrequency,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextPaymentDate => $composableBuilder(
    column: $table.nextPaymentDate,
    builder: (column) => column,
  );

  $$CommonDataTableTableAnnotationComposer get foreignId {
    final $$CommonDataTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foreignId,
      referencedTable: $db.commonDataTable,
      getReferencedColumn: (t) => t.primaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommonDataTableTableAnnotationComposer(
            $db: $db,
            $table: $db.commonDataTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubscriptionsTableTableTableManager
    extends
        RootTableManager<
          _$MaxiPocketDatabase,
          $SubscriptionsTableTable,
          Subscriptions,
          $$SubscriptionsTableTableFilterComposer,
          $$SubscriptionsTableTableOrderingComposer,
          $$SubscriptionsTableTableAnnotationComposer,
          $$SubscriptionsTableTableCreateCompanionBuilder,
          $$SubscriptionsTableTableUpdateCompanionBuilder,
          (Subscriptions, $$SubscriptionsTableTableReferences),
          Subscriptions,
          PrefetchHooks Function({bool foreignId})
        > {
  $$SubscriptionsTableTableTableManager(
    _$MaxiPocketDatabase db,
    $SubscriptionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubscriptionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubscriptionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubscriptionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<BigInt> primaryId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<MaxiPocketExpensesFrequency> expensesFrequency =
                    const Value.absent(),
                Value<DateTime> nextPaymentDate = const Value.absent(),
                Value<BigInt> foreignId = const Value.absent(),
              }) => SubscriptionsTableCompanion(
                primaryId: primaryId,
                amount: amount,
                expensesFrequency: expensesFrequency,
                nextPaymentDate: nextPaymentDate,
                foreignId: foreignId,
              ),
          createCompanionCallback:
              ({
                Value<BigInt> primaryId = const Value.absent(),
                required double amount,
                required MaxiPocketExpensesFrequency expensesFrequency,
                Value<DateTime> nextPaymentDate = const Value.absent(),
                required BigInt foreignId,
              }) => SubscriptionsTableCompanion.insert(
                primaryId: primaryId,
                amount: amount,
                expensesFrequency: expensesFrequency,
                nextPaymentDate: nextPaymentDate,
                foreignId: foreignId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SubscriptionsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({foreignId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (foreignId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.foreignId,
                                referencedTable:
                                    $$SubscriptionsTableTableReferences
                                        ._foreignIdTable(db),
                                referencedColumn:
                                    $$SubscriptionsTableTableReferences
                                        ._foreignIdTable(db)
                                        .primaryId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SubscriptionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$MaxiPocketDatabase,
      $SubscriptionsTableTable,
      Subscriptions,
      $$SubscriptionsTableTableFilterComposer,
      $$SubscriptionsTableTableOrderingComposer,
      $$SubscriptionsTableTableAnnotationComposer,
      $$SubscriptionsTableTableCreateCompanionBuilder,
      $$SubscriptionsTableTableUpdateCompanionBuilder,
      (Subscriptions, $$SubscriptionsTableTableReferences),
      Subscriptions,
      PrefetchHooks Function({bool foreignId})
    >;
typedef $$AppointmentsTableTableCreateCompanionBuilder =
    AppointmentsTableCompanion Function({
      Value<BigInt> primaryId,
      required String location,
      required BigInt foreignId,
    });
typedef $$AppointmentsTableTableUpdateCompanionBuilder =
    AppointmentsTableCompanion Function({
      Value<BigInt> primaryId,
      Value<String> location,
      Value<BigInt> foreignId,
    });

final class $$AppointmentsTableTableReferences
    extends
        BaseReferences<
          _$MaxiPocketDatabase,
          $AppointmentsTableTable,
          Appointment
        > {
  $$AppointmentsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CommonDataTableTable _foreignIdTable(_$MaxiPocketDatabase db) =>
      db.commonDataTable.createAlias(
        $_aliasNameGenerator(
          db.appointmentsTable.foreignId,
          db.commonDataTable.primaryId,
        ),
      );

  $$CommonDataTableTableProcessedTableManager get foreignId {
    final $_column = $_itemColumn<BigInt>('foreign_id')!;

    final manager = $$CommonDataTableTableTableManager(
      $_db,
      $_db.commonDataTable,
    ).filter((f) => f.primaryId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_foreignIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AppointmentsTableTableFilterComposer
    extends Composer<_$MaxiPocketDatabase, $AppointmentsTableTable> {
  $$AppointmentsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get primaryId => $composableBuilder(
    column: $table.primaryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  $$CommonDataTableTableFilterComposer get foreignId {
    final $$CommonDataTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foreignId,
      referencedTable: $db.commonDataTable,
      getReferencedColumn: (t) => t.primaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommonDataTableTableFilterComposer(
            $db: $db,
            $table: $db.commonDataTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppointmentsTableTableOrderingComposer
    extends Composer<_$MaxiPocketDatabase, $AppointmentsTableTable> {
  $$AppointmentsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get primaryId => $composableBuilder(
    column: $table.primaryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  $$CommonDataTableTableOrderingComposer get foreignId {
    final $$CommonDataTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foreignId,
      referencedTable: $db.commonDataTable,
      getReferencedColumn: (t) => t.primaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommonDataTableTableOrderingComposer(
            $db: $db,
            $table: $db.commonDataTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppointmentsTableTableAnnotationComposer
    extends Composer<_$MaxiPocketDatabase, $AppointmentsTableTable> {
  $$AppointmentsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get primaryId =>
      $composableBuilder(column: $table.primaryId, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  $$CommonDataTableTableAnnotationComposer get foreignId {
    final $$CommonDataTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.foreignId,
      referencedTable: $db.commonDataTable,
      getReferencedColumn: (t) => t.primaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CommonDataTableTableAnnotationComposer(
            $db: $db,
            $table: $db.commonDataTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppointmentsTableTableTableManager
    extends
        RootTableManager<
          _$MaxiPocketDatabase,
          $AppointmentsTableTable,
          Appointment,
          $$AppointmentsTableTableFilterComposer,
          $$AppointmentsTableTableOrderingComposer,
          $$AppointmentsTableTableAnnotationComposer,
          $$AppointmentsTableTableCreateCompanionBuilder,
          $$AppointmentsTableTableUpdateCompanionBuilder,
          (Appointment, $$AppointmentsTableTableReferences),
          Appointment,
          PrefetchHooks Function({bool foreignId})
        > {
  $$AppointmentsTableTableTableManager(
    _$MaxiPocketDatabase db,
    $AppointmentsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppointmentsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppointmentsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppointmentsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<BigInt> primaryId = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<BigInt> foreignId = const Value.absent(),
              }) => AppointmentsTableCompanion(
                primaryId: primaryId,
                location: location,
                foreignId: foreignId,
              ),
          createCompanionCallback:
              ({
                Value<BigInt> primaryId = const Value.absent(),
                required String location,
                required BigInt foreignId,
              }) => AppointmentsTableCompanion.insert(
                primaryId: primaryId,
                location: location,
                foreignId: foreignId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AppointmentsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({foreignId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (foreignId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.foreignId,
                                referencedTable:
                                    $$AppointmentsTableTableReferences
                                        ._foreignIdTable(db),
                                referencedColumn:
                                    $$AppointmentsTableTableReferences
                                        ._foreignIdTable(db)
                                        .primaryId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AppointmentsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$MaxiPocketDatabase,
      $AppointmentsTableTable,
      Appointment,
      $$AppointmentsTableTableFilterComposer,
      $$AppointmentsTableTableOrderingComposer,
      $$AppointmentsTableTableAnnotationComposer,
      $$AppointmentsTableTableCreateCompanionBuilder,
      $$AppointmentsTableTableUpdateCompanionBuilder,
      (Appointment, $$AppointmentsTableTableReferences),
      Appointment,
      PrefetchHooks Function({bool foreignId})
    >;

class $MaxiPocketDatabaseManager {
  final _$MaxiPocketDatabase _db;
  $MaxiPocketDatabaseManager(this._db);
  $$CommonDataTableTableTableManager get commonDataTable =>
      $$CommonDataTableTableTableManager(_db, _db.commonDataTable);
  $$FinancingTableTableTableManager get financingTable =>
      $$FinancingTableTableTableManager(_db, _db.financingTable);
  $$SubscriptionsTableTableTableManager get subscriptionsTable =>
      $$SubscriptionsTableTableTableManager(_db, _db.subscriptionsTable);
  $$AppointmentsTableTableTableManager get appointmentsTable =>
      $$AppointmentsTableTableTableManager(_db, _db.appointmentsTable);
}
