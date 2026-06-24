# Business Logic

## 1RM Estimation

**File:** `lib/shared/utils/one_rm_calculator.dart`

### Epley Formula (default)
```dart
weight * (1 + reps / 30)
```

### Brzycki Formula (available but unused)
```dart
weight * 36 / (37 - reps)
```

The app uses Epley everywhere via `OneRMCalculator.estimate1RM(weight, reps)`.

## Smart Rest Timer

**File:** `lib/shared/utils/one_rm_calculator.dart` — `suggestRestTime()`

### Inputs
- `exerciseType`: "compound" or "isolation"/"bodyweight"
- `setNumber`: 1-indexed set count for current exercise
- `weight`, `reps`: current set data

### Algorithm
1. Calculate estimated 1RM (Epley)
2. Calculate intensity: `weight / estimated1RM` (clamped 0.0–1.0)
3. Base rest: **120s** (compound) / **60s** (isolation)
4. Intensity bonus: +60s if >0.85, +30s if >0.70
5. Fatigue penalty: +`(setNumber - 1) * 10` seconds
6. Clamp to **30–300 seconds**

### Example
Bench press 100kg x 5 reps, set 3:
- 1RM = 100 * (1 + 5/30) = 116.7
- Intensity = 100/116.7 = 0.857
- Result = 120 + 60 (intensity) + 20 (set 3) = **200s**

## PR Detection

**File:** `lib/features/workout/presentation/active_workout_screen.dart` — `_logSet()`

On every set logged:
1. Compute new est. 1RM via Epley
2. Fetch existing `PersonalRecords` row for that exercise
3. If no PR exists or new 1RM > existing `bestEstimated1rm`:
   - Set `isPr = 1` on the set
   - Upsert `PersonalRecords` with new best values

## Workout Schedule

**File:** `lib/shared/utils/workout_schedule.dart`

- `WorkoutSchedule`: immutable model mapping weekday (int) to muscle groups (List of string)
- Persisted as JSON in SharedPreferences under key `workout_schedule`
- `WorkoutScheduleNotifier`: loads on init, saves on every change
- Used by QuickLogSheet to auto-filter exercises by today's scheduled muscle groups

## Body Weight Tracking

**File:** `lib/features/body_weight/presentation/body_weight_screen.dart`

- Daily log with unique date constraint (`BodyWeightLogs.date`)
- Charts via fl_chart: LineChart for weight trend, support 7D/30D/90D periods
- Stats: min, max, average over selected period

## Export (XLSX)

**File:** `lib/features/analytics/presentation/profile_screen.dart` — `_exportXLSX()`

1. Filter sessions by selected date range
2. Create Excel workbook with `excel` package
3. Write header row (bold, lime background) + data rows
4. Save via native Android MethodChannel (`com.gymsetlogger/storage`)
5. Uses MediaStore API for Android 10+, direct file write for older versions

## Backup / Restore

**File:** `lib/features/analytics/presentation/profile_screen.dart`

- Backup: copies `gymlog.sqlite` to user-selected location via `file_picker`
- Restore: copies user-selected `.gymlog` file over current database, requires app restart
