import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymsetlogger/shared/database/database.dart';
import 'package:gymsetlogger/shared/database/database_provider.dart';
import 'package:gymsetlogger/shared/utils/date_helper.dart';

class DayGroup {
  final DateTime date;
  final List<WorkoutSession> sessions;
  final List<WorkoutSet> allSets;
  final Map<int, Exercise> exerciseMap;

  DayGroup({
    required this.date,
    required this.sessions,
    required this.allSets,
    required this.exerciseMap,
  });

  DateTime get earliestStart =>
      sessions.map((s) => s.startedAt).reduce((a, b) => a.isBefore(b) ? a : b);
  DateTime get latestEnd {
    final ended = sessions.where((s) => s.endedAt != null).map((s) => s.endedAt!);
    if (ended.isEmpty) return earliestStart;
    return ended.reduce((a, b) => a.isAfter(b) ? a : b);
  }

  int get totalSets => allSets.length;
  double get totalVolume => allSets.fold(0, (sum, s) => sum + s.weightKg * s.reps);
  bool get hasPR => allSets.any((s) => s.isPr == 1);
}

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  DateTime _selectedMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HISTORY'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          _buildCalendarHeader(),
          Expanded(
            child: StreamBuilder<List<WorkoutSession>>(
              stream: db.watchAllSessions(),
              builder: (context, snapshot) {
                final sessions = snapshot.data ?? [];
                if (sessions.isEmpty) {
                  return const Center(
                    child: Text('No workouts yet',
                        style: TextStyle(color: Color(0xFF888888))),
                  );
                }
                return _buildDayList(sessions);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF1A1A1A),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: Color(0xFFC8FF00)),
            onPressed: () {
              setState(() {
                _selectedMonth = DateTime(
                  _selectedMonth.year,
                  _selectedMonth.month - 1,
                );
              });
            },
          ),
          Text(
            DateHelper.formatMonthYear(_selectedMonth),
            style: const TextStyle(
              color: Color(0xFFF0F0F0),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: Color(0xFFC8FF00)),
            onPressed: () {
              setState(() {
                _selectedMonth = DateTime(
                  _selectedMonth.year,
                  _selectedMonth.month + 1,
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDayList(List<WorkoutSession> sessions) {
    final monthSessions = sessions.where((s) {
      return s.startedAt.year == _selectedMonth.year &&
          s.startedAt.month == _selectedMonth.month;
    }).toList();

    if (monthSessions.isEmpty) {
      return const Center(
        child: Text('No workouts this month',
            style: TextStyle(color: Color(0xFF888888))),
      );
    }

    return FutureBuilder<List<DayGroup>>(
      future: _groupSessionsByDay(monthSessions),
      builder: (context, snapshot) {
        final dayGroups = snapshot.data ?? [];
        if (dayGroups.isEmpty) {
          return const Center(
            child: Text('No workouts this month',
                style: TextStyle(color: Color(0xFF888888))),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: dayGroups.length,
          itemBuilder: (context, index) {
            final group = dayGroups[index];
            return _buildDayCard(group);
          },
        );
      },
    );
  }

  Future<List<DayGroup>> _groupSessionsByDay(List<WorkoutSession> sessions) async {
    final db = ref.read(databaseProvider);
    final exercises = await db.allExercises();
    final exerciseMap = {for (final e in exercises) e.id: e};

    final dayMap = <String, List<WorkoutSession>>{};
    for (final session in sessions) {
      final dayKey = DateHelper.formatDate(session.startedAt);
      dayMap.putIfAbsent(dayKey, () => []).add(session);
    }

    final groups = <DayGroup>[];
    for (final entry in dayMap.entries) {
      final daySessions = entry.value;
      final allSets = <WorkoutSet>[];
      for (final s in daySessions) {
        final sets = await db.setsForSession(s.id);
        allSets.addAll(sets);
      }
      allSets.sort((a, b) => a.loggedAt.compareTo(b.loggedAt));

      groups.add(DayGroup(
        date: daySessions.first.startedAt,
        sessions: daySessions,
        allSets: allSets,
        exerciseMap: exerciseMap,
      ));
    }

    groups.sort((a, b) => b.date.compareTo(a.date));
    return groups;
  }

  Widget _buildDayCard(DayGroup group) {
    final isOngoing = group.sessions.any((s) => s.endedAt == null);
    final timeRange =
        '${DateHelper.formatTime(group.earliestStart)} - ${isOngoing ? "ongoing" : DateHelper.formatTime(group.latestEnd)}';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFC8FF00).withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              '${group.date.day}',
              style: const TextStyle(
                color: Color(0xFFC8FF00),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            Text(
              _getDayName(group.date.weekday),
              style: const TextStyle(
                color: Color(0xFFF0F0F0),
                fontWeight: FontWeight.bold,
              ),
            ),
            if (group.sessions.length > 1) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: const Color(0xFF252525),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${group.sessions.length} sessions',
                  style: const TextStyle(
                    color: Color(0xFF888888),
                    fontSize: 10,
                  ),
                ),
              ),
            ],
            if (group.hasPR) ...[
              const SizedBox(width: 6),
              const Text('🏆', style: TextStyle(fontSize: 12)),
            ],
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(
              timeRange,
              style: const TextStyle(color: Color(0xFF888888), fontSize: 12),
            ),
            const SizedBox(height: 2),
            Text(
              '${group.totalSets} sets · ${group.totalVolume.toStringAsFixed(0)} kg volume',
              style: const TextStyle(color: Color(0xFF888888), fontSize: 11),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, color: Color(0xFF888888)),
        onTap: () => _showDayDetail(group),
      ),
    );
  }

  Future<void> _showDayDetail(DayGroup group) async {
    if (!mounted) return;

    final setsByExercise = <int, List<WorkoutSet>>{};
    for (final set in group.allSets) {
      setsByExercise.putIfAbsent(set.exerciseId, () => []).add(set);
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (ctx, scrollController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_getDayName(group.date.weekday)}, ${DateHelper.formatDate(group.date)}',
                      style: const TextStyle(
                        color: Color(0xFFC8FF00),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${group.totalSets} sets',
                      style: const TextStyle(color: Color(0xFF888888)),
                    ),
                  ],
                ),
              ),
              if (group.sessions.length > 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '${group.sessions.length} sessions merged',
                    style: const TextStyle(color: Color(0xFF888888), fontSize: 12),
                  ),
                ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: setsByExercise.entries.length,
                  itemBuilder: (context, index) {
                    final entry = setsByExercise.entries.elementAt(index);
                    final exercise = group.exerciseMap[entry.key];
                    final exerciseSets = entry.value;
                    final exerciseVolume = exerciseSets.fold(
                        0.0, (sum, s) => sum + s.weightKg * s.reps);

                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    exercise?.name ?? 'Unknown',
                                    style: const TextStyle(
                                      color: Color(0xFFF0F0F0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${exerciseSets.length} sets · ${exerciseVolume.toStringAsFixed(0)} kg',
                                  style: const TextStyle(
                                    color: Color(0xFF888888),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ...exerciseSets.map((set) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 32,
                                        child: Text(
                                          'S${set.setNumber}',
                                          style: const TextStyle(
                                              color: Color(0xFF888888),
                                              fontSize: 12),
                                        ),
                                      ),
                                      Text(
                                        '${set.weightKg} kg × ${set.reps}',
                                        style: const TextStyle(
                                          color: Color(0xFFF0F0F0),
                                          fontSize: 13,
                                        ),
                                      ),
                                      const Spacer(),
                                      if (set.restSeconds != null)
                                        Text(
                                          '${set.restSeconds}s rest',
                                          style: const TextStyle(
                                              color: Color(0xFF888888),
                                              fontSize: 11),
                                        ),
                                      if (set.isPr == 1) ...[
                                        const SizedBox(width: 8),
                                        const Text('🏆',
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return 'Monday';
      case 2: return 'Tuesday';
      case 3: return 'Wednesday';
      case 4: return 'Thursday';
      case 5: return 'Friday';
      case 6: return 'Saturday';
      case 7: return 'Sunday';
      default: return '';
    }
  }
}
