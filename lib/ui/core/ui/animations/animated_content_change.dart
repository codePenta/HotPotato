import 'package:flutter/material.dart';

/// A widget that animates when its content changes
class AnimatedContentChange extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const AnimatedContentChange({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.elasticOut,
  });

  @override
  State<AnimatedContentChange> createState() => _AnimatedContentChangeState();
}

class _AnimatedContentChangeState extends State<AnimatedContentChange>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedContentChange oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.reset();
    _controller.forward();
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
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: FadeTransition(opacity: _opacityAnimation, child: child),
        );
      },
      child: widget.child,
    );
  }
}
