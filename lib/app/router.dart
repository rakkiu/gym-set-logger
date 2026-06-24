import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymsetlogger/features/workout/presentation/workout_screen.dart';
import 'package:gymsetlogger/features/workout/presentation/active_workout_screen.dart';
import 'package:gymsetlogger/features/workout/presentation/rest_timer_screen.dart';
import 'package:gymsetlogger/features/workout/presentation/schedule_screen.dart';
import 'package:gymsetlogger/features/exercise_library/presentation/exercise_library_screen.dart';
import 'package:gymsetlogger/features/body_weight/presentation/body_weight_screen.dart';
import 'package:gymsetlogger/features/analytics/presentation/progress_screen.dart';
import 'package:gymsetlogger/features/analytics/presentation/history_screen.dart';
import 'package:gymsetlogger/features/analytics/presentation/profile_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => ScaffoldWithNav(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/history',
            builder: (context, state) => const HistoryScreen(),
          ),
          GoRoute(
            path: '/progress',
            builder: (context, state) => const ProgressScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/workout/active',
        builder: (context, state) => const ActiveWorkoutScreen(),
      ),
      GoRoute(
        path: '/rest-timer',
        builder: (context, state) => const RestTimerScreen(),
      ),
      GoRoute(
        path: '/exercises',
        builder: (context, state) => const ExerciseLibraryScreen(),
      ),
      GoRoute(
        path: '/body-weight',
        builder: (context, state) => const BodyWeightScreen(),
      ),
      GoRoute(
        path: '/schedule',
        builder: (context, state) => const ScheduleScreen(),
      ),
    ],
  );
});

class ScaffoldWithNav extends StatelessWidget {
  final Widget child;
  const ScaffoldWithNav({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex(context),
        onTap: (index) => _onTap(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/workout/active'),
        child: const Icon(Icons.add, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location == '/') return 0;
    if (location == '/history') return 1;
    if (location == '/progress') return 2;
    if (location == '/profile') return 3;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/history');
        break;
      case 2:
        context.go('/progress');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }
}
