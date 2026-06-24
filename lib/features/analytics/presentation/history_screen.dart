import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymsetlogger/shared/database/database.dart';
import 'package:gymsetlogger/shared/database/database_provider.dart';
import 'package:gymsetlogger/shared/utils/date_helper.dart';

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
                return _buildSessionList(sessions);
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

  Widget _buildSessionList(List<WorkoutSession> sessions) {
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

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: monthSessions.length,
      itemBuilder: (context, index) {
        final session = monthSessions[index];
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
                  '${session.startedAt.day}',
                  style: const TextStyle(
                    color: Color(0xFFC8FF00),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            title: Text(
              _getDayName(session.startedAt.weekday),
              style: const TextStyle(
                color: Color(0xFFF0F0F0),
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${DateHelper.formatTime(session.startedAt)} - ${session.endedAt != null ? DateHelper.formatTime(session.endedAt!) : "ongoing"}',
              style: const TextStyle(color: Color(0xFF888888), fontSize: 12),
            ),
            trailing: const Icon(Icons.chevron_right, color: Color(0xFF888888)),
            onTap: () => _showSessionDetail(session),
          ),
        );
      },
    );
  }

  Future<void> _showSessionDetail(WorkoutSession session) async {
    final db = ref.read(databaseProvider);
    final sets = await db.setsForSession(session.id);
    final exercises = await db.allExercises();
    final exerciseMap = {for (final e in exercises) e.id: e};

    if (!mounted) return;

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
                      DateHelper.formatDate(session.startedAt),
                      style: const TextStyle(
                        color: Color(0xFFC8FF00),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${DateHelper.formatTime(session.startedAt)} - ${session.endedAt != null ? DateHelper.formatTime(session.endedAt!) : "?"}',
                      style: const TextStyle(color: Color(0xFF888888)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: sets.length,
                  itemBuilder: (context, index) {
                    final set = sets[index];
                    final exercise = exerciseMap[set.exerciseId];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
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
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Set ${set.setNumber}: ${set.weightKg}kg × ${set.reps}',
                                  style: const TextStyle(
                                    color: Color(0xFF888888),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (set.isPr == 1)
                            const Text('🏆',
                                style: TextStyle(fontSize: 16)),
                        ],
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
