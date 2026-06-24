import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymsetlogger/shared/utils/workout_schedule.dart';

const Map<int, String> weekdayNames = {
  1: 'Monday',
  2: 'Tuesday',
  3: 'Wednesday',
  4: 'Thursday',
  5: 'Friday',
  6: 'Saturday',
  7: 'Sunday',
};

const List<Map<String, dynamic>> allMuscleGroups = [
  {'key': 'chest', 'label': 'Chest', 'icon': Icons.fitness_center, 'color': Color(0xFFFF6B6B)},
  {'key': 'back', 'label': 'Back', 'icon': Icons.swap_vert, 'color': Color(0xFF4ECDC4)},
  {'key': 'shoulders', 'label': 'Shoulders', 'icon': Icons.accessibility_new, 'color': Color(0xFFFFE66D)},
  {'key': 'arms', 'label': 'Arms', 'icon': Icons.front_hand, 'color': Color(0xFF95E1D3)},
  {'key': 'legs', 'label': 'Legs', 'icon': Icons.directions_walk, 'color': Color(0xFFAA96DA)},
  {'key': 'core', 'label': 'Core', 'icon': Icons.center_focus_strong, 'color': Color(0xFFFF8A5C)},
];

class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedule = ref.watch(workoutScheduleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('WORKOUT SCHEDULE'),
        centerTitle: false,
      ),
      body: schedule.isEmpty()
          ? _buildEmptyState(context, ref)
          : _buildScheduleList(context, ref, schedule),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today, size: 64, color: Colors.grey[600]),
          const SizedBox(height: 16),
          Text(
            'No schedule set',
            style: TextStyle(color: Colors.grey[400], fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            'Configure which muscle groups\nto train each day',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _showDayPicker(context, ref, null),
            icon: const Icon(Icons.add),
            label: const Text('Add Day'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC8FF00),
              foregroundColor: const Color(0xFF0F0F0F),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleList(
      BuildContext context, WidgetRef ref, WorkoutSchedule schedule) {
    final sortedDays = schedule.dayToMuscleGroups.keys.toList()..sort();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...sortedDays.map((day) => _buildDayCard(context, ref, day, schedule)),
        const SizedBox(height: 16),
        Center(
          child: TextButton.icon(
            onPressed: () => _showDayPicker(context, ref, null),
            icon: const Icon(Icons.add, color: Color(0xFFC8FF00)),
            label: const Text('Add Day',
                style: TextStyle(color: Color(0xFFC8FF00))),
          ),
        ),
      ],
    );
  }

  Widget _buildDayCard(
      BuildContext context, WidgetRef ref, int day, WorkoutSchedule schedule) {
    final groups = schedule.getMuscleGroupsForDay(day);
    final dayName = weekdayNames[day] ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  dayName.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFFC8FF00),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit, color: Color(0xFF888888), size: 20),
                  onPressed: () => _showDayPicker(context, ref, day),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Color(0xFFFF4444), size: 20),
                  onPressed: () =>
                      ref.read(workoutScheduleProvider.notifier).removeDay(day),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: groups.map((group) {
                final muscle = allMuscleGroups.firstWhere(
                  (m) => m['key'] == group,
                  orElse: () => allMuscleGroups[0],
                );
                return Chip(
                  avatar: Icon(muscle['icon'] as IconData,
                      color: muscle['color'] as Color, size: 16),
                  label: Text(muscle['label'] as String),
                  backgroundColor: (muscle['color'] as Color).withOpacity(0.15),
                  labelStyle: TextStyle(
                    color: muscle['color'] as Color,
                    fontSize: 12,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showDayPicker(BuildContext context, WidgetRef ref, int? existingDay) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => _DayPickerSheet(
        existingDay: existingDay,
        onSaved: () => Navigator.pop(ctx),
      ),
    );
  }
}

class _DayPickerSheet extends ConsumerStatefulWidget {
  final int? existingDay;
  final VoidCallback onSaved;

  const _DayPickerSheet({this.existingDay, required this.onSaved});

  @override
  ConsumerState<_DayPickerSheet> createState() => _DayPickerSheetState();
}

class _DayPickerSheetState extends ConsumerState<_DayPickerSheet> {
  int? _selectedDay;
  final Set<String> _selectedGroups = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.existingDay;
    if (_selectedDay != null) {
      final schedule = ref.read(workoutScheduleProvider);
      _selectedGroups.addAll(schedule.getMuscleGroupsForDay(_selectedDay!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.existingDay != null ? 'EDIT DAY' : 'ADD DAY',
            style: const TextStyle(
              color: Color(0xFFC8FF00),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text('DAY',
              style: TextStyle(color: Color(0xFF888888), fontSize: 12)),
          const SizedBox(height: 8),
          DropdownButton<int>(
            value: _selectedDay,
            isExpanded: true,
            dropdownColor: const Color(0xFF252525),
            hint: const Text('Select day',
                style: TextStyle(color: Color(0xFF888888))),
            underline: const SizedBox(),
            items: weekdayNames.entries
                .map((e) => DropdownMenuItem(
                      value: e.key,
                      child: Text(e.value),
                    ))
                .toList(),
            onChanged: (v) => setState(() => _selectedDay = v),
          ),
          const SizedBox(height: 16),
          const Text('MUSCLE GROUPS',
              style: TextStyle(color: Color(0xFF888888), fontSize: 12)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: allMuscleGroups.map((muscle) {
              final isSelected =
                  _selectedGroups.contains(muscle['key'] as String);
              return FilterChip(
                avatar: Icon(muscle['icon'] as IconData,
                    color: isSelected
                        ? const Color(0xFF0F0F0F)
                        : muscle['color'] as Color,
                    size: 16),
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
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedGroups.add(muscle['key'] as String);
                    } else {
                      _selectedGroups.remove(muscle['key'] as String);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: (_selectedDay != null && _selectedGroups.isNotEmpty)
                  ? () async {
                      await ref
                          .read(workoutScheduleProvider.notifier)
                          .setMuscleGroupsForDay(
                            _selectedDay!,
                            _selectedGroups.toList(),
                          );
                      widget.onSaved();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC8FF00),
                foregroundColor: const Color(0xFF0F0F0F),
                disabledBackgroundColor: const Color(0xFF252525),
                disabledForegroundColor: const Color(0xFF888888),
              ),
              child: const Text('SAVE',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
