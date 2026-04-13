import 'package:flutter/material.dart';

class TimerView extends StatelessWidget {
  final String timeText;
  final double progress;
  final Color backgroundColor;
  final Widget challengeWidget;
  final bool isTimerRunning;
  final VoidCallback onStartCallback;

  const TimerView({
    super.key,
    required this.timeText,
    required this.progress,
    required this.backgroundColor,
    required this.challengeWidget,
    required this.isTimerRunning,
    required this.onStartCallback,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primaryContainer,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isTimerRunning
          ? null
          : FloatingActionButton.extended(
              onPressed: onStartCallback,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start'),
            ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  const BoxShadow(
                    color: Color(0x29000000),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  challengeWidget,
                  const SizedBox(height: 24),
                  Text(
                    timeText,
                    style: theme.textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  _ProgressBar(progress: progress),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double progress;
  const _ProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 8,
        backgroundColor: Colors.white24,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
      ),
    );
  }
}
