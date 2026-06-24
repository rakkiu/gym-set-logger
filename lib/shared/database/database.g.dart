// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, Exercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
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
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameViMeta = const VerificationMeta('nameVi');
  @override
  late final GeneratedColumn<String> nameVi = GeneratedColumn<String>(
    'name_vi',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _muscleGroupMeta = const VerificationMeta(
    'muscleGroup',
  );
  @override
  late final GeneratedColumn<String> muscleGroup = GeneratedColumn<String>(
    'muscle_group',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultRestSecondsMeta =
      const VerificationMeta('defaultRestSeconds');
  @override
  late final GeneratedColumn<int> defaultRestSeconds = GeneratedColumn<int>(
    'default_rest_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(90),
  );
  static const VerificationMeta _isCustomMeta = const VerificationMeta(
    'isCustom',
  );
  @override
  late final GeneratedColumn<int> isCustom = GeneratedColumn<int>(
    'is_custom',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    nameVi,
    muscleGroup,
    type,
    defaultRestSeconds,
    isCustom,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<Exercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_vi')) {
      context.handle(
        _nameViMeta,
        nameVi.isAcceptableOrUnknown(data['name_vi']!, _nameViMeta),
      );
    }
    if (data.containsKey('muscle_group')) {
      context.handle(
        _muscleGroupMeta,
        muscleGroup.isAcceptableOrUnknown(
          data['muscle_group']!,
          _muscleGroupMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_muscleGroupMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('default_rest_seconds')) {
      context.handle(
        _defaultRestSecondsMeta,
        defaultRestSeconds.isAcceptableOrUnknown(
          data['default_rest_seconds']!,
          _defaultRestSecondsMeta,
        ),
      );
    }
    if (data.containsKey('is_custom')) {
      context.handle(
        _isCustomMeta,
        isCustom.isAcceptableOrUnknown(data['is_custom']!, _isCustomMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exercise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nameVi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_vi'],
      )!,
      muscleGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_group'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      defaultRestSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_rest_seconds'],
      )!,
      isCustom: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_custom'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class Exercise extends DataClass implements Insertable<Exercise> {
  final int id;
  final String name;
  final String nameVi;
  final String muscleGroup;
  final String type;
  final int defaultRestSeconds;
  final int isCustom;
  final DateTime createdAt;
  const Exercise({
    required this.id,
    required this.name,
    required this.nameVi,
    required this.muscleGroup,
    required this.type,
    required this.defaultRestSeconds,
    required this.isCustom,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['name_vi'] = Variable<String>(nameVi);
    map['muscle_group'] = Variable<String>(muscleGroup);
    map['type'] = Variable<String>(type);
    map['default_rest_seconds'] = Variable<int>(defaultRestSeconds);
    map['is_custom'] = Variable<int>(isCustom);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      name: Value(name),
      nameVi: Value(nameVi),
      muscleGroup: Value(muscleGroup),
      type: Value(type),
      defaultRestSeconds: Value(defaultRestSeconds),
      isCustom: Value(isCustom),
      createdAt: Value(createdAt),
    );
  }

  factory Exercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exercise(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameVi: serializer.fromJson<String>(json['nameVi']),
      muscleGroup: serializer.fromJson<String>(json['muscleGroup']),
      type: serializer.fromJson<String>(json['type']),
      defaultRestSeconds: serializer.fromJson<int>(json['defaultRestSeconds']),
      isCustom: serializer.fromJson<int>(json['isCustom']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'nameVi': serializer.toJson<String>(nameVi),
      'muscleGroup': serializer.toJson<String>(muscleGroup),
      'type': serializer.toJson<String>(type),
      'defaultRestSeconds': serializer.toJson<int>(defaultRestSeconds),
      'isCustom': serializer.toJson<int>(isCustom),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Exercise copyWith({
    int? id,
    String? name,
    String? nameVi,
    String? muscleGroup,
    String? type,
    int? defaultRestSeconds,
    int? isCustom,
    DateTime? createdAt,
  }) => Exercise(
    id: id ?? this.id,
    name: name ?? this.name,
    nameVi: nameVi ?? this.nameVi,
    muscleGroup: muscleGroup ?? this.muscleGroup,
    type: type ?? this.type,
    defaultRestSeconds: defaultRestSeconds ?? this.defaultRestSeconds,
    isCustom: isCustom ?? this.isCustom,
    createdAt: createdAt ?? this.createdAt,
  );
  Exercise copyWithCompanion(ExercisesCompanion data) {
    return Exercise(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nameVi: data.nameVi.present ? data.nameVi.value : this.nameVi,
      muscleGroup: data.muscleGroup.present
          ? data.muscleGroup.value
          : this.muscleGroup,
      type: data.type.present ? data.type.value : this.type,
      defaultRestSeconds: data.defaultRestSeconds.present
          ? data.defaultRestSeconds.value
          : this.defaultRestSeconds,
      isCustom: data.isCustom.present ? data.isCustom.value : this.isCustom,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exercise(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameVi: $nameVi, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('type: $type, ')
          ..write('defaultRestSeconds: $defaultRestSeconds, ')
          ..write('isCustom: $isCustom, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    nameVi,
    muscleGroup,
    type,
    defaultRestSeconds,
    isCustom,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exercise &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameVi == this.nameVi &&
          other.muscleGroup == this.muscleGroup &&
          other.type == this.type &&
          other.defaultRestSeconds == this.defaultRestSeconds &&
          other.isCustom == this.isCustom &&
          other.createdAt == this.createdAt);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> nameVi;
  final Value<String> muscleGroup;
  final Value<String> type;
  final Value<int> defaultRestSeconds;
  final Value<int> isCustom;
  final Value<DateTime> createdAt;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameVi = const Value.absent(),
    this.muscleGroup = const Value.absent(),
    this.type = const Value.absent(),
    this.defaultRestSeconds = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ExercisesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.nameVi = const Value.absent(),
    required String muscleGroup,
    required String type,
    this.defaultRestSeconds = const Value.absent(),
    this.isCustom = const Value.absent(),
    required DateTime createdAt,
  }) : name = Value(name),
       muscleGroup = Value(muscleGroup),
       type = Value(type),
       createdAt = Value(createdAt);
  static Insertable<Exercise> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? nameVi,
    Expression<String>? muscleGroup,
    Expression<String>? type,
    Expression<int>? defaultRestSeconds,
    Expression<int>? isCustom,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameVi != null) 'name_vi': nameVi,
      if (muscleGroup != null) 'muscle_group': muscleGroup,
      if (type != null) 'type': type,
      if (defaultRestSeconds != null)
        'default_rest_seconds': defaultRestSeconds,
      if (isCustom != null) 'is_custom': isCustom,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ExercisesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? nameVi,
    Value<String>? muscleGroup,
    Value<String>? type,
    Value<int>? defaultRestSeconds,
    Value<int>? isCustom,
    Value<DateTime>? createdAt,
  }) {
    return ExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameVi: nameVi ?? this.nameVi,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      type: type ?? this.type,
      defaultRestSeconds: defaultRestSeconds ?? this.defaultRestSeconds,
      isCustom: isCustom ?? this.isCustom,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameVi.present) {
      map['name_vi'] = Variable<String>(nameVi.value);
    }
    if (muscleGroup.present) {
      map['muscle_group'] = Variable<String>(muscleGroup.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (defaultRestSeconds.present) {
      map['default_rest_seconds'] = Variable<int>(defaultRestSeconds.value);
    }
    if (isCustom.present) {
      map['is_custom'] = Variable<int>(isCustom.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameVi: $nameVi, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('type: $type, ')
          ..write('defaultRestSeconds: $defaultRestSeconds, ')
          ..write('isCustom: $isCustom, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSessionsTable extends WorkoutSessions
    with TableInfo<$WorkoutSessionsTable, WorkoutSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyWeightKgMeta = const VerificationMeta(
    'bodyWeightKg',
  );
  @override
  late final GeneratedColumn<double> bodyWeightKg = GeneratedColumn<double>(
    'body_weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startedAt,
    endedAt,
    notes,
    bodyWeightKg,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('body_weight_kg')) {
      context.handle(
        _bodyWeightKgMeta,
        bodyWeightKg.isAcceptableOrUnknown(
          data['body_weight_kg']!,
          _bodyWeightKgMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      bodyWeightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}body_weight_kg'],
      ),
    );
  }

  @override
  $WorkoutSessionsTable createAlias(String alias) {
    return $WorkoutSessionsTable(attachedDatabase, alias);
  }
}

class WorkoutSession extends DataClass implements Insertable<WorkoutSession> {
  final int id;
  final DateTime startedAt;
  final DateTime? endedAt;
  final String? notes;
  final double? bodyWeightKg;
  const WorkoutSession({
    required this.id,
    required this.startedAt,
    this.endedAt,
    this.notes,
    this.bodyWeightKg,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || bodyWeightKg != null) {
      map['body_weight_kg'] = Variable<double>(bodyWeightKg);
    }
    return map;
  }

  WorkoutSessionsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSessionsCompanion(
      id: Value(id),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      bodyWeightKg: bodyWeightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyWeightKg),
    );
  }

  factory WorkoutSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSession(
      id: serializer.fromJson<int>(json['id']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      bodyWeightKg: serializer.fromJson<double?>(json['bodyWeightKg']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'notes': serializer.toJson<String?>(notes),
      'bodyWeightKg': serializer.toJson<double?>(bodyWeightKg),
    };
  }

  WorkoutSession copyWith({
    int? id,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<double?> bodyWeightKg = const Value.absent(),
  }) => WorkoutSession(
    id: id ?? this.id,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    notes: notes.present ? notes.value : this.notes,
    bodyWeightKg: bodyWeightKg.present ? bodyWeightKg.value : this.bodyWeightKg,
  );
  WorkoutSession copyWithCompanion(WorkoutSessionsCompanion data) {
    return WorkoutSession(
      id: data.id.present ? data.id.value : this.id,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
      bodyWeightKg: data.bodyWeightKg.present
          ? data.bodyWeightKg.value
          : this.bodyWeightKg,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSession(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('notes: $notes, ')
          ..write('bodyWeightKg: $bodyWeightKg')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, startedAt, endedAt, notes, bodyWeightKg);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSession &&
          other.id == this.id &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.notes == this.notes &&
          other.bodyWeightKg == this.bodyWeightKg);
}

class WorkoutSessionsCompanion extends UpdateCompanion<WorkoutSession> {
  final Value<int> id;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<String?> notes;
  final Value<double?> bodyWeightKg;
  const WorkoutSessionsCompanion({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.bodyWeightKg = const Value.absent(),
  });
  WorkoutSessionsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.bodyWeightKg = const Value.absent(),
  }) : startedAt = Value(startedAt);
  static Insertable<WorkoutSession> custom({
    Expression<int>? id,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<String>? notes,
    Expression<double>? bodyWeightKg,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (notes != null) 'notes': notes,
      if (bodyWeightKg != null) 'body_weight_kg': bodyWeightKg,
    });
  }

  WorkoutSessionsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<String?>? notes,
    Value<double?>? bodyWeightKg,
  }) {
    return WorkoutSessionsCompanion(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      notes: notes ?? this.notes,
      bodyWeightKg: bodyWeightKg ?? this.bodyWeightKg,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (bodyWeightKg.present) {
      map['body_weight_kg'] = Variable<double>(bodyWeightKg.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionsCompanion(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('notes: $notes, ')
          ..write('bodyWeightKg: $bodyWeightKg')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSetsTable extends WorkoutSets
    with TableInfo<$WorkoutSetsTable, WorkoutSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workout_sessions (id)',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _setNumberMeta = const VerificationMeta(
    'setNumber',
  );
  @override
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
    'set_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _restSecondsMeta = const VerificationMeta(
    'restSeconds',
  );
  @override
  late final GeneratedColumn<int> restSeconds = GeneratedColumn<int>(
    'rest_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _suggestedRestSecondsMeta =
      const VerificationMeta('suggestedRestSeconds');
  @override
  late final GeneratedColumn<int> suggestedRestSeconds = GeneratedColumn<int>(
    'suggested_rest_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPrMeta = const VerificationMeta('isPr');
  @override
  late final GeneratedColumn<int> isPr = GeneratedColumn<int>(
    'is_pr',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    exerciseId,
    setNumber,
    weightKg,
    reps,
    restSeconds,
    suggestedRestSeconds,
    isPr,
    loggedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sets';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutSet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('set_number')) {
      context.handle(
        _setNumberMeta,
        setNumber.isAcceptableOrUnknown(data['set_number']!, _setNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_setNumberMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('rest_seconds')) {
      context.handle(
        _restSecondsMeta,
        restSeconds.isAcceptableOrUnknown(
          data['rest_seconds']!,
          _restSecondsMeta,
        ),
      );
    }
    if (data.containsKey('suggested_rest_seconds')) {
      context.handle(
        _suggestedRestSecondsMeta,
        suggestedRestSeconds.isAcceptableOrUnknown(
          data['suggested_rest_seconds']!,
          _suggestedRestSecondsMeta,
        ),
      );
    }
    if (data.containsKey('is_pr')) {
      context.handle(
        _isPrMeta,
        isPr.isAcceptableOrUnknown(data['is_pr']!, _isPrMeta),
      );
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSet(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      setNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}set_number'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      restSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rest_seconds'],
      ),
      suggestedRestSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}suggested_rest_seconds'],
      ),
      isPr: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_pr'],
      )!,
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
    );
  }

  @override
  $WorkoutSetsTable createAlias(String alias) {
    return $WorkoutSetsTable(attachedDatabase, alias);
  }
}

class WorkoutSet extends DataClass implements Insertable<WorkoutSet> {
  final int id;
  final int sessionId;
  final int exerciseId;
  final int setNumber;
  final double weightKg;
  final int reps;
  final int? restSeconds;
  final int? suggestedRestSeconds;
  final int isPr;
  final DateTime loggedAt;
  const WorkoutSet({
    required this.id,
    required this.sessionId,
    required this.exerciseId,
    required this.setNumber,
    required this.weightKg,
    required this.reps,
    this.restSeconds,
    this.suggestedRestSeconds,
    required this.isPr,
    required this.loggedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['set_number'] = Variable<int>(setNumber);
    map['weight_kg'] = Variable<double>(weightKg);
    map['reps'] = Variable<int>(reps);
    if (!nullToAbsent || restSeconds != null) {
      map['rest_seconds'] = Variable<int>(restSeconds);
    }
    if (!nullToAbsent || suggestedRestSeconds != null) {
      map['suggested_rest_seconds'] = Variable<int>(suggestedRestSeconds);
    }
    map['is_pr'] = Variable<int>(isPr);
    map['logged_at'] = Variable<DateTime>(loggedAt);
    return map;
  }

  WorkoutSetsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSetsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      exerciseId: Value(exerciseId),
      setNumber: Value(setNumber),
      weightKg: Value(weightKg),
      reps: Value(reps),
      restSeconds: restSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(restSeconds),
      suggestedRestSeconds: suggestedRestSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(suggestedRestSeconds),
      isPr: Value(isPr),
      loggedAt: Value(loggedAt),
    );
  }

  factory WorkoutSet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSet(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      setNumber: serializer.fromJson<int>(json['setNumber']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      reps: serializer.fromJson<int>(json['reps']),
      restSeconds: serializer.fromJson<int?>(json['restSeconds']),
      suggestedRestSeconds: serializer.fromJson<int?>(
        json['suggestedRestSeconds'],
      ),
      isPr: serializer.fromJson<int>(json['isPr']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'setNumber': serializer.toJson<int>(setNumber),
      'weightKg': serializer.toJson<double>(weightKg),
      'reps': serializer.toJson<int>(reps),
      'restSeconds': serializer.toJson<int?>(restSeconds),
      'suggestedRestSeconds': serializer.toJson<int?>(suggestedRestSeconds),
      'isPr': serializer.toJson<int>(isPr),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
    };
  }

  WorkoutSet copyWith({
    int? id,
    int? sessionId,
    int? exerciseId,
    int? setNumber,
    double? weightKg,
    int? reps,
    Value<int?> restSeconds = const Value.absent(),
    Value<int?> suggestedRestSeconds = const Value.absent(),
    int? isPr,
    DateTime? loggedAt,
  }) => WorkoutSet(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    exerciseId: exerciseId ?? this.exerciseId,
    setNumber: setNumber ?? this.setNumber,
    weightKg: weightKg ?? this.weightKg,
    reps: reps ?? this.reps,
    restSeconds: restSeconds.present ? restSeconds.value : this.restSeconds,
    suggestedRestSeconds: suggestedRestSeconds.present
        ? suggestedRestSeconds.value
        : this.suggestedRestSeconds,
    isPr: isPr ?? this.isPr,
    loggedAt: loggedAt ?? this.loggedAt,
  );
  WorkoutSet copyWithCompanion(WorkoutSetsCompanion data) {
    return WorkoutSet(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      setNumber: data.setNumber.present ? data.setNumber.value : this.setNumber,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      reps: data.reps.present ? data.reps.value : this.reps,
      restSeconds: data.restSeconds.present
          ? data.restSeconds.value
          : this.restSeconds,
      suggestedRestSeconds: data.suggestedRestSeconds.present
          ? data.suggestedRestSeconds.value
          : this.suggestedRestSeconds,
      isPr: data.isPr.present ? data.isPr.value : this.isPr,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSet(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('setNumber: $setNumber, ')
          ..write('weightKg: $weightKg, ')
          ..write('reps: $reps, ')
          ..write('restSeconds: $restSeconds, ')
          ..write('suggestedRestSeconds: $suggestedRestSeconds, ')
          ..write('isPr: $isPr, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    exerciseId,
    setNumber,
    weightKg,
    reps,
    restSeconds,
    suggestedRestSeconds,
    isPr,
    loggedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSet &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.exerciseId == this.exerciseId &&
          other.setNumber == this.setNumber &&
          other.weightKg == this.weightKg &&
          other.reps == this.reps &&
          other.restSeconds == this.restSeconds &&
          other.suggestedRestSeconds == this.suggestedRestSeconds &&
          other.isPr == this.isPr &&
          other.loggedAt == this.loggedAt);
}

class WorkoutSetsCompanion extends UpdateCompanion<WorkoutSet> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<int> exerciseId;
  final Value<int> setNumber;
  final Value<double> weightKg;
  final Value<int> reps;
  final Value<int?> restSeconds;
  final Value<int?> suggestedRestSeconds;
  final Value<int> isPr;
  final Value<DateTime> loggedAt;
  const WorkoutSetsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.reps = const Value.absent(),
    this.restSeconds = const Value.absent(),
    this.suggestedRestSeconds = const Value.absent(),
    this.isPr = const Value.absent(),
    this.loggedAt = const Value.absent(),
  });
  WorkoutSetsCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required int exerciseId,
    required int setNumber,
    required double weightKg,
    required int reps,
    this.restSeconds = const Value.absent(),
    this.suggestedRestSeconds = const Value.absent(),
    this.isPr = const Value.absent(),
    required DateTime loggedAt,
  }) : sessionId = Value(sessionId),
       exerciseId = Value(exerciseId),
       setNumber = Value(setNumber),
       weightKg = Value(weightKg),
       reps = Value(reps),
       loggedAt = Value(loggedAt);
  static Insertable<WorkoutSet> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<int>? exerciseId,
    Expression<int>? setNumber,
    Expression<double>? weightKg,
    Expression<int>? reps,
    Expression<int>? restSeconds,
    Expression<int>? suggestedRestSeconds,
    Expression<int>? isPr,
    Expression<DateTime>? loggedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (setNumber != null) 'set_number': setNumber,
      if (weightKg != null) 'weight_kg': weightKg,
      if (reps != null) 'reps': reps,
      if (restSeconds != null) 'rest_seconds': restSeconds,
      if (suggestedRestSeconds != null)
        'suggested_rest_seconds': suggestedRestSeconds,
      if (isPr != null) 'is_pr': isPr,
      if (loggedAt != null) 'logged_at': loggedAt,
    });
  }

  WorkoutSetsCompanion copyWith({
    Value<int>? id,
    Value<int>? sessionId,
    Value<int>? exerciseId,
    Value<int>? setNumber,
    Value<double>? weightKg,
    Value<int>? reps,
    Value<int?>? restSeconds,
    Value<int?>? suggestedRestSeconds,
    Value<int>? isPr,
    Value<DateTime>? loggedAt,
  }) {
    return WorkoutSetsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      exerciseId: exerciseId ?? this.exerciseId,
      setNumber: setNumber ?? this.setNumber,
      weightKg: weightKg ?? this.weightKg,
      reps: reps ?? this.reps,
      restSeconds: restSeconds ?? this.restSeconds,
      suggestedRestSeconds: suggestedRestSeconds ?? this.suggestedRestSeconds,
      isPr: isPr ?? this.isPr,
      loggedAt: loggedAt ?? this.loggedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (setNumber.present) {
      map['set_number'] = Variable<int>(setNumber.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (restSeconds.present) {
      map['rest_seconds'] = Variable<int>(restSeconds.value);
    }
    if (suggestedRestSeconds.present) {
      map['suggested_rest_seconds'] = Variable<int>(suggestedRestSeconds.value);
    }
    if (isPr.present) {
      map['is_pr'] = Variable<int>(isPr.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSetsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('setNumber: $setNumber, ')
          ..write('weightKg: $weightKg, ')
          ..write('reps: $reps, ')
          ..write('restSeconds: $restSeconds, ')
          ..write('suggestedRestSeconds: $suggestedRestSeconds, ')
          ..write('isPr: $isPr, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }
}

class $BodyWeightLogsTable extends BodyWeightLogs
    with TableInfo<$BodyWeightLogsTable, BodyWeightLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BodyWeightLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, weightKg, note, loggedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'body_weight_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<BodyWeightLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BodyWeightLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BodyWeightLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
    );
  }

  @override
  $BodyWeightLogsTable createAlias(String alias) {
    return $BodyWeightLogsTable(attachedDatabase, alias);
  }
}

class BodyWeightLog extends DataClass implements Insertable<BodyWeightLog> {
  final int id;
  final String date;
  final double weightKg;
  final String? note;
  final DateTime loggedAt;
  const BodyWeightLog({
    required this.id,
    required this.date,
    required this.weightKg,
    this.note,
    required this.loggedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['weight_kg'] = Variable<double>(weightKg);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['logged_at'] = Variable<DateTime>(loggedAt);
    return map;
  }

  BodyWeightLogsCompanion toCompanion(bool nullToAbsent) {
    return BodyWeightLogsCompanion(
      id: Value(id),
      date: Value(date),
      weightKg: Value(weightKg),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      loggedAt: Value(loggedAt),
    );
  }

  factory BodyWeightLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BodyWeightLog(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      note: serializer.fromJson<String?>(json['note']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'weightKg': serializer.toJson<double>(weightKg),
      'note': serializer.toJson<String?>(note),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
    };
  }

  BodyWeightLog copyWith({
    int? id,
    String? date,
    double? weightKg,
    Value<String?> note = const Value.absent(),
    DateTime? loggedAt,
  }) => BodyWeightLog(
    id: id ?? this.id,
    date: date ?? this.date,
    weightKg: weightKg ?? this.weightKg,
    note: note.present ? note.value : this.note,
    loggedAt: loggedAt ?? this.loggedAt,
  );
  BodyWeightLog copyWithCompanion(BodyWeightLogsCompanion data) {
    return BodyWeightLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      note: data.note.present ? data.note.value : this.note,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BodyWeightLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weightKg: $weightKg, ')
          ..write('note: $note, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, weightKg, note, loggedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BodyWeightLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.weightKg == this.weightKg &&
          other.note == this.note &&
          other.loggedAt == this.loggedAt);
}

class BodyWeightLogsCompanion extends UpdateCompanion<BodyWeightLog> {
  final Value<int> id;
  final Value<String> date;
  final Value<double> weightKg;
  final Value<String?> note;
  final Value<DateTime> loggedAt;
  const BodyWeightLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.note = const Value.absent(),
    this.loggedAt = const Value.absent(),
  });
  BodyWeightLogsCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required double weightKg,
    this.note = const Value.absent(),
    required DateTime loggedAt,
  }) : date = Value(date),
       weightKg = Value(weightKg),
       loggedAt = Value(loggedAt);
  static Insertable<BodyWeightLog> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<double>? weightKg,
    Expression<String>? note,
    Expression<DateTime>? loggedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (weightKg != null) 'weight_kg': weightKg,
      if (note != null) 'note': note,
      if (loggedAt != null) 'logged_at': loggedAt,
    });
  }

  BodyWeightLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? date,
    Value<double>? weightKg,
    Value<String?>? note,
    Value<DateTime>? loggedAt,
  }) {
    return BodyWeightLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      weightKg: weightKg ?? this.weightKg,
      note: note ?? this.note,
      loggedAt: loggedAt ?? this.loggedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BodyWeightLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weightKg: $weightKg, ')
          ..write('note: $note, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }
}

class $PersonalRecordsTable extends PersonalRecords
    with TableInfo<$PersonalRecordsTable, PersonalRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonalRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _bestWeightKgMeta = const VerificationMeta(
    'bestWeightKg',
  );
  @override
  late final GeneratedColumn<double> bestWeightKg = GeneratedColumn<double>(
    'best_weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bestRepsAtWeightMeta = const VerificationMeta(
    'bestRepsAtWeight',
  );
  @override
  late final GeneratedColumn<int> bestRepsAtWeight = GeneratedColumn<int>(
    'best_reps_at_weight',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bestEstimated1rmMeta = const VerificationMeta(
    'bestEstimated1rm',
  );
  @override
  late final GeneratedColumn<double> bestEstimated1rm = GeneratedColumn<double>(
    'best_estimated1rm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bestVolumeSingleSetMeta =
      const VerificationMeta('bestVolumeSingleSet');
  @override
  late final GeneratedColumn<double> bestVolumeSingleSet =
      GeneratedColumn<double>(
        'best_volume_single_set',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _achievedAtMeta = const VerificationMeta(
    'achievedAt',
  );
  @override
  late final GeneratedColumn<DateTime> achievedAt = GeneratedColumn<DateTime>(
    'achieved_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    exerciseId,
    bestWeightKg,
    bestRepsAtWeight,
    bestEstimated1rm,
    bestVolumeSingleSet,
    achievedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'personal_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<PersonalRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    }
    if (data.containsKey('best_weight_kg')) {
      context.handle(
        _bestWeightKgMeta,
        bestWeightKg.isAcceptableOrUnknown(
          data['best_weight_kg']!,
          _bestWeightKgMeta,
        ),
      );
    }
    if (data.containsKey('best_reps_at_weight')) {
      context.handle(
        _bestRepsAtWeightMeta,
        bestRepsAtWeight.isAcceptableOrUnknown(
          data['best_reps_at_weight']!,
          _bestRepsAtWeightMeta,
        ),
      );
    }
    if (data.containsKey('best_estimated1rm')) {
      context.handle(
        _bestEstimated1rmMeta,
        bestEstimated1rm.isAcceptableOrUnknown(
          data['best_estimated1rm']!,
          _bestEstimated1rmMeta,
        ),
      );
    }
    if (data.containsKey('best_volume_single_set')) {
      context.handle(
        _bestVolumeSingleSetMeta,
        bestVolumeSingleSet.isAcceptableOrUnknown(
          data['best_volume_single_set']!,
          _bestVolumeSingleSetMeta,
        ),
      );
    }
    if (data.containsKey('achieved_at')) {
      context.handle(
        _achievedAtMeta,
        achievedAt.isAcceptableOrUnknown(data['achieved_at']!, _achievedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {exerciseId};
  @override
  PersonalRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonalRecord(
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      bestWeightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}best_weight_kg'],
      ),
      bestRepsAtWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}best_reps_at_weight'],
      ),
      bestEstimated1rm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}best_estimated1rm'],
      ),
      bestVolumeSingleSet: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}best_volume_single_set'],
      ),
      achievedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}achieved_at'],
      ),
    );
  }

  @override
  $PersonalRecordsTable createAlias(String alias) {
    return $PersonalRecordsTable(attachedDatabase, alias);
  }
}

