# Database

**ORM:** Drift ^2.22.0 (SQLite wrapper)
**File:** `appDocuments/gymlog/gymlog.sqlite`
**Schema version:** 1
**Generated file:** `database.g.dart` (run `build_runner` after schema changes)

## Tables

### Exercises
| Column | Type | Default | Notes |
|--------|------|---------|-------|
| id | Integer PK | auto-increment | |
| name | Text | required | English name |
| nameVi | Text | `''` | Vietnamese name |
| muscleGroup | Text | required | One of: chest, back, shoulders, arms, legs, core |
| type | Text | required | One of: compound, isolation, bodyweight |
| defaultRestSeconds | Integer | 90 | |
| isCustom | Integer | 0 | 0=seeded, 1=user-created |
| createdAt | DateTime | required | |

### WorkoutSessions
| Column | Type | Notes |
|--------|------|-------|
| id | Integer PK | auto-increment |
| startedAt | DateTime | required |
| endedAt | DateTime | nullable (NULL = active session) |
| notes | Text | nullable |
| bodyWeightKg | Real | nullable |

### WorkoutSets
| Column | Type | Notes |
|--------|------|-------|
| id | Integer PK | auto-increment |
| sessionId | Integer FK | → WorkoutSessions.id |
| exerciseId | Integer FK | → Exercises.id |
| setNumber | Integer | 1-indexed within exercise per session |
| weightKg | Real | required |
| reps | Integer | required |
| restSeconds | Integer | nullable (actual rest taken) |
| suggestedRestSeconds | Integer | nullable (algorithm output) |
| isPr | Integer | 0 or 1 |
| loggedAt | DateTime | required |

### BodyWeightLogs
| Column | Type | Notes |
|--------|------|-------|
| id | Integer PK | auto-increment |
| date | Text | unique, format `yyyy-MM-dd` |
| weightKg | Real | required |
| note | Text | nullable |
| loggedAt | DateTime | required |

### PersonalRecords
| Column | Type | Notes |
|--------|------|-------|
| exerciseId | Integer PK FK | → Exercises.id (composite PK) |
| bestWeightKg | Real | nullable |
| bestRepsAtWeight | Integer | nullable |
| bestEstimated1rm | Real | nullable |
| bestVolumeSingleSet | Real | nullable |
| achievedAt | DateTime | nullable |

## Relationships

```
WorkoutSets.sessionId  → WorkoutSessions.id  (many-to-one)
WorkoutSets.exerciseId → Exercises.id         (many-to-one)
PersonalRecords.exerciseId → Exercises.id     (one-to-one, exerciseId is PK)
```

## Seed Data

31 exercises inserted on database creation via `_seedExercises()`:
- 5 chest, 5 back, 5 shoulders, 5 arms, 7 legs, 4 core
- Each has English name, Vietnamese name, type, default rest seconds

## Key Queries

- `watchActiveSession()` — stream of sessions where `endedAt IS NULL`
- `setsForSession(int sessionId)` — all sets for a session, ordered by setNumber
- `searchExercises(String query)` — searches `name` and `nameVi` (case-insensitive LIKE)
- `insertOnConflictUpdate` used for upserting PersonalRecords

## Adding a Migration

1. Bump `schemaVersion` in `AppDatabase`
2. Add migration logic in `MigrationStrategy.migration`
3. Run `flutter pub run build_runner build --delete-conflicting-outputs`
4. Test on fresh install AND upgrade path
