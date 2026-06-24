import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RestTimerScreen extends StatefulWidget {
  const RestTimerScreen({super.key});

  @override
  State<RestTimerScreen> createState() => _RestTimerScreenState();
}

class _RestTimerScreenState extends State<RestTimerScreen>
    with SingleTickerProviderStateMixin {
  late int _totalSeconds;
  late int _remainingSeconds;
  Timer? _timer;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _totalSeconds = 90;
    _remainingSeconds = _totalSeconds;
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final extra = GoRouterState.of(context).extra;
    if (extra is int && extra != _totalSeconds) {
      _totalSeconds = extra;
      _remainingSeconds = _totalSeconds;
      _startTimer();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        timer.cancel();
        _showComplete();
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  void _showComplete() {
    // Could show notification here
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  Color get _timerColor {
    final progress = _remainingSeconds / _totalSeconds;
    if (progress > 0.5) {
      return Color.lerp(const Color(0xFF00E676), const Color(0xFFC8FF00),
          (progress - 0.5) * 2)!;
    } else {
      return Color.lerp(const Color(0xFFFF4444), const Color(0xFFC8FF00),
          progress * 2)!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.close, color: Color(0xFF888888)),
                onPressed: () => context.pop(),
              ),
            ),
            const Spacer(),
            Text(
              'REST',
              style: TextStyle(
                fontSize: 18,
                color: const Color(0xFF888888),
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 16),
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: child,
                );
              },
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _timerColor,
                    width: 6,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: _timerColor,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.remove,
                    label: '-30s',
                    onTap: () => setState(() {
                      _remainingSeconds = (_remainingSeconds - 30).clamp(0, 300);
                    }),
                  ),
                  _buildActionButton(
                    icon: Icons.play_arrow,
                    label: _timer?.isActive == true ? 'Pause' : 'Resume',
                    onTap: () {
                      if (_timer?.isActive == true) {
                        _timer?.cancel();
                      } else {
                        _startTimer();
                      }
                      setState(() {});
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.add,
                    label: '+30s',
                    onTap: () => setState(() {
                      _remainingSeconds = (_remainingSeconds + 30).clamp(0, 300);
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: TextButton(
                onPressed: () {
                  _timer?.cancel();
                  context.pop();
                },
                child: const Text(
                  'SKIP',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF888888),
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF252525),
            ),
            child: Icon(icon, color: const Color(0xFFF0F0F0)),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Color(0xFF888888), fontSize: 12)),
        ],
      ),
    );
  }
}
