import 'package:flutter/material.dart';
import 'package:hot_potato/ui/core/ui/animations/animated_pulse_text.dart';
import 'package:hot_potato/ui/core/ui/animations/animated_progress_bar.dart';

class TimerView extends StatefulWidget {
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
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> with TickerProviderStateMixin {
  late AnimationController _fabAnimationController;
  late Animation<double> _fabScaleAnimation;
  late Animation<double> _fabOpacityAnimation;

  @override
  void initState() {
    super.initState();

    // FAB Animation
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fabScaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fabAnimationController, curve: Curves.easeInOut),
    );

    _fabOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fabAnimationController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(TimerView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Animate FAB when timer state changes
    if (oldWidget.isTimerRunning != widget.isTimerRunning) {
      if (widget.isTimerRunning) {
        _fabAnimationController.forward();
      } else {
        _fabAnimationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primaryContainer,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimatedBuilder(
        animation: _fabAnimationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _fabScaleAnimation.value,
            child: Opacity(
              opacity: _fabOpacityAnimation.value,
              child: widget.isTimerRunning
                  ? const SizedBox.shrink()
                  : FloatingActionButton.extended(
                      onPressed: widget.onStartCallback,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Start'),
                    ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
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
                  widget.challengeWidget,
                  const SizedBox(height: 24),
                  AnimatedPulseText(
                    child: Text(
                      widget.timeText,
                      style: theme.textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 300,
                    child: AnimatedProgressBar(
                      value: widget.progress,
                      minHeight: 8,
                      backgroundColor: Colors.white24,
                      valueColor: Colors.greenAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
