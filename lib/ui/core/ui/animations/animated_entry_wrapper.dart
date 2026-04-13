import 'package:flutter/material.dart';

/// ANIMATIONS-GRUNDKONZEPTE:
/// Mehrere AnimationController für komplexe Animationen
/// Unterschiedliche Dauern für verschiedene Effekte
/// Gut für: Komplexe Entrance-Animationen mit mehreren Phasen

/// Ein Wrapper-Widget mit kombinierter Slide + Fade Animation.
/// Verwendet: Zwei separate Controller für unterschiedliche Timing.
/// Beispiel: AnimatedEntryWrapper child: Container(...content...)
class AnimatedEntryWrapper extends StatefulWidget {
  /// Das Widget, das hereingleiten und einblenden soll
  final Widget child;

  const AnimatedEntryWrapper({super.key, required this.child});

  @override
  State<AnimatedEntryWrapper> createState() {
    return _AnimatedEntryWrapperState();
  }
}

class _AnimatedEntryWrapperState extends State<AnimatedEntryWrapper>
    with TickerProviderStateMixin {
  /// Slide-Animation dauert länger (750ms) als Opacity (500ms)
  /// Das erzeugt einen "Slide-first, then fade-in" Effekt
  static const Duration _offsetDuration = Duration(milliseconds: 750);
  static const Duration _opacityDuration = Duration(milliseconds: 500);

  /// Erster Controller für Slide-Bewegung (länger)
  late final AnimationController _offsetAnimationController =
      AnimationController(vsync: this, duration: _offsetDuration);

  /// Zweiter Controller für Opacity (kürzer)
  /// Zwei Controller erlauben unterschiedliche Timing!
  late final AnimationController _opacityAnimationController =
      AnimationController(vsync: this, duration: _opacityDuration);

  /// Slide-Animation: Von 50% unten zur Normalposition
  late final Animation<Offset> _offsetAnimation =
      Tween<Offset>(
        begin: Offset(0, .5), // Start: 50% unterhalb der Normalposition
        end: Offset.zero, // Ende: Normalposition
      ).animate(
        CurvedAnimation(
          parent: _offsetAnimationController,
          curve: Curves.easeOutCubic, // Sanfte Dezeleration
        ),
      );

  /// Opacity-Animation: Unsichtbar → Sichtbar
  late final Animation<double> _opacityAnimation =
      Tween<double>(
        begin: 0, // Start: Komplett unsichtbar
        end: 1, // Ende: Volle Sichtbarkeit
      ).animate(
        CurvedAnimation(
          parent: _opacityAnimationController,
          curve: Curves.easeIn, // Sanftes Einblenden
        ),
      );

  @override
  void initState() {
    /// Beide Animationen gleichzeitig starten
    /// Slide dauert 750ms, Opacity nur 500ms
    /// Ergebnis: Widget gleitet herein UND blendet ein
    _offsetAnimationController.forward(); // Slide starten
    _opacityAnimationController.forward(); // Fade starten

    super.initState();
  }

  @override
  void dispose() {
    /// Beide Controller disposen (wichtig!)
    _offsetAnimationController.dispose();
    _opacityAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Kombination von SlideTransition und FadeTransition
    /// SlideTransition bewegt Widget, FadeTransition ändert Sichtbarkeit
    return FadeTransition(
      opacity: _opacityAnimation, // Opacity-Animation (500ms)
      child: SlideTransition(
        position: _offsetAnimation, // Position-Animation (750ms)
        child: widget.child, // Das ursprüngliche Widget
      ),
    );
  }
}
