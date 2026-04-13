import 'package:flutter/material.dart';

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

  Color _getTimerColor(double progress) {
    if (progress > 0.5) return Colors.greenAccent;
    if (progress > 0.2) return Colors.orangeAccent;
    return Colors.redAccent;
  }

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
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _getTimerColor(widget.progress).withOpacity(0.3),
                  width: 4,
                ),
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
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          return SlideTransition(
                            position:
                                Tween<Offset>(
                                  begin: const Offset(0, -1),
                                  end: Offset.zero,
                                ).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOutCubic,
                                  ),
                                ),
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                    child: widget.isTimerRunning
                        ? widget.challengeWidget
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 24),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: CircularProgressIndicator(
                          value: widget.progress,
                          strokeWidth: 7,
                          backgroundColor: Colors.white24,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getTimerColor(widget.progress),
                          ),
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                        child: Text(
                          widget.timeText,
                          key: ValueKey<String>(widget.timeText),
                          style: theme.textTheme.displayLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
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
