import 'package:flutter/material.dart';

/// A card that slides in with a fade effect
class AnimatedSlideInCard extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Offset slideOffset;

  const AnimatedSlideInCard({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.slideOffset = const Offset(0, 0.3),
  });

  @override
  State<AnimatedSlideInCard> createState() => _AnimatedSlideInCardState();
}

class _AnimatedSlideInCardState extends State<AnimatedSlideInCard>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: widget.slideOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

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
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(opacity: _opacityAnimation, child: child),
        );
      },
      child: widget.child,
    );
  }
}
