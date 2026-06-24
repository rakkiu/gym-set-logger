import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;
import 'package:gymsetlogger/shared/database/database.dart';
import 'package:gymsetlogger/shared/database/database_provider.dart';
import 'package:gymsetlogger/shared/utils/one_rm_calculator.dart';
import 'package:gymsetlogger/shared/utils/workout_schedule.dart';
import 'package:gymsetlogger/features/workout/presentation/schedule_screen.dart';
import 'package:go_router/go_router.dart';

class ActiveWorkoutScreen extends ConsumerStatefulWidget {
  const ActiveWorkoutScreen({super.key});

  @override
  ConsumerState<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends ConsumerState<ActiveWorkoutScreen> {
  WorkoutSession? _session;
  List<WorkoutSet> _sets = [];
  List<Map<String, dynamic>> _exerciseGroups = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final db = ref.read(databaseProvider);
    var session = await db.activeSession();
    if (session == null) {
      await db.createSession();
      session = (await db.activeSession());
    }
    setState(() {
      _session = session;
      _loading = false;
    });
    _loadSets();
  }

  Future<void> _loadSets() async {
    if (_session == null) return;
    final db = ref.read(databaseProvider);
    final sets = await db.setsForSession(_session!.id);
    final groups = <int, List<WorkoutSet>>{};
    for (final s in sets) {
      groups.putIfAbsent(s.exerciseId, () => []).add(s);
    }
    final exercises = await db.allExercises();
    final exerciseMap = {for (final e in exercises) e.id: e};
    setState(() {
      _sets = sets;
      _exerciseGroups = groups.entries.map((e) {
        final ex = exerciseMap[e.key];
        return {
          'exercise': ex,
          'sets': e.value,
        };
      }).toList();
    });
  }

  Future<void> _logSet(int exerciseId, double weight, int reps) async {
    final db = ref.read(databaseProvider);
    if (_session == null) return;

    final existingSets = _sets.where((s) => s.exerciseId == exerciseId).toList();
    final setNumber = existingSets.length + 1;

    final exercise = await (db.select(db.exercises)
          ..where((t) => t.id.equals(exerciseId)))
        .getSingleOrNull();

    final suggestedRest = OneRMCalculator.suggestRestTime(
      exerciseType: exercise?.type ?? 'isolation',
      setNumber: setNumber,
      weight: weight,
      reps: reps,
    );

    // Check PR
    final pr = await db.getPR(exerciseId);
    final est1RM = OneRMCalculator.estimate1RM(weight, reps);
    bool isPR = false;
    if (pr == null || est1RM > (pr.bestEstimated1rm ?? 0)) {
      isPR = true;
      await db.updatePR(
          exerciseId, weight, reps, est1RM, weight * reps, DateTime.now());
    }

    await db.insertSet(
      WorkoutSetsCompanion.insert(
        sessionId: _session!.id,
        exerciseId: exerciseId,
        setNumber: setNumber,
        weightKg: weight,
        reps: reps,
        suggestedRestSeconds: Value(suggestedRest),
        isPr: Value(isPR ? 1 : 0),
        loggedAt: DateTime.now(),
      ),
    );

    _loadSets();

    if (mounted) {
      context.push('/rest-timer', extra: suggestedRest);
    }
  }

