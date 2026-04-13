import 'package:flutter/material.dart';

/// An animated progress bar that smoothly transitions values
class AnimatedProgressBar extends StatefulWidget {
  final double value;
  final double minHeight;
  final Color? backgroundColor;
  final Color? valueColor;

  const AnimatedProgressBar({
    super.key,
    required this.value,
    this.minHeight = 8,
    this.backgroundColor,
    this.valueColor,
  });

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.value,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _progressAnimation = Tween<double>(
        begin: _progressAnimation.value,
        end: widget.value,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        return LinearProgressIndicator(
          value: _progressAnimation.value,
          minHeight: widget.minHeight,
          backgroundColor: widget.backgroundColor ?? Colors.white24,
          valueColor: AlwaysStoppedAnimation<Color>(
            widget.valueColor ?? Colors.greenAccent,
          ),
        );
      },
    );
  }
}
