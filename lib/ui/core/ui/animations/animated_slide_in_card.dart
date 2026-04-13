import 'package:flutter/material.dart';

/// ANIMATIONS-GRUNDKONZEPTE:
/// Offset(x, y) - Position in relativen Koordinaten
/// Offset(0, 0) = Normalposition
/// Offset(0, 0.3) = 30% unterhalb der Normalposition
/// SlideTransition - Bewegt Widget von Offset zu Offset

/// Ein Karten-Widget mit Slide-In und Fade-Animation.
/// Verwendet: SlideTransition + FadeTransition für eleganten Eingang.
/// Beispiel: AnimatedSlideInCard child: Card(...content...)
class AnimatedSlideInCard extends StatefulWidget {
  /// Das Widget, das hereingleiten soll (normalerweise eine Card)
  final Widget child;

  /// Verzögerung vor Animationsstart
  final Duration delay;

  /// Von wo das Widget hereingleitet (Offset(0, 0.3) = von 30% unten)
  final Offset slideOffset;

  const AnimatedSlideInCard({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.slideOffset = const Offset(0, 0.3), // Standard: Von 30% unten
  });

  @override
  State<AnimatedSlideInCard> createState() => _AnimatedSlideInCardState();
}

class _AnimatedSlideInCardState extends State<AnimatedSlideInCard>
    with TickerProviderStateMixin {
  /// Controller für Slide-Animation
  late AnimationController _controller;

  /// Slide-Animation: Bewegt Widget von slideOffset zur Normalposition
  late Animation<Offset> _slideAnimation;

  /// Opacity-Animation für sanftes Einblenden
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    /// Controller für 800ms Animation
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    /// Slide-Animation mit Offset-Tween
    /// begin: widget.slideOffset (z.B. Offset(0, 0.3) = 30% unterhalb)
    /// end: Offset.zero (Normalposition)
    _slideAnimation =
        Tween<Offset>(
          begin: widget.slideOffset, // Startposition (z.B. von unten)
          end: Offset.zero, // Endposition (Normalposition)
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutCubic, // Sanfte Dezeleration am Ende
          ),
        );

    /// Opacity-Animation: Unsichtbar → Sichtbar
    _opacityAnimation =
        Tween<double>(
          begin: 0.0, // Start: Unsichtbar
          end: 1.0, // Ende: Volle Sichtbarkeit
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeIn, // Sanftes Einblenden
          ),
        );

    /// Animation mit Verzögerung starten
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
    /// AnimatedBuilder für kontinuierliche Updates
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        /// SlideTransition - bewegt Widget basierend auf _slideAnimation
        /// position: _slideAnimation.value ändert sich von Offset(0, 0.3) → Offset(0, 0)
        return SlideTransition(
          position: _slideAnimation, // Aktuelle Position
          child: FadeTransition(
            opacity: _opacityAnimation, // Aktuelle Opacity
            child: child, // Das ursprüngliche Widget
          ),
        );
      },
      child: widget.child,
    );
  }
}
