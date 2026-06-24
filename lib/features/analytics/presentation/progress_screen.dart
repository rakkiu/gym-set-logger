import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymsetlogger/shared/database/database.dart';
import 'package:gymsetlogger/shared/database/database_provider.dart';
import 'package:gymsetlogger/shared/utils/one_rm_calculator.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressScreen extends ConsumerStatefulWidget {
  const ProgressScreen({super.key});

  @override
  ConsumerState<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends ConsumerState<ProgressScreen> {
  int? _selectedExerciseId;

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PROGRESS'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExerciseSelector(db),
            const SizedBox(height: 16),
            if (_selectedExerciseId != null) ...[
              _build1RMChart(db),
              const SizedBox(height: 16),
              _buildVolumeChart(db),
              const SizedBox(height: 16),
              _buildStatsCard(db),
            ] else ...[
              _buildOverallStats(db),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseSelector(AppDatabase db) {
    return FutureBuilder<List<Exercise>>(
      future: db.allExercises(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        final exercises = snapshot.data!;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<int>(
            value: _selectedExerciseId,
            hint: const Text('All Exercises',
                style: TextStyle(color: Color(0xFF888888))),
            dropdownColor: const Color(0xFF252525),
            isExpanded: true,
            underline: const SizedBox(),
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text('All Exercises',
                    style: TextStyle(color: Color(0xFF888888))),
              ),
              ...exercises.map((e) => DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name,
                        style: const TextStyle(color: Color(0xFFF0F0F0))),
                  )),
            ],
            onChanged: (value) => setState(() => _selectedExerciseId = value),
          ),
        );
      },
    );
  }

  Widget _build1RMChart(AppDatabase db) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ESTIMATED 1RM',
                style: TextStyle(
                  color: Color(0xFFC8FF00),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                )),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: StreamBuilder<List<WorkoutSet>>(
                stream: db.watchSetsForExercise(_selectedExerciseId!),
                builder: (context, snapshot) {
                  final sets = snapshot.data ?? [];
                  if (sets.isEmpty) {
                    return const Center(
                      child: Text('No data yet',
                          style: TextStyle(color: Color(0xFF888888))),
                    );
                  }
                  final spots = sets.reversed.map((s) {
                    final est1RM = OneRMCalculator.estimate1RM(s.weightKg, s.reps);
                    return FlSpot(
                      s.loggedAt.millisecondsSinceEpoch.toDouble(),
                      est1RM,
                    );
                  }).toList();

                  return LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: _getInterval(spots),
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: const Color(0xFF252525),
                          strokeWidth: 1,
                        ),
                      ),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                '${value.toInt()}',
                                style: const TextStyle(
                                    color: Color(0xFF888888), fontSize: 10),
                              );
                            },
                          ),
                        ),
                        bottomTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          color: const Color(0xFFC8FF00),
                          barWidth: 2,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, bar, index) {
                              return FlDotCirclePainter(
                                radius: 3,
                                color: const Color(0xFFC8FF00),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVolumeChart(AppDatabase db) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('VOLUME PER SESSION',
                style: TextStyle(
                  color: Color(0xFFC8FF00),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                )),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: StreamBuilder<List<WorkoutSet>>(
                stream: db.watchSetsForExercise(_selectedExerciseId!),
                builder: (context, snapshot) {
                  final sets = snapshot.data ?? [];
                  if (sets.isEmpty) {
                    return const Center(
                      child: Text('No data yet',
                          style: TextStyle(color: Color(0xFF888888))),
                    );
                  }

                  final sessionVolumes = <int, double>{};
                  for (final s in sets) {
                    final sid = s.sessionId;
                    sessionVolumes[sid] = (sessionVolumes[sid] ?? 0) + s.weightKg * s.reps;
                  }

                  final spots = sessionVolumes.entries.toList().asMap().entries.map(
                    (e) => FlSpot(e.key.toDouble(), e.value.value),
                  ).toList();

                  return BarChart(
                    BarChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: const Color(0xFF252525),
                          strokeWidth: 1,
                        ),
                      ),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 50,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                '${(value / 1000).toStringAsFixed(1)}k',
                                style: const TextStyle(
                                    color: Color(0xFF888888), fontSize: 10),
                              );
                            },
                          ),
                        ),
                        bottomTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: spots.map((spot) {
                        return BarChartGroupData(
                          x: spot.x.toInt(),
                          barRods: [
                            BarChartRodData(
                              toY: spot.y,
                              color: const Color(0xFFC8FF00),
                              width: 12,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(4)),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(AppDatabase db) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<WorkoutSet>>(
          future: db.setsForExercise(_selectedExerciseId!),
          builder: (context, snapshot) {
            final sets = snapshot.data ?? [];
            if (sets.isEmpty) {
              return const Center(
                child: Text('No stats yet',
                    style: TextStyle(color: Color(0xFF888888))),
              );
            }

            double bestWeight = 0;
            double best1RM = 0;
            double bestVolume = 0;
            for (final s in sets) {
              if (s.weightKg > bestWeight) bestWeight = s.weightKg;
              final est = OneRMCalculator.estimate1RM(s.weightKg, s.reps);
              if (est > best1RM) best1RM = est;
              final vol = s.weightKg * s.reps;
              if (vol > bestVolume) bestVolume = vol;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('STATS',
                    style: TextStyle(
                      color: Color(0xFFC8FF00),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    )),
                const SizedBox(height: 12),
                _buildStatRow('Best Set', '$bestWeight kg'),
                _buildStatRow('Est. 1RM', '${best1RM.toStringAsFixed(1)} kg'),
                _buildStatRow('Best Volume/Set', '${bestVolume.toStringAsFixed(0)} kg'),
                _buildStatRow('Total Sets', '${sets.length}'),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF888888))),
          Text(value,
              style: const TextStyle(
                color: Color(0xFFF0F0F0),
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }

  Widget _buildOverallStats(AppDatabase db) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('OVERALL',
                    style: TextStyle(
                      color: Color(0xFFC8FF00),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    )),
                const SizedBox(height: 12),
                FutureBuilder<int>(
                  future: db.totalWorkouts(),
                  builder: (context, snapshot) {
                    return _buildStatRow('Total Workouts', '${snapshot.data ?? 0}');
                  },
                ),
                FutureBuilder<double>(
                  future: db.totalVolumeAllTime(),
                  builder: (context, snapshot) {
                    final vol = snapshot.data ?? 0;
                    return _buildStatRow(
                        'Total Volume', '${(vol / 1000).toStringAsFixed(1)}k kg');
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  double _getInterval(List<FlSpot> spots) {
    if (spots.isEmpty) return 10;
    double maxVal = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
    double minVal = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b);
    double range = maxVal - minVal;
    if (range <= 0) return 10;
    return (range / 4).ceilToDouble();
  }
}
