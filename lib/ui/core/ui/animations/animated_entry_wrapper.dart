import 'package:flutter/material.dart';

class AnimatedEntryWrapper extends StatefulWidget {
  final Widget child;

  const AnimatedEntryWrapper({super.key, required this.child});

  @override
  State<AnimatedEntryWrapper> createState() {
    return _AnimatedEntryWrapperState();
  }
}

class _AnimatedEntryWrapperState extends State<AnimatedEntryWrapper>
    with TickerProviderStateMixin {
  static const Duration _offsetDuration = Duration(milliseconds: 750);
  static const Duration _opacityDuration = Duration(milliseconds: 500);

  late final AnimationController _offsetAnimationController =
      AnimationController(vsync: this, duration: _offsetDuration);

  late final AnimationController _opacityAnimationController =
      AnimationController(vsync: this, duration: _opacityDuration);

  late final Animation<Offset> _offsetAnimation =
      Tween<Offset>(begin: Offset(0, .5), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _offsetAnimationController,
          curve: Curves.easeOutCubic,
        ),
      );

  late final Animation<double> _opacityAnimation =
      Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _opacityAnimationController,
          curve: Curves.easeIn,
        ),
      );

  @override
  void initState() {
    _offsetAnimationController.forward();
    _opacityAnimationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _offsetAnimationController.dispose();
    _opacityAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(position: _offsetAnimation, child: widget.child),
    );
  }
}
