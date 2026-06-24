import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;
import 'package:gymsetlogger/shared/database/database.dart';
import 'package:gymsetlogger/shared/database/database_provider.dart';

class ExerciseLibraryScreen extends ConsumerStatefulWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  ConsumerState<ExerciseLibraryScreen> createState() =>
      _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState extends ConsumerState<ExerciseLibraryScreen> {
  String _selectedGroup = 'all';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('EXERCISES'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddExerciseDialog(context, db),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildMuscleGroupFilter(),
          Expanded(
            child: _buildExerciseList(db),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Color(0xFFF0F0F0)),
        decoration: InputDecoration(
          hintText: 'Search exercises...',
          hintStyle: const TextStyle(color: Color(0xFF888888)),
          prefixIcon:
              const Icon(Icons.search, color: Color(0xFF888888)),
          filled: true,
          fillColor: const Color(0xFF1A1A1A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildMuscleGroupFilter() {
    final groups = [
      ('all', 'All'),
      ('chest', 'Chest'),
      ('back', 'Back'),
      ('shoulders', 'Shoulders'),
      ('arms', 'Arms'),
      ('legs', 'Legs'),
      ('core', 'Core'),
    ];

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: groups.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final (key, label) = groups[index];
          final isSelected = _selectedGroup == key;
          return ChoiceChip(
            label: Text(label),
            selected: isSelected,
            selectedColor: const Color(0xFFC8FF00),
            backgroundColor: const Color(0xFF252525),
            labelStyle: TextStyle(
              color: isSelected
                  ? const Color(0xFF0F0F0F)
                  : const Color(0xFFF0F0F0),
              fontSize: 12,
            ),
            onSelected: (_) => setState(() => _selectedGroup = key),
          );
        },
      ),
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
          padding: const EdgeInsets.all(12),
          itemCount: exercises.length,
          separatorBuilder: (_, __) => const Divider(
            height: 1,
            color: Color(0xFF252525),
          ),
          itemBuilder: (context, index) {
            final ex = exercises[index];
            return Dismissible(
              key: Key('exercise_${ex.id}'),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 16),
                color: const Color(0xFFFF4444),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              confirmDismiss: (_) => _confirmDelete(ex),
              onDismissed: (_) => _deleteExercise(ex),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                leading: _buildMuscleIcon(ex.muscleGroup),
                title: Text(
                  ex.name,
                  style: const TextStyle(color: Color(0xFFF0F0F0)),
                ),
                subtitle: Text(
                  ex.nameVi,
                  style: const TextStyle(color: Color(0xFF888888), fontSize: 12),
                ),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getTypeColor(ex.type).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    ex.type.toUpperCase(),
                    style: TextStyle(
                      color: _getTypeColor(ex.type),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () => _showEditExerciseDialog(ex),
              ),
            );
          },
        );
      },
    );
  }

  Future<List<Exercise>> _getFilteredExercises(AppDatabase db) async {
    List<Exercise> exercises;
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      exercises = await db.searchExercises(query);
    } else if (_selectedGroup != 'all') {
      exercises = await db.exercisesByMuscleGroup(_selectedGroup);
    } else {
      exercises = await db.allExercises();
    }
    return exercises;
  }

  Widget _buildMuscleIcon(String group) {
    IconData icon;
    Color color;
    switch (group) {
      case 'chest':
        icon = Icons.fitness_center;
        color = const Color(0xFFFF6B6B);
        break;
      case 'back':
        icon = Icons.swap_vert;
        color = const Color(0xFF4ECDC4);
        break;
      case 'shoulders':
        icon = Icons.accessibility_new;
        color = const Color(0xFFFFE66D);
        break;
      case 'arms':
        icon = Icons.front_hand;
        color = const Color(0xFF95E1D3);
        break;
      case 'legs':
        icon = Icons.directions_walk;
        color = const Color(0xFFAA96DA);
        break;
      case 'core':
        icon = Icons.center_focus_strong;
        color = const Color(0xFFFF8A5C);
        break;
      default:
        icon = Icons.fitness_center;
        color = const Color(0xFF888888);
    }
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'compound':
        return const Color(0xFFC8FF00);
      case 'isolation':
        return const Color(0xFF4ECDC4);
      case 'bodyweight':
        return const Color(0xFFAA96DA);
      default:
        return const Color(0xFF888888);
    }
  }

  Future<bool?> _confirmDelete(Exercise exercise) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Text(
          'Delete "${exercise.name}"?',
          style: const TextStyle(color: Color(0xFFF0F0F0), fontSize: 16),
        ),
        content: const Text(
          'This will permanently remove this exercise. Any logged sets using it will still appear in history.',
          style: TextStyle(color: Color(0xFF888888), fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF888888))),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: Color(0xFFFF4444))),
          ),
        ],
      ),
    );
  }

  void _deleteExercise(Exercise exercise) async {
    final db = ref.read(databaseProvider);
    await db.deleteExercise(exercise.id);
    setState(() {});
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Deleted "${exercise.name}"'),
          action: SnackBarAction(
            label: 'Undo',
            textColor: const Color(0xFFC8FF00),
            onPressed: () async {
              await db.insertExercise(
                ExercisesCompanion.insert(
                  name: exercise.name,
                  nameVi: Value(exercise.nameVi),
                  muscleGroup: exercise.muscleGroup,
                  type: exercise.type,
                  defaultRestSeconds: Value(exercise.defaultRestSeconds),
                  isCustom: Value(exercise.isCustom),
                  createdAt: exercise.createdAt,
                ),
              );
              setState(() {});
            },
          ),
        ),
      );
    }
  }

  void _showAddExerciseDialog(BuildContext context, AppDatabase db) {
    final nameController = TextEditingController();
    final nameViController = TextEditingController();
    String selectedGroup = 'chest';
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
                    hintText: 'English name',
                    hintStyle: TextStyle(color: Color(0xFF888888)),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: nameViController,
                  style: const TextStyle(color: Color(0xFFF0F0F0)),
                  decoration: const InputDecoration(
                    hintText: 'Vietnamese name',
                    hintStyle: TextStyle(color: Color(0xFF888888)),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButton<String>(
                  value: selectedGroup,
                  dropdownColor: const Color(0xFF252525),
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: 'chest', child: Text('Chest')),
                    DropdownMenuItem(value: 'back', child: Text('Back')),
                    DropdownMenuItem(value: 'shoulders', child: Text('Shoulders')),
                    DropdownMenuItem(value: 'arms', child: Text('Arms')),
                    DropdownMenuItem(value: 'legs', child: Text('Legs')),
                    DropdownMenuItem(value: 'core', child: Text('Core')),
                  ],
                  onChanged: (v) => setSheetState(() => selectedGroup = v!),
                ),
                const SizedBox(height: 8),
                DropdownButton<String>(
                  value: selectedType,
                  dropdownColor: const Color(0xFF252525),
                  isExpanded: true,
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
                        await db.insertExercise(
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
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC8FF00),
                      foregroundColor: const Color(0xFF0F0F0F),
                    ),
                    child: const Text('ADD'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showEditExerciseDialog(Exercise exercise) {
    final db = ref.read(databaseProvider);
    final nameController = TextEditingController(text: exercise.name);
    final nameViController = TextEditingController(text: exercise.nameVi);
    String selectedGroup = exercise.muscleGroup;
    String selectedType = exercise.type;

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
                const Text('EDIT EXERCISE',
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
                    hintText: 'Exercise name',
                    hintStyle: TextStyle(color: Color(0xFF888888)),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: nameViController,
                  style: const TextStyle(color: Color(0xFFF0F0F0)),
                  decoration: const InputDecoration(
                    hintText: 'Vietnamese name',
                    hintStyle: TextStyle(color: Color(0xFF888888)),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButton<String>(
                  value: selectedGroup,
                  dropdownColor: const Color(0xFF252525),
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(value: 'chest', child: Text('Chest')),
                    DropdownMenuItem(value: 'back', child: Text('Back')),
                    DropdownMenuItem(value: 'shoulders', child: Text('Shoulders')),
                    DropdownMenuItem(value: 'arms', child: Text('Arms')),
                    DropdownMenuItem(value: 'legs', child: Text('Legs')),
                    DropdownMenuItem(value: 'core', child: Text('Core')),
                  ],
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
                        await db.updateExercise(
                          exercise.id,
                          ExercisesCompanion(
                            name: Value(nameController.text),
                            nameVi: Value(nameViController.text),
                            muscleGroup: Value(selectedGroup),
                            type: Value(selectedType),
                          ),
                        );
                        if (ctx.mounted) Navigator.pop(ctx);
                        setState(() {});
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC8FF00),
                      foregroundColor: const Color(0xFF0F0F0F),
                    ),
                    child: const Text('SAVE'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
