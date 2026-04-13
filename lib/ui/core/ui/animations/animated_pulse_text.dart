import 'package:flutter/material.dart';

/// Text that pulses continuously
class AnimatedPulseText extends StatefulWidget {
  final Widget child;
  final double scaleFactor;

  const AnimatedPulseText({
    super.key,
    required this.child,
    this.scaleFactor = 1.05,
  });

  @override
  State<AnimatedPulseText> createState() => _AnimatedPulseTextState();
}

class _AnimatedPulseTextState extends State<AnimatedPulseText>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleFactor,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(scale: _scaleAnimation.value, child: child);
      },
      child: widget.child,
    );
  }
}
