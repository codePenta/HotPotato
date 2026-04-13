import 'package:flutter/material.dart';

/// ANIMATIONS-GRUNDKONZEPTE:
/// didUpdateWidget() - Wird aufgerufen wenn Widget-Parameter sich ändern
/// Gut für: Score-Updates, Level-Wechsel, Status-Änderungen
/// Beispiel: Punktestand ändert sich von 100 → 150 mit Animation

/// Ein Widget, das bei jeder Content-Änderung animiert.
/// Verwendet: didUpdateWidget() für automatische Re-Animation.
/// Beispiel: < AnimatedContentChange child: Text("Score: $_score")>
class AnimatedContentChange extends StatefulWidget {
  /// Das Widget, das bei Änderungen animiert werden soll
  final Widget child;

  /// Wie lange die Animation dauern soll
  final Duration duration;

  /// Welche Curve für die Animation verwendet werden soll
  final Curve curve;

  const AnimatedContentChange({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.elasticOut, // Spring-Effekt für Content-Änderungen
  });

  @override
  State<AnimatedContentChange> createState() => _AnimatedContentChangeState();
}

class _AnimatedContentChangeState extends State<AnimatedContentChange>
    with TickerProviderStateMixin {
  /// Controller für Content-Change Animationen
  late AnimationController _controller;

  /// Scale-Animation für Größenänderung bei Content-Change
  late Animation<double> _scaleAnimation;

  /// Opacity-Animation für Einblenden bei Content-Change
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    /// Controller mit konfigurierbarer Dauer
    _controller = AnimationController(
      duration: widget.duration, // Verwendet widget.duration Parameter
      vsync: this,
    );

    /// Scale-Animation: Kleiner starten für "Pop"-Effekt
    _scaleAnimation =
        Tween<double>(
          begin: 0.8, // Start: 80% der Größe (kleiner)
          end: 1.0, // Ende: 100% der Größe (normal)
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: widget.curve, // Verwendet widget.curve Parameter
          ),
        );

    /// Opacity-Animation für sanftes Erscheinen
    _opacityAnimation =
        Tween<double>(
          begin: 0.0, // Start: Unsichtbar
          end: 1.0, // Ende: Sichtbar
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeIn, // Immer easeIn für Opacity
          ),
        );

    /// Initiale Animation starten
    _controller.forward();
  }

  /// WICHTIGSTE METHODE: didUpdateWidget()
  /// Wird automatisch aufgerufen wenn sich Widget-Parameter ändern!
  /// Beispiel: Text ändert sich von "Score: 100" → "Score: 150"
  @override
  void didUpdateWidget(AnimatedContentChange oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// Animation zurücksetzen und neu starten
    /// reset() setzt Controller auf 0.0
    /// forward() startet Animation von vorne
    _controller.reset(); // Zurück auf Anfang
    _controller.forward(); // Neu starten
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// AnimatedBuilder für Content-Change Updates
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        /// Scale + Fade für "Pop-in" Effekt bei Änderungen
        return Transform.scale(
          scale: _scaleAnimation.value, // Aktuelle Skalierung
          child: FadeTransition(
            opacity: _opacityAnimation, // Aktuelle Opacity
            child: child, // Das geänderte Widget
          ),
        );
      },
      child: widget.child,
    );
  }
}
