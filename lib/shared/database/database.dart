import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Exercises,
  WorkoutSessions,
  WorkoutSets,
  BodyWeightLogs,
  PersonalRecords,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedExercises();
        },
      );

  // --- Exercise Queries ---
  Future<List<Exercise>> allExercises() => select(exercises).get();

  Future<List<Exercise>> exercisesByMuscleGroup(String group) {
    return (select(exercises)..where((t) => t.muscleGroup.equals(group))).get();
  }

  Future<List<Exercise>> searchExercises(String query) {
    return (select(exercises)
          ..where((t) => t.name.lower().like('%$query%') |
              t.nameVi.lower().like('%$query%')))
        .get();
  }

  Stream<List<Exercise>> watchAllExercises() => select(exercises).watch();

  Future<int> insertExercise(ExercisesCompanion exercise) =>
      into(exercises).insert(exercise);

  // --- Workout Session Queries ---
  Future<int> createSession() async {
    final id = await into(workoutSessions).insert(
      WorkoutSessionsCompanion.insert(
        startedAt: DateTime.now(),
        bodyWeightKg: const Value.absent(),
      ),
    );
    return id;
  }

  Future<void> endSession(int sessionId) {
    return (update(workoutSessions)..where((t) => t.id.equals(sessionId))).write(
      WorkoutSessionsCompanion(endedAt: Value(DateTime.now())),
    );
  }

  Future<WorkoutSession?> activeSession() {
    return (select(workoutSessions)
          ..where((t) => t.endedAt.isNull())
          ..limit(1))
        .getSingleOrNull();
  }

  Stream<WorkoutSession?> watchActiveSession() {
    return (select(workoutSessions)
          ..where((t) => t.endedAt.isNull())
          ..limit(1))
        .watchSingleOrNull();
  }

  Future<List<WorkoutSession>> allSessions() {
    return (select(workoutSessions)
          ..where((t) => t.endedAt.isNotNull())
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
        .get();
  }

  Stream<List<WorkoutSession>> watchAllSessions() {
    return (select(workoutSessions)
          ..where((t) => t.endedAt.isNotNull())
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
        .watch();
  }

  Future<List<WorkoutSession>> sessionsInRange(DateTime start, DateTime end) {
    return (select(workoutSessions)
          ..where(
              (t) => t.startedAt.isBetweenValues(start, end) & t.endedAt.isNotNull())
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
        .get();
  }

  Future<void> updateSessionBodyWeight(int sessionId, double weight) {
    return (update(workoutSessions)..where((t) => t.id.equals(sessionId))).write(
      WorkoutSessionsCompanion(bodyWeightKg: Value(weight)),
    );
  }

  // --- Workout Set Queries ---
  Future<int> insertSet(WorkoutSetsCompanion set) =>
      into(workoutSets).insert(set);

  Stream<List<WorkoutSet>> watchSetsForSession(int sessionId) {
    return (select(workoutSets)
          ..where((t) => t.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm.asc(t.setNumber)]))
        .watch();
  }

  Future<List<WorkoutSet>> setsForSession(int sessionId) {
    return (select(workoutSets)
          ..where((t) => t.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm.asc(t.setNumber)]))
        .get();
  }

  Future<void> deleteSet(int setId) {
    return (delete(workoutSets)..where((t) => t.id.equals(setId))).go();
  }

  Future<void> updateSet(int setId, WorkoutSetsCompanion data) {
    return (update(workoutSets)..where((t) => t.id.equals(setId))).write(data);
  }

  // --- Body Weight Queries ---
  Future<int> insertBodyWeight(BodyWeightLogsCompanion log) =>
      into(bodyWeightLogs).insert(log, mode: InsertMode.insertOrReplace);

  Stream<List<BodyWeightLog>> watchBodyWeightLogs() {
    return (select(bodyWeightLogs)
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();
  }

  Future<BodyWeightLog?> latestBodyWeight() {
    return (select(bodyWeightLogs)
          ..orderBy([(t) => OrderingTerm.desc(t.date)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<List<BodyWeightLog>> bodyWeightInRange(String start, String end) {
    return (select(bodyWeightLogs)
          ..where((t) => t.date.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .get();
  }

  Stream<List<BodyWeightLog>> watchBodyWeightInRange(String start, String end) {
    return (select(bodyWeightLogs)
          ..where((t) => t.date.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .watch();
  }

  // --- Personal Records ---
  Future<PersonalRecord?> getPR(int exerciseId) {
    return (select(personalRecords)
          ..where((t) => t.exerciseId.equals(exerciseId)))
        .getSingleOrNull();
  }

  Future<void> updatePR(int exerciseId, double bestWeight, int bestReps,
      double best1RM, double bestVolume, DateTime achievedAt) {
    return into(personalRecords).insertOnConflictUpdate(
      PersonalRecordsCompanion(
        exerciseId: Value(exerciseId),
        bestWeightKg: Value(bestWeight),
        bestRepsAtWeight: Value(bestReps),
        bestEstimated1rm: Value(best1RM),
        bestVolumeSingleSet: Value(bestVolume),
        achievedAt: Value(achievedAt),
      ),
    );
  }

  // --- Stats Queries ---
  Future<double> totalVolumeAllTime() async {
    final query = select(workoutSets).join([
      innerJoin(workoutSessions,
          workoutSessions.id.equalsExp(workoutSets.sessionId)),
    ]);
    query.where(workoutSessions.endedAt.isNotNull());
    final results = await query.get();
    double total = 0;
    for (final row in results) {
      final set = row.readTable(workoutSets);
      total += set.weightKg * set.reps;
    }
    return total;
  }

  Future<int> totalWorkouts() async {
    final count = workoutSessions.id.count();
    final query = selectOnly(workoutSessions)
      ..addColumns([count])
      ..where(workoutSessions.endedAt.isNotNull());
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  Future<List<WorkoutSet>> setsForExercise(int exerciseId) {
    return (select(workoutSets)
          ..where((t) => t.exerciseId.equals(exerciseId))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .get();
  }

  Stream<List<WorkoutSet>> watchSetsForExercise(int exerciseId) {
    return (select(workoutSets)
          ..where((t) => t.exerciseId.equals(exerciseId))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .watch();
  }

  Future<void> _seedExercises() async {
    final defaults = [
      {'name': 'Bench Press', 'name_vi': 'Đẩy ngực nằm', 'muscle_group': 'chest', 'type': 'compound', 'default_rest': 120},
      {'name': 'Incline Bench Press', 'name_vi': 'Đẩy ngực trên', 'muscle_group': 'chest', 'type': 'compound', 'default_rest': 120},
      {'name': 'Dumbbell Fly', 'name_vi': 'Ép ngực dumbbell', 'muscle_group': 'chest', 'type': 'isolation', 'default_rest': 60},
      {'name': 'Cable Crossover', 'name_vi': 'Ép ngực cáp', 'muscle_group': 'chest', 'type': 'isolation', 'default_rest': 60},
      {'name': 'Push Up', 'name_vi': 'Hít đất', 'muscle_group': 'chest', 'type': 'bodyweight', 'default_rest': 60},

      {'name': 'Barbell Row', 'name_vi': 'Kéo tạ đòn', 'muscle_group': 'back', 'type': 'compound', 'default_rest': 120},
      {'name': 'Deadlift', 'name_vi': 'Đẩy tạ sàn', 'muscle_group': 'back', 'type': 'compound', 'default_rest': 180},
      {'name': 'Pull Up', 'name_vi': 'Kéo xà', 'muscle_group': 'back', 'type': 'bodyweight', 'default_rest': 90},
      {'name': 'Lat Pulldown', 'name_vi': 'Kéo cáp trên', 'muscle_group': 'back', 'type': 'isolation', 'default_rest': 60},
      {'name': 'Seated Cable Row', 'name_vi': 'Kéo cáp ngồi', 'muscle_group': 'back', 'type': 'isolation', 'default_rest': 60},

      {'name': 'Overhead Press', 'name_vi': 'Đẩy vai đứng', 'muscle_group': 'shoulders', 'type': 'compound', 'default_rest': 120},
      {'name': 'Lateral Raise', 'name_vi': 'Nâng tay ngang', 'muscle_group': 'shoulders', 'type': 'isolation', 'default_rest': 60},
      {'name': 'Front Raise', 'name_vi': 'Nâng tay trước', 'muscle_group': 'shoulders', 'type': 'isolation', 'default_rest': 60},
      {'name': 'Rear Delt Fly', 'name_vi': 'Ép vai sau', 'muscle_group': 'shoulders', 'type': 'isolation', 'default_rest': 60},
      {'name': 'Arnold Press', 'name_vi': 'Đẩy vai Arnold', 'muscle_group': 'shoulders', 'type': 'compound', 'default_rest': 90},

      {'name': 'Barbell Curl', 'name_vi': 'Cuốn tạ đòn', 'muscle_group': 'arms', 'type': 'isolation', 'default_rest': 60},
      {'name': 'Tricep Pushdown', 'name_vi': 'Đẩy cáp xuống', 'muscle_group': 'arms', 'type': 'isolation', 'default_rest': 60},
      {'name': 'Hammer Curl', 'name_vi': 'Cuốn búa', 'muscle_group': 'arms', 'type': 'isolation', 'default_rest': 60},
      {'name': 'Skull Crusher', 'name_vi': 'Ép tay sau', 'muscle_group': 'arms', 'type': 'isolation', 'default_rest': 60},
      {'name': 'Dip', 'name_vi': 'Chống đất', 'muscle_group': 'arms', 'type': 'bodyweight', 'default_rest': 60},

      {'name': 'Squat', 'name_vi': 'Ngồi xổm', 'muscle_group': 'legs', 'type': 'compound', 'default_rest': 180},
      {'name': 'Leg Press', 'name_vi': 'Đẩy chân', 'muscle_group': 'legs', 'type': 'compound', 'default_rest': 120},
      {'name': 'Romanian Deadlift', 'name_vi': 'Đẩy tay chân', 'muscle_group': 'legs', 'type': 'compound', 'default_rest': 120},
      {'name': 'Leg Extension', 'name_vi': 'Duỗi chân', 'muscle_group': 'legs', 'type': 'isolation', 'default_rest': 60},
      {'name': 'Leg Curl', 'name_vi': 'Cuốn chân', 'muscle_group': 'legs', 'type': 'isolation', 'default_rest': 60},
      {'name': 'Calf Raise', 'name_vi': 'Nâng gót chân', 'muscle_group': 'legs', 'type': 'isolation', 'default_rest': 60},
      {'name': 'Lunge', 'name_vi': 'Bước chân', 'muscle_group': 'legs', 'type': 'compound', 'default_rest': 90},

      {'name': 'Plank', 'name_vi': 'Plank', 'muscle_group': 'core', 'type': 'bodyweight', 'default_rest': 60},
      {'name': 'Crunch', 'name_vi': 'Gập bụng', 'muscle_group': 'core', 'type': 'bodyweight', 'default_rest': 60},
      {'name': 'Hanging Leg Raise', 'name_vi': 'Nâng chân treo', 'muscle_group': 'core', 'type': 'bodyweight', 'default_rest': 60},
      {'name': 'Ab Rollout', 'name_vi': 'Lăn bụng', 'muscle_group': 'core', 'type': 'isolation', 'default_rest': 60},
    ];

    for (final e in defaults) {
      await into(exercises).insert(
        ExercisesCompanion.insert(
          name: e['name'] as String,
          nameVi: Value(e['name_vi'] as String),
          muscleGroup: e['muscle_group'] as String,
          type: e['type'] as String,
          defaultRestSeconds: Value(e['default_rest'] as int),
          isCustom: const Value(0),
          createdAt: DateTime.now(),
        ),
      );
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'gymlog', 'gymlog.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
