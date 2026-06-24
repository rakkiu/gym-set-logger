import 'package:drift/drift.dart';

class Exercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get nameVi => text().withDefault(const Constant(''))();
  TextColumn get muscleGroup => text()();
  TextColumn get type => text()();
  IntColumn get defaultRestSeconds => integer().withDefault(const Constant(90))();
  IntColumn get isCustom => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
}

class WorkoutSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  RealColumn get bodyWeightKg => real().nullable()();
}

class WorkoutSets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer().references(WorkoutSessions, #id)();
  IntColumn get exerciseId => integer().references(Exercises, #id)();
  IntColumn get setNumber => integer()();
  RealColumn get weightKg => real()();
  IntColumn get reps => integer()();
  IntColumn get restSeconds => integer().nullable()();
  IntColumn get suggestedRestSeconds => integer().nullable()();
  IntColumn get isPr => integer().withDefault(const Constant(0))();
  DateTimeColumn get loggedAt => dateTime()();
}

class BodyWeightLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()();
  RealColumn get weightKg => real()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
}

class PersonalRecords extends Table {
  IntColumn get exerciseId => integer().references(Exercises, #id)();
  RealColumn get bestWeightKg => real().nullable()();
  IntColumn get bestRepsAtWeight => integer().nullable()();
  RealColumn get bestEstimated1rm => real().nullable()();
  RealColumn get bestVolumeSingleSet => real().nullable()();
  DateTimeColumn get achievedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {exerciseId};
}
