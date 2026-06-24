import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;
import 'package:gymsetlogger/shared/database/database.dart';
import 'package:gymsetlogger/shared/database/database_provider.dart';
import 'package:gymsetlogger/shared/utils/date_helper.dart';
import 'package:fl_chart/fl_chart.dart';

class BodyWeightScreen extends ConsumerStatefulWidget {
  const BodyWeightScreen({super.key});

  @override
  ConsumerState<BodyWeightScreen> createState() => _BodyWeightScreenState();
}

class _BodyWeightScreenState extends ConsumerState<BodyWeightScreen> {
  String _period = '30';

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BODY WEIGHT'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrentWeight(db),
            const SizedBox(height: 16),
            _buildPeriodSelector(),
            const SizedBox(height: 16),
            _buildWeightChart(db),
            const SizedBox(height: 16),
            _buildStats(db),
            const SizedBox(height: 16),
            _buildHistoryList(db),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentWeight(AppDatabase db) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('CURRENT',
                style: TextStyle(
                  color: Color(0xFFC8FF00),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                )),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FutureBuilder<BodyWeightLog?>(
                  future: db.latestBodyWeight(),
                  builder: (context, snapshot) {
                    final latest = snapshot.data;
                    return Text(
                      latest != null ? '${latest.weightKg}' : '--',
                      style: const TextStyle(
                        color: Color(0xFFF0F0F0),
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                const Text(' kg',
                    style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 18,
                    )),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () => _showLogDialog(context, db),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('LOG'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC8FF00),
                    foregroundColor: const Color(0xFF0F0F0F),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    final periods = [
      ('7', '7D'),
      ('30', '30D'),
      ('90', '3M'),
    ];
    return Row(
      children: periods.map((p) {
        final isSelected = _period == p.$1;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(p.$2),
              selected: isSelected,
              selectedColor: const Color(0xFFC8FF00),
              backgroundColor: const Color(0xFF252525),
              labelStyle: TextStyle(
                color: isSelected
                    ? const Color(0xFF0F0F0F)
                    : const Color(0xFFF0F0F0),
              ),
              onSelected: (_) => setState(() => _period = p.$1),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildWeightChart(AppDatabase db) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('WEIGHT TREND',
                style: TextStyle(
                  color: Color(0xFFC8FF00),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                )),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: _WeightChart(
                db: db,
                period: int.parse(_period),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats(AppDatabase db) {
    final now = DateTime.now();
    final start = now.subtract(Duration(days: int.parse(_period)));

    return FutureBuilder<List<BodyWeightLog>>(
      future: db.bodyWeightInRange(
        DateHelper.formatDate(start),
        DateHelper.formatDate(now),
      ),
      builder: (context, snapshot) {
        final logs = snapshot.data ?? [];
        if (logs.isEmpty) {
          return const SizedBox.shrink();
        }

        double minW = logs.first.weightKg;
        double maxW = logs.first.weightKg;
        double total = 0;
        for (final l in logs) {
          if (l.weightKg < minW) minW = l.weightKg;
          if (l.weightKg > maxW) maxW = l.weightKg;
          total += l.weightKg;
        }
        final avg = total / logs.length;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('MIN', '${minW.toStringAsFixed(1)} kg'),
                _buildStatItem('AVG', '${avg.toStringAsFixed(1)} kg'),
                _buildStatItem('MAX', '${maxW.toStringAsFixed(1)} kg'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
              color: Color(0xFFF0F0F0),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }

  Widget _buildHistoryList(AppDatabase db) {
    return StreamBuilder<List<BodyWeightLog>>(
      stream: db.watchBodyWeightLogs(),
      builder: (context, snapshot) {
        final logs = snapshot.data ?? [];
        if (logs.isEmpty) {
          return const Center(
            child: Text('No weight logs yet',
                style: TextStyle(color: Color(0xFF888888))),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('HISTORY',
                style: TextStyle(
                  color: Color(0xFFC8FF00),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                )),
            const SizedBox(height: 8),
            ...logs.take(10).map((l) => Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    title: Text('${l.weightKg} kg',
                        style: const TextStyle(color: Color(0xFFF0F0F0))),
                    subtitle: Text(l.note ?? '',
                        style: const TextStyle(
                            color: Color(0xFF888888), fontSize: 12)),
                    trailing: Text(DateHelper.formatShort(l.loggedAt),
                        style: const TextStyle(
                            color: Color(0xFF888888), fontSize: 12)),
                  ),
                )),
          ],
        );
      },
    );
  }

  void _showLogDialog(BuildContext context, AppDatabase db) {
    final controller = TextEditingController();
    final noteController = TextEditingController();
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('LOG WEIGHT',
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
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: noteController,
              style: const TextStyle(color: Color(0xFFF0F0F0)),
              decoration: const InputDecoration(
                hintText: 'Note (optional)',
                hintStyle: TextStyle(color: Color(0xFF888888)),
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
                        note: noteController.text.isNotEmpty
                            ? Value(noteController.text)
                            : const Value.absent(),
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
}

class _WeightChart extends ConsumerWidget {
  final AppDatabase db;
  final int period;

  const _WeightChart({required this.db, required this.period});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final start = now.subtract(Duration(days: period));

    return FutureBuilder<List<BodyWeightLog>>(
      future: db.bodyWeightInRange(
        DateHelper.formatDate(start),
        DateHelper.formatDate(now),
      ),
      builder: (context, snapshot) {
        final logs = snapshot.data ?? [];
        if (logs.isEmpty) {
          return const Center(
            child: Text('No data for this period',
                style: TextStyle(color: Color(0xFF888888))),
          );
        }

        final spots = logs.asMap().entries.map((e) {
          return FlSpot(e.key.toDouble(), e.value.weightKg);
        }).toList();

        return LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) => FlLine(
                color: const Color(0xFF252525),
                strokeWidth: 1,
              ),
            ),
            titlesData: FlTitlesData(
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${value.toStringAsFixed(1)}',
                      style: const TextStyle(
                          color: Color(0xFF888888), fontSize: 10),
                    );
                  },
                ),
              ),
              bottomTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: const Color(0xFF00E676),
                barWidth: 2,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, bar, index) {
                    return FlDotCirclePainter(
                      radius: 3,
                      color: const Color(0xFF00E676),
                    );
                  },
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: const Color(0xFF00E676).withOpacity(0.1),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