  double get _totalVolume {
    double total = 0;
    for (final s in _sets) {
      total += s.weightKg * s.reps;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('ACTIVE WORKOUT'),
        actions: [
          TextButton(
            onPressed: _endWorkout,
            child: const Text('END', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildVolumeHeader(),
          Expanded(
            child: _exerciseGroups.isEmpty
                ? _buildEmptyState()
                : _buildExerciseList(),
          ),
        ],
      ),
    );
  }

  Widget _buildVolumeHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF1A1A1A),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Text('VOLUME', style: TextStyle(color: Color(0xFF888888), fontSize: 12)),
              Text(
                '${_totalVolume.toStringAsFixed(0)} kg',
                style: const TextStyle(
                  color: Color(0xFFC8FF00),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Text('SETS', style: TextStyle(color: Color(0xFF888888), fontSize: 12)),
              Text(
                '${_sets.length}',
                style: const TextStyle(
                  color: Color(0xFFF0F0F0),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.fitness_center, size: 64, color: Color(0xFF888888)),
          const SizedBox(height: 16),
          const Text('Tap + to add your first set',
              style: TextStyle(color: Color(0xFF888888))),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _showQuickLog,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC8FF00),
              foregroundColor: const Color(0xFF0F0F0F),
            ),
            child: const Text('QUICK LOG'),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseList() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: _exerciseGroups.length,
      itemBuilder: (context, index) {
        final group = _exerciseGroups[index];
        final exercise = group['exercise'] as Exercise?;
        final sets = group['sets'] as List<WorkoutSet>;
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercise?.name ?? 'Unknown',
                            style: const TextStyle(
                              color: Color(0xFFF0F0F0),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (exercise?.nameVi != null && exercise!.nameVi.isNotEmpty)
                            Text(
                              exercise.nameVi,
                              style: const TextStyle(
                                color: Color(0xFF888888),
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildSetHeader(),
              ...sets.map((s) => _buildSetRow(s)),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextButton.icon(
                  onPressed: () => _showQuickLogForExercise(exercise!.id),
                  icon: const Icon(Icons.add, color: Color(0xFFC8FF00)),
                  label: const Text('Add Set',
                      style: TextStyle(color: Color(0xFFC8FF00))),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSetHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 40, child: Text('SET', style: TextStyle(color: Color(0xFF888888), fontSize: 11))),
          Expanded(child: Text('WEIGHT', style: TextStyle(color: Color(0xFF888888), fontSize: 11))),
          Expanded(child: Text('REPS', style: TextStyle(color: Color(0xFF888888), fontSize: 11))),
          SizedBox(width: 60, child: Text('REST', style: TextStyle(color: Color(0xFF888888), fontSize: 11))),
          SizedBox(width: 30),
        ],
      ),
    );
  }

  Widget _buildSetRow(WorkoutSet set) {
    return Dismissible(
      key: Key('set_${set.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => _deleteSet(set.id),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          children: [
            SizedBox(
              width: 40,
              child: Text('${set.setNumber}',
                  style: const TextStyle(color: Color(0xFFF0F0F0))),
            ),
            Expanded(
              child: Text('${set.weightKg} kg',
                  style: const TextStyle(color: Color(0xFFF0F0F0))),
            ),
            Expanded(
              child: Text('${set.reps}',
                  style: const TextStyle(color: Color(0xFFF0F0F0))),
            ),
            SizedBox(
              width: 60,
              child: set.restSeconds != null
                  ? Text('${set.restSeconds}s',
                      style: const TextStyle(color: Color(0xFF888888), fontSize: 12))
                  : Text('${set.suggestedRestSeconds ?? 90}s',
                      style: const TextStyle(color: Color(0xFFC8FF00), fontSize: 12)),
            ),
            SizedBox(
              width: 30,
              child: set.isPr == 1
                  ? const Text('🏆', style: TextStyle(fontSize: 14))
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  void _showQuickLog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => QuickLogSheet(
        onLog: (exerciseId, weight, reps) {
          Navigator.pop(context);
          _logSet(exerciseId, weight, reps);
        },
      ),
    );
  }

  void _showQuickLogForExercise(int exerciseId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => QuickLogSheet(
        preselectedExerciseId: exerciseId,
        onLog: (exerciseId, weight, reps) {
          Navigator.pop(context);
          _logSet(exerciseId, weight, reps);
        },
      ),
    );
  }

  Future<void> _deleteSet(int setId) async {
    final db = ref.read(databaseProvider);
    await db.deleteSet(setId);
    _loadSets();
  }

  Future<void> _endWorkout() async {
    if (_session == null) return;
    final db = ref.read(databaseProvider);
    await db.endSession(_session!.id);
    if (mounted) {
      context.go('/');
    }
  }
}

class QuickLogSheet extends ConsumerStatefulWidget {
  final int? preselectedExerciseId;
  final Function(int exerciseId, double weight, int reps) onLog;

  const QuickLogSheet({
    super.key,
    this.preselectedExerciseId,
    required this.onLog,
  });

  @override
  ConsumerState<QuickLogSheet> createState() => _QuickLogSheetState();
}

class _QuickLogSheetState extends ConsumerState<QuickLogSheet> {
  int? _selectedExerciseId;
  String? _selectedMuscleGroup;
  final TextEditingController _searchController = TextEditingController();
  late FixedExtentScrollController _weightController;
  late FixedExtentScrollController _repsController;
  double _weight = 20;
  int _reps = 8;

  @override
  void initState() {
    super.initState();
    _selectedExerciseId = widget.preselectedExerciseId;
    _weightController = FixedExtentScrollController(
      initialItem: (_weight * 2).toInt(),
    );
    _repsController = FixedExtentScrollController(initialItem: _reps - 1);
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1A1A1A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF888888),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Row(
                  children: [
                    const Text('QUICK LOG',
                        style: TextStyle(
                          color: Color(0xFFC8FF00),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    const Spacer(),
                    if (_selectedExerciseId != null)
                      TextButton.icon(
                        onPressed: () =>
                            setState(() => _selectedExerciseId = null),
                        icon: const Icon(Icons.close, size: 16),
                        label: const Text('Change'),
                      ),
                  ],
                ),
              ),
              if (_selectedExerciseId == null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _ExercisePicker(
                    selectedMuscleGroup: _selectedMuscleGroup,
                    selectedExerciseId: _selectedExerciseId,
                    searchController: _searchController,
                    onGroupChanged: (group) =>
                        setState(() => _selectedMuscleGroup = group),
                    onExerciseSelected: (id) =>
                        setState(() => _selectedExerciseId = id),
                  ),
                ),
              ],
              if (_selectedExerciseId != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: _buildSelectedExerciseInfo(),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(child: _buildWeightPicker()),
                      const SizedBox(width: 16),
                      Expanded(child: _buildRepsPicker()),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const.fromLTRB(16, 8, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _selectedExerciseId == null
                        ? null
                        : () {
                            final weight = _weightController.selectedItem * 0.5;
                            final reps = _repsController.selectedItem + 1;
                            widget.onLog(_selectedExerciseId!, weight, reps);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC8FF00),
                      foregroundColor: const Color(0xFF0F0F0F),
                      disabledBackgroundColor: const Color(0xFF252525),
                      disabledForegroundColor: const Color(0xFF888888),
                    ),
                    child: const Text('LOG SET',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSelectedExerciseInfo() {
    final db = ref.read(databaseProvider);
    return FutureBuilder<Exercise?>(
      future: (db.select(db.exercises)..where((t) => t.id.equals(_selectedExerciseId!))).getSingleOrNull(),
      builder: (context, snapshot) {
        final exercise = snapshot.data;
        if (exercise == null) return const SizedBox.shrink();
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF252525),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(_getMuscleIcon(exercise.muscleGroup),
                  color: _getMuscleColor(exercise.muscleGroup), size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(exercise.name,
                        style: const TextStyle(
                          color: Color(0xFFF0F0F0),
                          fontWeight: FontWeight.bold,
                        )),
                    if (exercise.nameVi.isNotEmpty)
                      Text(exercise.nameVi,
                          style: const TextStyle(
                              color: Color(0xFF888888), fontSize: 12)),
                  ],
                ),
              ),
              Text(
                exercise.type.toUpperCase(),
                style: TextStyle(
                  color: _getTypeColor(exercise.type),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWeightPicker() {
    return Column(
      children: [
        const Text('WEIGHT (KG)',
            style: TextStyle(color: Color(0xFF888888), fontSize: 12)),
        Expanded(
          child: ListWheelScrollView.useDelegate(
            controller: _weightController,
            itemExtent: 40,
            diameterRatio: 1.5,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              setState(() => _weight = index * 0.5);
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: 601,
              builder: (context, index) {
                final kg = index * 0.5;
                return Center(
                  child: Text(
                    kg.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 20,
                      color: kg == _weight
                          ? const Color(0xFFC8FF00)
                          : const Color(0xFFF0F0F0),
                      fontWeight: kg == _weight
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRepsPicker() {
    return Column(
      children: [
        const Text('REPS',
            style: TextStyle(color: Color(0xFF888888), fontSize: 12)),
        Expanded(
          child: ListWheelScrollView.useDelegate(
            controller: _repsController,
            itemExtent: 40,
            diameterRatio: 1.5,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              setState(() => _reps = index + 1);
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: 50,
              builder: (context, index) {
                final reps = index + 1;
                return Center(
                  child: Text(
                    '$reps',
                    style: TextStyle(
                      fontSize: 20,
                      color: reps == _reps
                          ? const Color(0xFFC8FF00)
                          : const Color(0xFFF0F0F0),
                      fontWeight: reps == _reps
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  IconData _getMuscleIcon(String group) {
    switch (group) {
      case 'chest': return Icons.fitness_center;
      case 'back': return Icons.swap_vert;
      case 'shoulders': return Icons.accessibility_new;
      case 'arms': return Icons.front_hand;
      case 'legs': return Icons.directions_walk;
      case 'core': return Icons.center_focus_strong;
      default: return Icons.fitness_center;
    }
  }

  Color _getMuscleColor(String group) {
    switch (group) {
      case 'chest': return const Color(0xFFFF6B6B);
      case 'back': return const Color(0xFF4ECDC4);
      case 'shoulders': return const Color(0xFFFFE66D);
      case 'arms': return const Color(0xFF95E1D3);
      case 'legs': return const Color(0xFFAA96DA);
      case 'core': return const Color(0xFFFF8A5C);
      default: return const Color(0xFF888888);
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'compound': return const Color(0xFFC8FF00);
      case 'isolation': return const Color(0xFF4ECDC4);
      case 'bodyweight': return const Color(0xFFAA96DA);
      default: return const Color(0xFF888888);
    }
  }
}

class _ExercisePicker extends ConsumerStatefulWidget {
  final String? selectedMuscleGroup;
  final int? selectedExerciseId;
  final TextEditingController searchController;
  final Function(String?) onGroupChanged;
  final Function(int) onExerciseSelected;

  const _ExercisePicker({
    this.selectedMuscleGroup,
    this.selectedExerciseId,
    required this.searchController,
    required this.onGroupChanged,
    required this.onExerciseSelected,
  });

  @override
  ConsumerState<_ExercisePicker> createState() => _ExercisePickerState();
}

class _ExercisePickerState extends ConsumerState<_ExercisePicker> {
  @override
  void initState() {
    super.initState();
    _initMuscleGroup();
  }

  void _initMuscleGroup() {
    if (widget.selectedMuscleGroup == null) {
      final schedule = ref.read(workoutScheduleProvider);
      final todayGroups = schedule.getTodayMuscleGroups();
      if (todayGroups.isNotEmpty) {
        widget.onGroupChanged(todayGroups.first);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildMuscleGroupChips(),
        const SizedBox(height: 8),
        _buildSearchBar(),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: _buildExerciseList(db),
        ),
        _buildAddExerciseButton(),
      ],
    );
  }

  Widget _buildMuscleGroupChips() {
    final schedule = ref.watch(workoutScheduleProvider);
    final todayGroups = schedule.getTodayMuscleGroups();
    final hasSchedule = todayGroups.isNotEmpty;

    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          if (hasSchedule)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: const Text('Today'),
                selected: widget.selectedMuscleGroup == null,
                selectedColor: const Color(0xFFC8FF00),
                backgroundColor: const Color(0xFF252525),
                labelStyle: TextStyle(
                  color: widget.selectedMuscleGroup == null
                      ? const Color(0xFF0F0F0F)
                      : const Color(0xFFC8FF00),
                  fontSize: 12,
                ),
                onSelected: (_) => widget.onGroupChanged(null),
              ),
            ),
          ..._getVisibleGroups(todayGroups).map((group) {
            final muscle = allMuscleGroups.firstWhere(
              (m) => m['key'] == group,
              orElse: () => allMuscleGroups[0],
            );
            final isSelected = widget.selectedMuscleGroup == group;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                avatar: Icon(muscle['icon'] as IconData,
                    color: isSelected
                        ? const Color(0xFF0F0F0F)
                        : muscle['color'] as Color,
                    size: 14),
                label: Text(muscle['label'] as String),
                selected: isSelected,
                selectedColor: muscle['color'] as Color,
                backgroundColor: const Color(0xFF252525),
                labelStyle: TextStyle(
                  color: isSelected
                      ? const Color(0xFF0F0F0F)
                      : muscle['color'] as Color,
                  fontSize: 12,
                ),
                onSelected: (_) => widget.onGroupChanged(group),
              ),
            );
          }),
        ],
      ),
    );
  }

  List<String> _getVisibleGroups(List<String> todayGroups) {
    if (widget.selectedMuscleGroup == null && todayGroups.isNotEmpty) {
      return todayGroups;
    }
    if (widget.selectedMuscleGroup != null) {
      return [widget.selectedMuscleGroup!];
    }
    return ['chest', 'back', 'shoulders', 'arms', 'legs', 'core'];
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: widget.searchController,
      style: const TextStyle(color: Color(0xFFF0F0F0)),
      decoration: InputDecoration(
        hintText: 'Search exercises...',
        hintStyle: const TextStyle(color: Color(0xFF888888)),
        prefixIcon: const Icon(Icons.search, color: Color(0xFF888888), size: 20),
        filled: true,
        fillColor: const Color(0xFF252525),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      onChanged: (_) => setState(() {}),
    );
  }

  Widget _buildExerciseList(AppDatabase db) {
    return FutureBuilder<List<Exercise>>(
      future: _getFilteredExercises(db),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final exercises = snapshot.data!;
        if (exercises.isEmpty) {
          return const Center(
            child: Text('No exercises found',
                style: TextStyle(color: Color(0xFF888888))),
          );
        }
        return ListView.separated(
          itemCount: exercises.length,
          separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFF252525)),
          itemBuilder: (context, index) {
            final ex = exercises[index];
            final isSelected = ex.id == widget.selectedExerciseId;
            return ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              leading: Icon(_getMuscleIcon(ex.muscleGroup),
                  color: _getMuscleColor(ex.muscleGroup), size: 20),
              title: Text(ex.name,
                  style: TextStyle(
                    color: isSelected
                        ? const Color(0xFFC8FF00)
                        : const Color(0xFFF0F0F0),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 14,
                  )),
              subtitle: ex.nameVi.isNotEmpty
                  ? Text(ex.nameVi,
                      style: const TextStyle(
                          color: Color(0xFF888888), fontSize: 11))
                  : null,
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _getTypeColor(ex.type).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  ex.type.toUpperCase(),
                  style: TextStyle(
                    color: _getTypeColor(ex.type),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () => widget.onExerciseSelected(ex.id),
            );
          },
        );
      },
    );
  }

  Future<List<Exercise>> _getFilteredExercises(AppDatabase db) async {
    final query = widget.searchController.text.trim();
    if (query.isNotEmpty) {
      return db.searchExercises(query);
    }
    if (widget.selectedMuscleGroup != null) {
      return db.exercisesByMuscleGroup(widget.selectedMuscleGroup!);
    }
    final schedule = ref.read(workoutScheduleProvider);
    final todayGroups = schedule.getTodayMuscleGroups();
    if (todayGroups.isNotEmpty) {
      final allExercises = <Exercise>[];
      for (final group in todayGroups) {
        final exs = await db.exercisesByMuscleGroup(group);
        allExercises.addAll(exs);
      }
      return allExercises;
    }
    return db.allExercises();
  }

  Widget _buildAddExerciseButton() {
    return TextButton.icon(
      onPressed: () => _showAddExerciseDialog(context),
      icon: const Icon(Icons.add_circle_outline, color: Color(0xFFC8FF00), size: 18),
      label: const Text('Add new exercise',
          style: TextStyle(color: Color(0xFFC8FF00), fontSize: 13)),
    );
  }

  void _showAddExerciseDialog(BuildContext context) {
    final nameController = TextEditingController();
    final nameViController = TextEditingController();
    String selectedGroup = widget.selectedMuscleGroup ?? 'chest';
    String selectedType = 'compound';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
        ),
        child: StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ADD EXERCISE',
                    style: TextStyle(
                      color: Color(0xFFC8FF00),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: Color(0xFFF0F0F0)),
                  decoration: const InputDecoration(
                    hintText: 'Exercise name (English)',
                    hintStyle: TextStyle(color: Color(0xFF888888)),
                  ),
                  autofocus: true,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: nameViController,
                  style: const TextStyle(color: Color(0xFFF0F0F0)),
                  decoration: const InputDecoration(
                    hintText: 'Vietnamese name (optional)',
                    hintStyle: TextStyle(color: Color(0xFF888888)),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButton<String>(
                  value: selectedGroup,
                  dropdownColor: const Color(0xFF252525),
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: allMuscleGroups
                      .map((m) => DropdownMenuItem(
                            value: m['key'] as String,
                            child: Text(m['label'] as String),
                          ))
                      .toList(),
                  onChanged: (v) => setSheetState(() => selectedGroup = v!),
                ),
                const SizedBox(height: 8),
                DropdownButton<String>(
                  value: selectedType,
                  dropdownColor: const Color(0xFF252525),
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(value: 'compound', child: Text('Compound')),
                    DropdownMenuItem(value: 'isolation', child: Text('Isolation')),
                    DropdownMenuItem(value: 'bodyweight', child: Text('Bodyweight')),
                  ],
                  onChanged: (v) => setSheetState(() => selectedType = v!),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (nameController.text.isNotEmpty) {
                        final db = ref.read(databaseProvider);
                        final newId = await db.insertExercise(
                          ExercisesCompanion.insert(
                            name: nameController.text,
                            nameVi: Value(nameViController.text),
                            muscleGroup: selectedGroup,
                            type: selectedType,
                            isCustom: const Value(1),
                            createdAt: DateTime.now(),
                          ),
                        );
                        if (ctx.mounted) Navigator.pop(ctx);
                        widget.onExerciseSelected(newId);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC8FF00),
                      foregroundColor: const Color(0xFF0F0F0F),
                    ),
                    child: const Text('ADD & SELECT'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  IconData _getMuscleIcon(String group) {
    switch (group) {
      case 'chest': return Icons.fitness_center;
      case 'back': return Icons.swap_vert;
      case 'shoulders': return Icons.accessibility_new;
      case 'arms': return Icons.front_hand;
      case 'legs': return Icons.directions_walk;
      case 'core': return Icons.center_focus_strong;
      default: return Icons.fitness_center;
    }
  }

  Color _getMuscleColor(String group) {
    switch (group) {
      case 'chest': return const Color(0xFFFF6B6B);
      case 'back': return const Color(0xFF4ECDC4);
      case 'shoulders': return const Color(0xFFFFE66D);
      case 'arms': return const Color(0xFF95E1D3);
      case 'legs': return const Color(0xFFAA96DA);
      case 'core': return const Color(0xFFFF8A5C);
      default: return const Color(0xFF888888);
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'compound': return const Color(0xFFC8FF00);
      case 'isolation': return const Color(0xFF4ECDC4);
      case 'bodyweight': return const Color(0xFFAA96DA);
      default: return const Color(0xFF888888);
    }
  }
}