class PersonalRecord extends DataClass implements Insertable<PersonalRecord> {
  final int exerciseId;
  final double? bestWeightKg;
  final int? bestRepsAtWeight;
  final double? bestEstimated1rm;
  final double? bestVolumeSingleSet;
  final DateTime? achievedAt;
  const PersonalRecord({
    required this.exerciseId,
    this.bestWeightKg,
    this.bestRepsAtWeight,
    this.bestEstimated1rm,
    this.bestVolumeSingleSet,
    this.achievedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['exercise_id'] = Variable<int>(exerciseId);
    if (!nullToAbsent || bestWeightKg != null) {
      map['best_weight_kg'] = Variable<double>(bestWeightKg);
    }
    if (!nullToAbsent || bestRepsAtWeight != null) {
      map['best_reps_at_weight'] = Variable<int>(bestRepsAtWeight);
    }
    if (!nullToAbsent || bestEstimated1rm != null) {
      map['best_estimated1rm'] = Variable<double>(bestEstimated1rm);
    }
    if (!nullToAbsent || bestVolumeSingleSet != null) {
      map['best_volume_single_set'] = Variable<double>(bestVolumeSingleSet);
    }
    if (!nullToAbsent || achievedAt != null) {
      map['achieved_at'] = Variable<DateTime>(achievedAt);
    }
    return map;
  }

  PersonalRecordsCompanion toCompanion(bool nullToAbsent) {
    return PersonalRecordsCompanion(
      exerciseId: Value(exerciseId),
      bestWeightKg: bestWeightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(bestWeightKg),
      bestRepsAtWeight: bestRepsAtWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(bestRepsAtWeight),
      bestEstimated1rm: bestEstimated1rm == null && nullToAbsent
          ? const Value.absent()
          : Value(bestEstimated1rm),
      bestVolumeSingleSet: bestVolumeSingleSet == null && nullToAbsent
          ? const Value.absent()
          : Value(bestVolumeSingleSet),
      achievedAt: achievedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(achievedAt),
    );
  }

  factory PersonalRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonalRecord(
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      bestWeightKg: serializer.fromJson<double?>(json['bestWeightKg']),
      bestRepsAtWeight: serializer.fromJson<int?>(json['bestRepsAtWeight']),
      bestEstimated1rm: serializer.fromJson<double?>(json['bestEstimated1rm']),
      bestVolumeSingleSet: serializer.fromJson<double?>(
        json['bestVolumeSingleSet'],
      ),
      achievedAt: serializer.fromJson<DateTime?>(json['achievedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'exerciseId': serializer.toJson<int>(exerciseId),
      'bestWeightKg': serializer.toJson<double?>(bestWeightKg),
      'bestRepsAtWeight': serializer.toJson<int?>(bestRepsAtWeight),
      'bestEstimated1rm': serializer.toJson<double?>(bestEstimated1rm),
      'bestVolumeSingleSet': serializer.toJson<double?>(bestVolumeSingleSet),
      'achievedAt': serializer.toJson<DateTime?>(achievedAt),
    };
  }

  PersonalRecord copyWith({
    int? exerciseId,
    Value<double?> bestWeightKg = const Value.absent(),
    Value<int?> bestRepsAtWeight = const Value.absent(),
    Value<double?> bestEstimated1rm = const Value.absent(),
    Value<double?> bestVolumeSingleSet = const Value.absent(),
    Value<DateTime?> achievedAt = const Value.absent(),
  }) => PersonalRecord(
    exerciseId: exerciseId ?? this.exerciseId,
    bestWeightKg: bestWeightKg.present ? bestWeightKg.value : this.bestWeightKg,
    bestRepsAtWeight: bestRepsAtWeight.present
        ? bestRepsAtWeight.value
        : this.bestRepsAtWeight,
    bestEstimated1rm: bestEstimated1rm.present
        ? bestEstimated1rm.value
        : this.bestEstimated1rm,
    bestVolumeSingleSet: bestVolumeSingleSet.present
        ? bestVolumeSingleSet.value
        : this.bestVolumeSingleSet,
    achievedAt: achievedAt.present ? achievedAt.value : this.achievedAt,
  );
  PersonalRecord copyWithCompanion(PersonalRecordsCompanion data) {
    return PersonalRecord(
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      bestWeightKg: data.bestWeightKg.present
          ? data.bestWeightKg.value
          : this.bestWeightKg,
      bestRepsAtWeight: data.bestRepsAtWeight.present
          ? data.bestRepsAtWeight.value
          : this.bestRepsAtWeight,
      bestEstimated1rm: data.bestEstimated1rm.present
          ? data.bestEstimated1rm.value
          : this.bestEstimated1rm,
      bestVolumeSingleSet: data.bestVolumeSingleSet.present
          ? data.bestVolumeSingleSet.value
          : this.bestVolumeSingleSet,
      achievedAt: data.achievedAt.present
          ? data.achievedAt.value
          : this.achievedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonalRecord(')
          ..write('exerciseId: $exerciseId, ')
          ..write('bestWeightKg: $bestWeightKg, ')
          ..write('bestRepsAtWeight: $bestRepsAtWeight, ')
          ..write('bestEstimated1rm: $bestEstimated1rm, ')
          ..write('bestVolumeSingleSet: $bestVolumeSingleSet, ')
          ..write('achievedAt: $achievedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    exerciseId,
    bestWeightKg,
    bestRepsAtWeight,
    bestEstimated1rm,
    bestVolumeSingleSet,
    achievedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonalRecord &&
          other.exerciseId == this.exerciseId &&
          other.bestWeightKg == this.bestWeightKg &&
          other.bestRepsAtWeight == this.bestRepsAtWeight &&
          other.bestEstimated1rm == this.bestEstimated1rm &&
          other.bestVolumeSingleSet == this.bestVolumeSingleSet &&
          other.achievedAt == this.achievedAt);
}

class PersonalRecordsCompanion extends UpdateCompanion<PersonalRecord> {
  final Value<int> exerciseId;
  final Value<double?> bestWeightKg;
  final Value<int?> bestRepsAtWeight;
  final Value<double?> bestEstimated1rm;
  final Value<double?> bestVolumeSingleSet;
  final Value<DateTime?> achievedAt;
  const PersonalRecordsCompanion({
    this.exerciseId = const Value.absent(),
    this.bestWeightKg = const Value.absent(),
    this.bestRepsAtWeight = const Value.absent(),
    this.bestEstimated1rm = const Value.absent(),
    this.bestVolumeSingleSet = const Value.absent(),
    this.achievedAt = const Value.absent(),
  });
  PersonalRecordsCompanion.insert({
    this.exerciseId = const Value.absent(),
    this.bestWeightKg = const Value.absent(),
    this.bestRepsAtWeight = const Value.absent(),
    this.bestEstimated1rm = const Value.absent(),
    this.bestVolumeSingleSet = const Value.absent(),
    this.achievedAt = const Value.absent(),
  });
  static Insertable<PersonalRecord> custom({
    Expression<int>? exerciseId,
    Expression<double>? bestWeightKg,
    Expression<int>? bestRepsAtWeight,
    Expression<double>? bestEstimated1rm,
    Expression<double>? bestVolumeSingleSet,
    Expression<DateTime>? achievedAt,
  }) {
    return RawValuesInsertable({
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (bestWeightKg != null) 'best_weight_kg': bestWeightKg,
      if (bestRepsAtWeight != null) 'best_reps_at_weight': bestRepsAtWeight,
      if (bestEstimated1rm != null) 'best_estimated1rm': bestEstimated1rm,
      if (bestVolumeSingleSet != null)
        'best_volume_single_set': bestVolumeSingleSet,
      if (achievedAt != null) 'achieved_at': achievedAt,
    });
  }

  PersonalRecordsCompanion copyWith({
    Value<int>? exerciseId,
    Value<double?>? bestWeightKg,
    Value<int?>? bestRepsAtWeight,
    Value<double?>? bestEstimated1rm,
    Value<double?>? bestVolumeSingleSet,
    Value<DateTime?>? achievedAt,
  }) {
    return PersonalRecordsCompanion(
      exerciseId: exerciseId ?? this.exerciseId,
      bestWeightKg: bestWeightKg ?? this.bestWeightKg,
      bestRepsAtWeight: bestRepsAtWeight ?? this.bestRepsAtWeight,
      bestEstimated1rm: bestEstimated1rm ?? this.bestEstimated1rm,
      bestVolumeSingleSet: bestVolumeSingleSet ?? this.bestVolumeSingleSet,
      achievedAt: achievedAt ?? this.achievedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (bestWeightKg.present) {
      map['best_weight_kg'] = Variable<double>(bestWeightKg.value);
    }
    if (bestRepsAtWeight.present) {
      map['best_reps_at_weight'] = Variable<int>(bestRepsAtWeight.value);
    }
    if (bestEstimated1rm.present) {
      map['best_estimated1rm'] = Variable<double>(bestEstimated1rm.value);
    }
    if (bestVolumeSingleSet.present) {
      map['best_volume_single_set'] = Variable<double>(
        bestVolumeSingleSet.value,
      );
    }
    if (achievedAt.present) {
      map['achieved_at'] = Variable<DateTime>(achievedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonalRecordsCompanion(')
          ..write('exerciseId: $exerciseId, ')
          ..write('bestWeightKg: $bestWeightKg, ')
          ..write('bestRepsAtWeight: $bestRepsAtWeight, ')
          ..write('bestEstimated1rm: $bestEstimated1rm, ')
          ..write('bestVolumeSingleSet: $bestVolumeSingleSet, ')
          ..write('achievedAt: $achievedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $WorkoutSessionsTable workoutSessions = $WorkoutSessionsTable(
    this,
  );
  late final $WorkoutSetsTable workoutSets = $WorkoutSetsTable(this);
  late final $BodyWeightLogsTable bodyWeightLogs = $BodyWeightLogsTable(this);
  late final $PersonalRecordsTable personalRecords = $PersonalRecordsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    exercises,
    workoutSessions,
    workoutSets,
    bodyWeightLogs,
    personalRecords,
  ];
}

typedef $$ExercisesTableCreateCompanionBuilder =
    ExercisesCompanion Function({
      Value<int> id,
      required String name,
      Value<String> nameVi,
      required String muscleGroup,
      required String type,
      Value<int> defaultRestSeconds,
      Value<int> isCustom,
      required DateTime createdAt,
    });
typedef $$ExercisesTableUpdateCompanionBuilder =
    ExercisesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> nameVi,
      Value<String> muscleGroup,
      Value<String> type,
      Value<int> defaultRestSeconds,
      Value<int> isCustom,
      Value<DateTime> createdAt,
    });

final class $$ExercisesTableReferences
    extends BaseReferences<_$AppDatabase, $ExercisesTable, Exercise> {
  $$ExercisesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WorkoutSetsTable, List<WorkoutSet>>
  _workoutSetsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workoutSets,
    aliasName: $_aliasNameGenerator(db.exercises.id, db.workoutSets.exerciseId),
  );

  $$WorkoutSetsTableProcessedTableManager get workoutSetsRefs {
    final manager = $$WorkoutSetsTableTableManager(
      $_db,
      $_db.workoutSets,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutSetsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PersonalRecordsTable, List<PersonalRecord>>
  _personalRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.personalRecords,
    aliasName: $_aliasNameGenerator(
      db.exercises.id,
      db.personalRecords.exerciseId,
    ),
  );

  $$PersonalRecordsTableProcessedTableManager get personalRecordsRefs {
    final manager = $$PersonalRecordsTableTableManager(
      $_db,
      $_db.personalRecords,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _personalRecordsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameVi => $composableBuilder(
    column: $table.nameVi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultRestSeconds => $composableBuilder(
    column: $table.defaultRestSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> workoutSetsRefs(
    Expression<bool> Function($$WorkoutSetsTableFilterComposer f) f,
  ) {
    final $$WorkoutSetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSets,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSetsTableFilterComposer(
            $db: $db,
            $table: $db.workoutSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> personalRecordsRefs(
    Expression<bool> Function($$PersonalRecordsTableFilterComposer f) f,
  ) {
    final $$PersonalRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.personalRecords,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonalRecordsTableFilterComposer(
            $db: $db,
            $table: $db.personalRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameVi => $composableBuilder(
    column: $table.nameVi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultRestSeconds => $composableBuilder(
    column: $table.defaultRestSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameVi =>
      $composableBuilder(column: $table.nameVi, builder: (column) => column);

  GeneratedColumn<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get defaultRestSeconds => $composableBuilder(
    column: $table.defaultRestSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get isCustom =>
      $composableBuilder(column: $table.isCustom, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> workoutSetsRefs<T extends Object>(
    Expression<T> Function($$WorkoutSetsTableAnnotationComposer a) f,
  ) {
    final $$WorkoutSetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSets,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSetsTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> personalRecordsRefs<T extends Object>(
    Expression<T> Function($$PersonalRecordsTableAnnotationComposer a) f,
  ) {
    final $$PersonalRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.personalRecords,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonalRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.personalRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExercisesTable,
          Exercise,
          $$ExercisesTableFilterComposer,
          $$ExercisesTableOrderingComposer,
          $$ExercisesTableAnnotationComposer,
          $$ExercisesTableCreateCompanionBuilder,
          $$ExercisesTableUpdateCompanionBuilder,
          (Exercise, $$ExercisesTableReferences),
          Exercise,
          PrefetchHooks Function({
            bool workoutSetsRefs,
            bool personalRecordsRefs,
          })
        > {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> nameVi = const Value.absent(),
                Value<String> muscleGroup = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> defaultRestSeconds = const Value.absent(),
                Value<int> isCustom = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExercisesCompanion(
                id: id,
                name: name,
                nameVi: nameVi,
                muscleGroup: muscleGroup,
                type: type,
                defaultRestSeconds: defaultRestSeconds,
                isCustom: isCustom,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> nameVi = const Value.absent(),
                required String muscleGroup,
                required String type,
                Value<int> defaultRestSeconds = const Value.absent(),
                Value<int> isCustom = const Value.absent(),
                required DateTime createdAt,
              }) => ExercisesCompanion.insert(
                id: id,
                name: name,
                nameVi: nameVi,
                muscleGroup: muscleGroup,
                type: type,
                defaultRestSeconds: defaultRestSeconds,
                isCustom: isCustom,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExercisesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({workoutSetsRefs = false, personalRecordsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (workoutSetsRefs) db.workoutSets,
                    if (personalRecordsRefs) db.personalRecords,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (workoutSetsRefs)
                        await $_getPrefetchedData<
                          Exercise,
                          $ExercisesTable,
                          WorkoutSet
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._workoutSetsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutSetsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (personalRecordsRefs)
                        await $_getPrefetchedData<
                          Exercise,
                          $ExercisesTable,
                          PersonalRecord
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._personalRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).personalRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
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

typedef $$ExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExercisesTable,
      Exercise,
      $$ExercisesTableFilterComposer,
      $$ExercisesTableOrderingComposer,
      $$ExercisesTableAnnotationComposer,
      $$ExercisesTableCreateCompanionBuilder,
      $$ExercisesTableUpdateCompanionBuilder,
      (Exercise, $$ExercisesTableReferences),
      Exercise,
      PrefetchHooks Function({bool workoutSetsRefs, bool personalRecordsRefs})
    >;
typedef $$WorkoutSessionsTableCreateCompanionBuilder =
    WorkoutSessionsCompanion Function({
      Value<int> id,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      Value<String?> notes,
      Value<double?> bodyWeightKg,
    });
typedef $$WorkoutSessionsTableUpdateCompanionBuilder =
    WorkoutSessionsCompanion Function({
      Value<int> id,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<String?> notes,
      Value<double?> bodyWeightKg,
    });

final class $$WorkoutSessionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $WorkoutSessionsTable, WorkoutSession> {
  $$WorkoutSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$WorkoutSetsTable, List<WorkoutSet>>
  _workoutSetsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workoutSets,
    aliasName: $_aliasNameGenerator(
      db.workoutSessions.id,
      db.workoutSets.sessionId,
    ),
  );

  $$WorkoutSetsTableProcessedTableManager get workoutSetsRefs {
    final manager = $$WorkoutSetsTableTableManager(
      $_db,
      $_db.workoutSets,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutSetsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WorkoutSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bodyWeightKg => $composableBuilder(
    column: $table.bodyWeightKg,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> workoutSetsRefs(
    Expression<bool> Function($$WorkoutSetsTableFilterComposer f) f,
  ) {
    final $$WorkoutSetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSets,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSetsTableFilterComposer(
            $db: $db,
            $table: $db.workoutSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkoutSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bodyWeightKg => $composableBuilder(
    column: $table.bodyWeightKg,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get bodyWeightKg => $composableBuilder(
    column: $table.bodyWeightKg,
    builder: (column) => column,
  );

  Expression<T> workoutSetsRefs<T extends Object>(
    Expression<T> Function($$WorkoutSetsTableAnnotationComposer a) f,
  ) {
    final $$WorkoutSetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSets,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSetsTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkoutSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutSessionsTable,
          WorkoutSession,
          $$WorkoutSessionsTableFilterComposer,
          $$WorkoutSessionsTableOrderingComposer,
          $$WorkoutSessionsTableAnnotationComposer,
          $$WorkoutSessionsTableCreateCompanionBuilder,
          $$WorkoutSessionsTableUpdateCompanionBuilder,
          (WorkoutSession, $$WorkoutSessionsTableReferences),
          WorkoutSession,
          PrefetchHooks Function({bool workoutSetsRefs})
        > {
  $$WorkoutSessionsTableTableManager(
    _$AppDatabase db,
    $WorkoutSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> bodyWeightKg = const Value.absent(),
              }) => WorkoutSessionsCompanion(
                id: id,
                startedAt: startedAt,
                endedAt: endedAt,
                notes: notes,
                bodyWeightKg: bodyWeightKg,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> bodyWeightKg = const Value.absent(),
              }) => WorkoutSessionsCompanion.insert(
                id: id,
                startedAt: startedAt,
                endedAt: endedAt,
                notes: notes,
                bodyWeightKg: bodyWeightKg,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkoutSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({workoutSetsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (workoutSetsRefs) db.workoutSets],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (workoutSetsRefs)
                    await $_getPrefetchedData<
                      WorkoutSession,
                      $WorkoutSessionsTable,
                      WorkoutSet
                    >(
                      currentTable: table,
                      referencedTable: $$WorkoutSessionsTableReferences
                          ._workoutSetsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$WorkoutSessionsTableReferences(
                            db,
                            table,
                            p0,
                          ).workoutSetsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.sessionId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$WorkoutSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutSessionsTable,
      WorkoutSession,
      $$WorkoutSessionsTableFilterComposer,
      $$WorkoutSessionsTableOrderingComposer,
      $$WorkoutSessionsTableAnnotationComposer,
      $$WorkoutSessionsTableCreateCompanionBuilder,
      $$WorkoutSessionsTableUpdateCompanionBuilder,
      (WorkoutSession, $$WorkoutSessionsTableReferences),
      WorkoutSession,
      PrefetchHooks Function({bool workoutSetsRefs})
    >;
typedef $$WorkoutSetsTableCreateCompanionBuilder =
    WorkoutSetsCompanion Function({
      Value<int> id,
      required int sessionId,
      required int exerciseId,
      required int setNumber,
      required double weightKg,
      required int reps,
      Value<int?> restSeconds,
      Value<int?> suggestedRestSeconds,
      Value<int> isPr,
      required DateTime loggedAt,
    });
typedef $$WorkoutSetsTableUpdateCompanionBuilder =
    WorkoutSetsCompanion Function({
      Value<int> id,
      Value<int> sessionId,
      Value<int> exerciseId,
      Value<int> setNumber,
      Value<double> weightKg,
      Value<int> reps,
      Value<int?> restSeconds,
      Value<int?> suggestedRestSeconds,
      Value<int> isPr,
      Value<DateTime> loggedAt,
    });

final class $$WorkoutSetsTableReferences
    extends BaseReferences<_$AppDatabase, $WorkoutSetsTable, WorkoutSet> {
  $$WorkoutSetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutSessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.workoutSessions.createAlias(
        $_aliasNameGenerator(db.workoutSets.sessionId, db.workoutSessions.id),
      );

  $$WorkoutSessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $$WorkoutSessionsTableTableManager(
      $_db,
      $_db.workoutSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.workoutSets.exerciseId, db.exercises.id),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WorkoutSetsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get suggestedRestSeconds => $composableBuilder(
    column: $table.suggestedRestSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isPr => $composableBuilder(
    column: $table.isPr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkoutSessionsTableFilterComposer get sessionId {
    final $$WorkoutSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableFilterComposer(
            $db: $db,
            $table: $db.workoutSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutSetsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get suggestedRestSeconds => $composableBuilder(
    column: $table.suggestedRestSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isPr => $composableBuilder(
    column: $table.isPr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkoutSessionsTableOrderingComposer get sessionId {
    final $$WorkoutSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.workoutSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutSetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get setNumber =>
      $composableBuilder(column: $table.setNumber, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get suggestedRestSeconds => $composableBuilder(
    column: $table.suggestedRestSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get isPr =>
      $composableBuilder(column: $table.isPr, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  $$WorkoutSessionsTableAnnotationComposer get sessionId {
    final $$WorkoutSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutSetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutSetsTable,
          WorkoutSet,
          $$WorkoutSetsTableFilterComposer,
          $$WorkoutSetsTableOrderingComposer,
          $$WorkoutSetsTableAnnotationComposer,
          $$WorkoutSetsTableCreateCompanionBuilder,
          $$WorkoutSetsTableUpdateCompanionBuilder,
          (WorkoutSet, $$WorkoutSetsTableReferences),
          WorkoutSet,
          PrefetchHooks Function({bool sessionId, bool exerciseId})
        > {
  $$WorkoutSetsTableTableManager(_$AppDatabase db, $WorkoutSetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sessionId = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<int> setNumber = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<int?> restSeconds = const Value.absent(),
                Value<int?> suggestedRestSeconds = const Value.absent(),
                Value<int> isPr = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
              }) => WorkoutSetsCompanion(
                id: id,
                sessionId: sessionId,
                exerciseId: exerciseId,
                setNumber: setNumber,
                weightKg: weightKg,
                reps: reps,
                restSeconds: restSeconds,
                suggestedRestSeconds: suggestedRestSeconds,
                isPr: isPr,
                loggedAt: loggedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sessionId,
                required int exerciseId,
                required int setNumber,
                required double weightKg,
                required int reps,
                Value<int?> restSeconds = const Value.absent(),
                Value<int?> suggestedRestSeconds = const Value.absent(),
                Value<int> isPr = const Value.absent(),
                required DateTime loggedAt,
              }) => WorkoutSetsCompanion.insert(
                id: id,
                sessionId: sessionId,
                exerciseId: exerciseId,
                setNumber: setNumber,
                weightKg: weightKg,
                reps: reps,
                restSeconds: restSeconds,
                suggestedRestSeconds: suggestedRestSeconds,
                isPr: isPr,
                loggedAt: loggedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkoutSetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false, exerciseId = false}) {
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
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable: $$WorkoutSetsTableReferences
                                    ._sessionIdTable(db),
                                referencedColumn: $$WorkoutSetsTableReferences
                                    ._sessionIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable: $$WorkoutSetsTableReferences
                                    ._exerciseIdTable(db),
                                referencedColumn: $$WorkoutSetsTableReferences
                                    ._exerciseIdTable(db)
                                    .id,
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

typedef $$WorkoutSetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutSetsTable,
      WorkoutSet,
      $$WorkoutSetsTableFilterComposer,
      $$WorkoutSetsTableOrderingComposer,
      $$WorkoutSetsTableAnnotationComposer,
      $$WorkoutSetsTableCreateCompanionBuilder,
      $$WorkoutSetsTableUpdateCompanionBuilder,
      (WorkoutSet, $$WorkoutSetsTableReferences),
      WorkoutSet,
      PrefetchHooks Function({bool sessionId, bool exerciseId})
    >;
typedef $$BodyWeightLogsTableCreateCompanionBuilder =
    BodyWeightLogsCompanion Function({
      Value<int> id,
      required String date,
      required double weightKg,
      Value<String?> note,
      required DateTime loggedAt,
    });
typedef $$BodyWeightLogsTableUpdateCompanionBuilder =
    BodyWeightLogsCompanion Function({
      Value<int> id,
      Value<String> date,
      Value<double> weightKg,
      Value<String?> note,
      Value<DateTime> loggedAt,
    });

class $$BodyWeightLogsTableFilterComposer
    extends Composer<_$AppDatabase, $BodyWeightLogsTable> {
  $$BodyWeightLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BodyWeightLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $BodyWeightLogsTable> {
  $$BodyWeightLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BodyWeightLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BodyWeightLogsTable> {
  $$BodyWeightLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);
}

class $$BodyWeightLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BodyWeightLogsTable,
          BodyWeightLog,
          $$BodyWeightLogsTableFilterComposer,
          $$BodyWeightLogsTableOrderingComposer,
          $$BodyWeightLogsTableAnnotationComposer,
          $$BodyWeightLogsTableCreateCompanionBuilder,
          $$BodyWeightLogsTableUpdateCompanionBuilder,
          (
            BodyWeightLog,
            BaseReferences<_$AppDatabase, $BodyWeightLogsTable, BodyWeightLog>,
          ),
          BodyWeightLog,
          PrefetchHooks Function()
        > {
  $$BodyWeightLogsTableTableManager(
    _$AppDatabase db,
    $BodyWeightLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BodyWeightLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BodyWeightLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BodyWeightLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
              }) => BodyWeightLogsCompanion(
                id: id,
                date: date,
                weightKg: weightKg,
                note: note,
                loggedAt: loggedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String date,
                required double weightKg,
                Value<String?> note = const Value.absent(),
                required DateTime loggedAt,
              }) => BodyWeightLogsCompanion.insert(
                id: id,
                date: date,
                weightKg: weightKg,
                note: note,
                loggedAt: loggedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BodyWeightLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BodyWeightLogsTable,
      BodyWeightLog,
      $$BodyWeightLogsTableFilterComposer,
      $$BodyWeightLogsTableOrderingComposer,
      $$BodyWeightLogsTableAnnotationComposer,
      $$BodyWeightLogsTableCreateCompanionBuilder,
      $$BodyWeightLogsTableUpdateCompanionBuilder,
      (
        BodyWeightLog,
        BaseReferences<_$AppDatabase, $BodyWeightLogsTable, BodyWeightLog>,
      ),
      BodyWeightLog,
      PrefetchHooks Function()
    >;
typedef $$PersonalRecordsTableCreateCompanionBuilder =
    PersonalRecordsCompanion Function({
      Value<int> exerciseId,
      Value<double?> bestWeightKg,
      Value<int?> bestRepsAtWeight,
      Value<double?> bestEstimated1rm,
      Value<double?> bestVolumeSingleSet,
      Value<DateTime?> achievedAt,
    });
typedef $$PersonalRecordsTableUpdateCompanionBuilder =
    PersonalRecordsCompanion Function({
      Value<int> exerciseId,
      Value<double?> bestWeightKg,
      Value<int?> bestRepsAtWeight,
      Value<double?> bestEstimated1rm,
      Value<double?> bestVolumeSingleSet,
      Value<DateTime?> achievedAt,
    });

final class $$PersonalRecordsTableReferences
    extends
        BaseReferences<_$AppDatabase, $PersonalRecordsTable, PersonalRecord> {
  $$PersonalRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.personalRecords.exerciseId, db.exercises.id),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PersonalRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<double> get bestWeightKg => $composableBuilder(
    column: $table.bestWeightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bestRepsAtWeight => $composableBuilder(
    column: $table.bestRepsAtWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bestEstimated1rm => $composableBuilder(
    column: $table.bestEstimated1rm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bestVolumeSingleSet => $composableBuilder(
    column: $table.bestVolumeSingleSet,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PersonalRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<double> get bestWeightKg => $composableBuilder(
    column: $table.bestWeightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bestRepsAtWeight => $composableBuilder(
    column: $table.bestRepsAtWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bestEstimated1rm => $composableBuilder(
    column: $table.bestEstimated1rm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bestVolumeSingleSet => $composableBuilder(
    column: $table.bestVolumeSingleSet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PersonalRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<double> get bestWeightKg => $composableBuilder(
    column: $table.bestWeightKg,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bestRepsAtWeight => $composableBuilder(
    column: $table.bestRepsAtWeight,
    builder: (column) => column,
  );

  GeneratedColumn<double> get bestEstimated1rm => $composableBuilder(
    column: $table.bestEstimated1rm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get bestVolumeSingleSet => $composableBuilder(
    column: $table.bestVolumeSingleSet,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => column,
  );

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PersonalRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PersonalRecordsTable,
          PersonalRecord,
          $$PersonalRecordsTableFilterComposer,
          $$PersonalRecordsTableOrderingComposer,
          $$PersonalRecordsTableAnnotationComposer,
          $$PersonalRecordsTableCreateCompanionBuilder,
          $$PersonalRecordsTableUpdateCompanionBuilder,
          (PersonalRecord, $$PersonalRecordsTableReferences),
          PersonalRecord,
          PrefetchHooks Function({bool exerciseId})
        > {
  $$PersonalRecordsTableTableManager(
    _$AppDatabase db,
    $PersonalRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonalRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonalRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonalRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> exerciseId = const Value.absent(),
                Value<double?> bestWeightKg = const Value.absent(),
                Value<int?> bestRepsAtWeight = const Value.absent(),
                Value<double?> bestEstimated1rm = const Value.absent(),
                Value<double?> bestVolumeSingleSet = const Value.absent(),
                Value<DateTime?> achievedAt = const Value.absent(),
              }) => PersonalRecordsCompanion(
                exerciseId: exerciseId,
                bestWeightKg: bestWeightKg,
                bestRepsAtWeight: bestRepsAtWeight,
                bestEstimated1rm: bestEstimated1rm,
                bestVolumeSingleSet: bestVolumeSingleSet,
                achievedAt: achievedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> exerciseId = const Value.absent(),
                Value<double?> bestWeightKg = const Value.absent(),
                Value<int?> bestRepsAtWeight = const Value.absent(),
                Value<double?> bestEstimated1rm = const Value.absent(),
                Value<double?> bestVolumeSingleSet = const Value.absent(),
                Value<DateTime?> achievedAt = const Value.absent(),
              }) => PersonalRecordsCompanion.insert(
                exerciseId: exerciseId,
                bestWeightKg: bestWeightKg,
                bestRepsAtWeight: bestRepsAtWeight,
                bestEstimated1rm: bestEstimated1rm,
                bestVolumeSingleSet: bestVolumeSingleSet,
                achievedAt: achievedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PersonalRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exerciseId = false}) {
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
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable:
                                    $$PersonalRecordsTableReferences
                                        ._exerciseIdTable(db),
                                referencedColumn:
                                    $$PersonalRecordsTableReferences
                                        ._exerciseIdTable(db)
                                        .id,
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

typedef $$PersonalRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PersonalRecordsTable,
      PersonalRecord,
      $$PersonalRecordsTableFilterComposer,
      $$PersonalRecordsTableOrderingComposer,
      $$PersonalRecordsTableAnnotationComposer,
      $$PersonalRecordsTableCreateCompanionBuilder,
      $$PersonalRecordsTableUpdateCompanionBuilder,
      (PersonalRecord, $$PersonalRecordsTableReferences),
      PersonalRecord,
      PrefetchHooks Function({bool exerciseId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$WorkoutSessionsTableTableManager get workoutSessions =>
      $$WorkoutSessionsTableTableManager(_db, _db.workoutSessions);
  $$WorkoutSetsTableTableManager get workoutSets =>
      $$WorkoutSetsTableTableManager(_db, _db.workoutSets);
  $$BodyWeightLogsTableTableManager get bodyWeightLogs =>
      $$BodyWeightLogsTableTableManager(_db, _db.bodyWeightLogs);
  $$PersonalRecordsTableTableManager get personalRecords =>
      $$PersonalRecordsTableTableManager(_db, _db.personalRecords);
}
