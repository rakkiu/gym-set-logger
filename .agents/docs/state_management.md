# State Management

## Provider Architecture

The app uses **flutter_riverpod ^2.5.1** with a minimal provider set.

### Providers

| Provider | Type | File | Scope |
|----------|------|------|-------|
| `databaseProvider` | `Provider<AppDatabase>` | `shared/database/database_provider.dart` | App-wide singleton |
| `routerProvider` | `Provider<GoRouter>` | `app/router.dart` | App-wide singleton |
| `workoutScheduleProvider` | `StateNotifierProvider<WorkoutScheduleNotifier, WorkoutSchedule>` | `shared/utils/workout_schedule.dart` | App-wide, persisted |

### Data Flow Pattern

```
Widget (ConsumerWidget/ConsumerStatefulWidget)
  └─ ref.read(databaseProvider)        // Get DB instance
       ├─ .select(table)..where()      // Build query
       ├─ .get()                       // One-shot (FutureBuilder)
       └─ .watch()                     // Stream (StreamBuilder)
```

**There is no ViewModel/Controller layer.** All database queries and business logic live directly in widget state methods. This is a deliberate simplicity choice for a small app.

### Widget Types Used

- **ConsumerWidget**: Screens with no local mutable state (HomeScreen, HistoryScreen, ProfileScreen, ScheduleScreen, ExerciseLibraryScreen)
- **ConsumerStatefulWidget**: Screens with local mutable state (ActiveWorkoutScreen, ProgressScreen, BodyWeightScreen, QuickLogSheet)

### Real-Time Updates

Drift streams (`watch()`) are used with `StreamBuilder` for:
- Active session detection (`watchActiveSession()`)
- Session list (`watchAllSessions()`)
- Exercise list (`watchAllExercises()`)
- Sets for session (`watchSetsForSession()`)
- Body weight logs (`watchBodyWeightLogs()`)

One-shot queries (`get()`) with `FutureBuilder` are used for:
- Exercise search/filter
- PR lookups
- Stats calculations (total volume, total workouts)

### WorkoutSchedule Persistence

The only StateNotifier in the project:
- Loads from `SharedPreferences` on init
- Saves to `SharedPreferences` on every mutation
- Stored as JSON string under key `workout_schedule`
- Structure: `{ "1": ["chest", "back"], "3": ["legs"], ... }` (weekday -> muscle groups)

### Key Pattern: Direct DB Access in Widgets

```dart
// Typical pattern — no abstraction layer
final db = ref.read(databaseProvider);
final exercises = await db.allExercises();
final sets = await db.setsForSession(sessionId);
```

This is intentional. The app has ~19 Dart files. Introducing ViewModels would add complexity without proportional benefit.
