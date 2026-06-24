import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gymsetlogger/shared/database/database.dart';
import 'package:gymsetlogger/shared/database/database_provider.dart';
import 'package:gymsetlogger/shared/utils/date_helper.dart';
import 'package:gymsetlogger/shared/utils/android_storage_helper.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.read(databaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFILE'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMenuItem(
              icon: Icons.calendar_today,
              title: 'Workout Schedule',
              subtitle: 'Set which muscles to train each day',
              onTap: () => context.push('/schedule'),
            ),
            _buildMenuItem(
              icon: Icons.fitness_center,
              title: 'Exercise Library',
              subtitle: 'Browse & add custom exercises',
              onTap: () => context.push('/exercises'),
            ),
            _buildMenuItem(
              icon: Icons.monitor_weight_outlined,
              title: 'Body Weight History',
              subtitle: 'Track your weight over time',
              onTap: () => context.push('/body-weight'),
            ),
            const Divider(color: Color(0xFF252525), height: 32),
            _buildMenuItem(
              icon: Icons.file_download_outlined,
              title: 'Export XLSX',
              subtitle: 'Export workout history to Excel',
              onTap: () => _exportCSV(context, db),
            ),
            _buildMenuItem(
              icon: Icons.backup_outlined,
              title: 'Backup Database',
              subtitle: 'Export .gymlog backup file',
              onTap: () => _backupDatabase(context, db),
            ),
            _buildMenuItem(
              icon: Icons.restore_outlined,
              title: 'Restore Database',
              subtitle: 'Import from .gymlog file',
              onTap: () => _restoreDatabase(context, db),
            ),
            const Divider(color: Color(0xFF252525), height: 32),
            _buildMenuItem(
              icon: Icons.info_outline,
              title: 'About',
              subtitle: 'GymLog v1.0',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF252525),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: const Color(0xFFC8FF00), size: 20),
      ),
      title: Text(title, style: const TextStyle(color: Color(0xFFF0F0F0))),
      subtitle: Text(subtitle,
          style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
      trailing:
          const Icon(Icons.chevron_right, color: Color(0xFF888888)),
      onTap: onTap,
    );
  }

  Future<void> _exportCSV(BuildContext context, AppDatabase db) async {
    try {
      final sessions = await db.allSessions();
      final exercises = await db.allExercises();
      final exerciseMap = {for (final e in exercises) e.id: e};

      // Create Excel workbook
      final excel = Excel.createExcel();
      excel.rename(excel.getDefaultSheet()!, 'Workouts');

      // Header row
      final sheet = excel['Workouts'];
      final headers = ['Date', 'Exercise', 'Muscle Group', 'Type', 'Set', 'Weight(kg)', 'Reps', 'Est1RM', 'RestTime(s)', 'Volume', 'Is PR'];
      for (var i = 0; i < headers.length; i++) {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).value = TextCellValue(headers[i]);
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).cellStyle = CellStyle(
          bold: true,
          backgroundColorHex: ExcelColor.fromHexString('#C8FF00'),
          fontColorHex: ExcelColor.fromHexString('#0F0F0F'),
        );
      }

      // Data rows
      int rowIndex = 1;
      for (final session in sessions) {
        final sets = await db.setsForSession(session.id);
        for (final s in sets) {
          final exercise = exerciseMap[s.exerciseId];
          final est1RM = s.weightKg * (1 + s.reps / 30);
          final volume = s.weightKg * s.reps;

          final rowData = [
            DateHelper.formatDate(session.startedAt),
            exercise?.name ?? 'Unknown',
            exercise?.muscleGroup ?? '',
            exercise?.type ?? '',
            s.setNumber,
            s.weightKg,
            s.reps,
            double.parse(est1RM.toStringAsFixed(1)),
            s.restSeconds ?? '',
            volume.toStringAsFixed(0),
            s.isPr == 1 ? 'YES' : '',
          ];

          for (var i = 0; i < rowData.length; i++) {
            final value = rowData[i];
            if (value is int) {
              sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: rowIndex)).value = IntCellValue(value);
            } else if (value is double) {
              sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: rowIndex)).value = DoubleCellValue(value);
            } else {
              sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: rowIndex)).value = TextCellValue(value.toString());
            }
          }
          rowIndex++;
        }
      }

      // Save to bytes
      final fileBytes = excel.save();
      if (fileBytes == null) throw Exception('Failed to generate Excel file');

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'gymlog_$timestamp.xlsx';

      // Save to Downloads via native MediaStore API
      final savedPath = await AndroidStorageHelper.saveToDownloads(
        fileName: fileName,
        bytes: fileBytes,
        mimeType: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      );

      if (context.mounted) {
        if (savedPath != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Saved to Downloads/$fileName'),
              duration: const Duration(seconds: 3),
            ),
          );
        } else {
          final dir = await getExternalStorageDirectory();
          if (dir != null) {
            final file = File('${dir.path}/$fileName');
            await file.writeAsBytes(fileBytes);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Saved: ${file.path}'),
                duration: const Duration(seconds: 3),
              ),
            );
          } else {
            throw Exception('Cannot access storage');
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    }
  }

  Future<void> _backupDatabase(BuildContext context, AppDatabase db) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final dbFile = File('${dir.path}/gymlog/gymlog.sqlite');
      if (!await dbFile.exists()) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No database found')),
          );
        }
        return;
      }

      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Backup',
        fileName: 'gymlog_backup.gymlog',
        type: FileType.custom,
        allowedExtensions: ['gymlog'],
      );

      if (result != null) {
        await dbFile.copy(result);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Backup saved to: $result')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Backup failed: $e')),
        );
      }
    }
  }

  Future<void> _restoreDatabase(BuildContext context, AppDatabase db) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['gymlog'],
      );

      if (result != null && result.files.single.path != null) {
        final dir = await getApplicationDocumentsDirectory();
        final dbFile = File('${dir.path}/gymlog/gymlog.sqlite');
        await File(result.files.single.path!).copy(dbFile.path);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Database restored! Please restart the app.')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Restore failed: $e')),
        );
      }
    }
  }
}
