import 'package:flutter/material.dart';

/// A widget that bounces in with elastic animation
class AnimatedBounceIn extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const AnimatedBounceIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedBounceIn> createState() => _AnimatedBounceInState();
}

class _AnimatedBounceInState extends State<AnimatedBounceIn>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
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
