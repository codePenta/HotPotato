import 'package:flutter/material.dart';

class TimerView extends StatelessWidget {
  final String timeText;
  final double progress;
  final Color backgroundColor;
  final Widget challengeWidget;
  final VoidCallback onStartCallback;

  const TimerView({
    super.key,
    required this.timeText,
    required this.progress,
    required this.backgroundColor,
    required this.challengeWidget,
    required this.onStartCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: backgroundColor,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              challengeWidget,
              const SizedBox(height: 20),
              Text(timeText, style: const TextStyle(fontSize: 60)),
              const SizedBox(height: 12),
              _ProgressBar(progress: progress),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: onStartCallback,
        child: const Icon(Icons.start),
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
