import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gymsetlogger/shared/database/database.dart';
import 'package:gymsetlogger/shared/database/database_provider.dart';
import 'package:gymsetlogger/shared/utils/date_helper.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.read(databaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GYMLOG'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildActiveWorkoutCard(context, db),
            const SizedBox(height: 16),
            _buildBodyWeightWidget(context, db),
            const SizedBox(height: 16),
            _buildRecentPRs(db),
            const SizedBox(height: 16),
            _buildWeeklyHeatmap(db),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveWorkoutCard(BuildContext context, AppDatabase db) {
    return StreamBuilder<WorkoutSession?>(
      stream: db.watchActiveSession(),
      builder: (context, snapshot) {
        final activeSession = snapshot.data;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activeSession != null ? 'ACTIVE WORKOUT' : 'START WORKOUT',
                  style: const TextStyle(
                    color: Color(0xFFC8FF00),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 12),
                if (activeSession != null) ...[
                  Text(
                    'Started ${DateHelper.formatTime(activeSession.startedAt)}',
                    style: const TextStyle(color: Color(0xFF888888)),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.push('/workout/active'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC8FF00),
                        foregroundColor: const Color(0xFF0F0F0F),
                      ),
                      child: const Text('CONTINUE'),
                    ),
                  ),
                ] else ...[
                  const Text(
                    'No workout today',
                    style: TextStyle(color: Color(0xFF888888)),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.push('/workout/active'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC8FF00),
                        foregroundColor: const Color(0xFF0F0F0F),
                      ),
                      child: const Text('START'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBodyWeightWidget(BuildContext context, AppDatabase db) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('BODY WEIGHT',
                    style: TextStyle(
                      color: Color(0xFFC8FF00),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    )),
                TextButton(
                  onPressed: () => _showLogBodyWeight(context, db),
                  child: const Text('+ LOG'),
                ),
              ],
            ),
            FutureBuilder<BodyWeightLog?>(
              future: db.latestBodyWeight(),
              builder: (context, snapshot) {
                final latest = snapshot.data;
                if (latest == null) {
                  return const Text('No weight logged yet',
                      style: TextStyle(color: Color(0xFF888888)));
                }
                return Row(
                  children: [
                    Text(
                      '${latest.weightKg} kg',
                      style: const TextStyle(
                        color: Color(0xFFF0F0F0),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateHelper.formatShort(latest.loggedAt),
                      style: const TextStyle(color: Color(0xFF888888)),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogBodyWeight(BuildContext context, AppDatabase db) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('LOG BODY WEIGHT',
                style: TextStyle(
                  color: Color(0xFFC8FF00),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              autofocus: true,
              style: const TextStyle(color: Color(0xFFF0F0F0)),
              decoration: const InputDecoration(
                hintText: 'Weight (kg)',
                hintStyle: TextStyle(color: Color(0xFF888888)),
                suffixText: 'kg',
                suffixStyle: TextStyle(color: Color(0xFF888888)),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final weight = double.tryParse(controller.text);
                  if (weight != null) {
                    await db.insertBodyWeight(
                      BodyWeightLogsCompanion.insert(
                        date: DateHelper.formatDate(DateTime.now()),
                        weightKg: weight,
                        loggedAt: DateTime.now(),
                      ),
                    );
                    if (ctx.mounted) Navigator.pop(ctx);
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
        ),
      ),
    );
  }

  Widget _buildRecentPRs(AppDatabase db) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('RECENT PRs',
                style: TextStyle(
                  color: Color(0xFFC8FF00),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                )),
            const SizedBox(height: 12),
            FutureBuilder<List<PersonalRecord>>(
              future: _getRecentPRs(db),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No PRs yet. Start lifting!',
                      style: TextStyle(color: Color(0xFF888888)));
                }
                return Column(
                  children: snapshot.data!.take(5).map((pr) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Text('🏆 ', style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 4),
                          Text(
                            '${pr.bestWeightKg}kg × ${pr.bestRepsAtWeight}',
                            style: const TextStyle(color: Color(0xFFF0F0F0)),
                          ),
                          const Spacer(),
                          Text(
                            '1RM: ${(pr.bestEstimated1rm ?? 0).toStringAsFixed(1)}',
                            style: const TextStyle(
                                color: Color(0xFF888888), fontSize: 12),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<PersonalRecord>> _getRecentPRs(AppDatabase db) async {
    final allSets = await db.allExercises();
    final prs = <PersonalRecord>[];
    for (final ex in allSets) {
      final pr = await db.getPR(ex.id);
      if (pr != null) prs.add(pr);
    }
    prs.sort((a, b) =>
        (b.achievedAt ?? DateTime(0)).compareTo(a.achievedAt ?? DateTime(0)));
    return prs;
  }

  Widget _buildWeeklyHeatmap(AppDatabase db) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('THIS WEEK',
                style: TextStyle(
                  color: Color(0xFFC8FF00),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                )),
            const SizedBox(height: 12),
            FutureBuilder<Map<String, bool>>(
              future: _getWeeklyData(db),
              builder: (context, snapshot) {
                final data = snapshot.data ?? {};
                final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: days.map((day) {
                    final trained = data[day] ?? false;
                    return Column(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: trained
                                ? const Color(0xFFC8FF00)
                                : const Color(0xFF252525),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              day[0],
                              style: TextStyle(
                                color: trained
                                    ? const Color(0xFF0F0F0F)
                                    : const Color(0xFF888888),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, bool>> _getWeeklyData(AppDatabase db) async {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final sessions = await db.sessionsInRange(
      DateHelper.startOfDay(weekStart),
      DateHelper.startOfDay(now.add(const Duration(days: 1))),
    );
    final trained = <String, bool>{};
    for (final s in sessions) {
      final day = _getDayName(s.startedAt.weekday);
      trained[day] = true;
    }
    return trained;
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return 'Mon';
      case 2: return 'Tue';
      case 3: return 'Wed';
      case 4: return 'Thu';
      case 5: return 'Fri';
      case 6: return 'Sat';
      case 7: return 'Sun';
      default: return '';
    }
  }
}
