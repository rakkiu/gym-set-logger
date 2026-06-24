import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkoutSchedule {
  final Map<int, List<String>> dayToMuscleGroups;

  const WorkoutSchedule({required this.dayToMuscleGroups});

  static const empty = WorkoutSchedule(dayToMuscleGroups: {});

  List<String> getMuscleGroupsForDay(int weekday) {
    return dayToMuscleGroups[weekday] ?? [];
  }

  List<String> getTodayMuscleGroups() {
    final today = DateTime.now().weekday;
    return getMuscleGroupsForDay(today);
  }

  WorkoutSchedule copyWith({Map<int, List<String>>? dayToMuscleGroups}) {
    return WorkoutSchedule(
      dayToMuscleGroups: dayToMuscleGroups ?? this.dayToMuscleGroups,
    );
  }

  bool isEmpty() => dayToMuscleGroups.isEmpty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    dayToMuscleGroups.forEach((key, value) {
      map[key.toString()] = value;
    });
    return map;
  }

  factory WorkoutSchedule.fromJson(Map<String, dynamic> json) {
    final map = <int, List<String>>{};
    json.forEach((key, value) {
      map[int.parse(key)] = List<String>.from(value);
    });
    return WorkoutSchedule(dayToMuscleGroups: map);
  }
}

class WorkoutScheduleNotifier extends StateNotifier<WorkoutSchedule> {
  WorkoutScheduleNotifier() : super(WorkoutSchedule.empty) {
    _load();
  }

  static const _key = 'workout_schedule';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_key);
    if (json != null) {
      final map = jsonDecode(json) as Map<String, dynamic>;
      state = WorkoutSchedule.fromJson(map);
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(state.toJson()));
  }

  Future<void> setMuscleGroupsForDay(int weekday, List<String> groups) async {
    state = state.copyWith(
      dayToMuscleGroups: {...state.dayToMuscleGroups, weekday: groups},
    );
    await _save();
  }

  Future<void> removeDay(int weekday) async {
    final newMap = Map<int, List<String>>.from(state.dayToMuscleGroups);
    newMap.remove(weekday);
    state = state.copyWith(dayToMuscleGroups: newMap);
    await _save();
  }

  bool isEmpty() => state.dayToMuscleGroups.isEmpty;
}

final workoutScheduleProvider =
    StateNotifierProvider<WorkoutScheduleNotifier, WorkoutSchedule>((ref) {
  return WorkoutScheduleNotifier();
});
