# Architecture

## Project Structure

```
gymsetlogger/
├── lib/
│   ├── main.dart                          # Entry point, ProviderScope + MaterialApp.router
│   ├── app/
│   │   ├── router.dart                    # GoRouter config + ScaffoldWithNav (4-tab bottom nav)
│   │   └── theme.dart                     # Dark theme, AppColors, AppTheme
│   ├── features/
│   │   ├── workout/presentation/
│   │   │   ├── workout_screen.dart        # HomeScreen (Tab 0)
│   │   │   ├── active_workout_screen.dart # ActiveWorkoutScreen + QuickLogSheet + ExercisePicker
│   │   │   ├── rest_timer_screen.dart     # Full-screen countdown timer
│   │   │   └── schedule_screen.dart       # Weekly muscle group planner
│   │   ├── exercise_library/presentation/
│   │   │   └── exercise_library_screen.dart # CRUD exercises, search, filter
│   │   ├── body_weight/presentation/
│   │   │   └── body_weight_screen.dart    # Weight chart + daily log
│   │   └── analytics/presentation/
│   │       ├── progress_screen.dart       # 1RM + volume charts per exercise
│   │       ├── history_screen.dart        # Month-based session list (grouped by day)
│   │       └── profile_screen.dart        # Settings, export XLSX, backup/restore
│   └── shared/
│       ├── database/
│       │   ├── tables.dart                # 5 Drift table definitions
│       │   ├── database.dart              # AppDatabase, queries, seed 31 exercises
│       │   ├── database.g.dart            # GENERATED — do not edit
│       │   └── database_provider.dart     # Provider<AppDatabase>
│       └── utils/
│           ├── one_rm_calculator.dart      # 1RM formulas + rest time algorithm
│           ├── workout_schedule.dart       # Schedule model + StateNotifier + SharedPreferences
│           ├── date_helper.dart            # DateFormat wrappers
│           └── android_storage_helper.dart # MethodChannel for MediaStore file save
├── android/
│   └── app/src/main/kotlin/.../MainActivity.kt  # Native handler for storage channel
└── assets/
    └── exercises.json                      # Listed in pubspec, not actively loaded
```

## Navigation

GoRouter with a `ShellRoute` providing `ScaffoldWithNav` (bottom nav bar):

| Tab | Path | Widget |
|-----|------|--------|
| 0 | `/` | HomeScreen |
| 1 | `/history` | HistoryScreen |
| 2 | `/progress` | ProgressScreen |
| 3 | `/profile` | ProfileScreen |

Center FAB navigates to `/workout/active` (outside shell).

**Top-level routes** (no bottom nav):
- `/workout/active` — ActiveWorkoutScreen
- `/rest-timer` — RestTimerScreen (accepts `extra: int` for seconds)
- `/exercises` — ExerciseLibraryScreen
- `/body-weight` — BodyWeightScreen
- `/schedule` — ScheduleScreen

## Feature Modules

Each feature follows the same structure:
```
features/<name>/
└── presentation/
    └── <name>_screen.dart
```

No separate `data/` or `domain/` layers exist — database queries are performed directly in widget state via `ref.read(databaseProvider)`. Streams (`StreamBuilder`) handle real-time updates; `FutureBuilder` for one-shot queries.
