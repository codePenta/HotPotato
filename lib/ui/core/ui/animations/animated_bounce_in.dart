import 'package:flutter/material.dart';

/// ANIMATIONS-GRUNDKONZEPTE:
/// Flutter-Animationen bestehen aus 3 Hauptkomponenten:
/// 1. AnimationController - Steuert die Animation (start/stop/duration)
/// 2. Tween - Definiert Start- und Endwert (z.B. 0.3 → 1.0 für Skalierung)
/// 3. Curve - Bestimmt die Beschleunigung (z.B. elasticOut für Spring-Effekt)
///
/// TickerProviderStateMixin ist nötig für AnimationController - er "tickt" 60x pro Sekunde

/// Eine Widget-Wrapper-Klasse für elastische Bounce-In Animationen.
/// Verwendet: Scale + Fade + Elastic Curve für springenden Eingangseffekt.
/// Beispiel: AnimatedBounceIn child: Text("Hello!") delay: Duration(milliseconds: 300)>
class AnimatedBounceIn extends StatefulWidget {
  /// Das Widget, das animiert werden soll (z.B. ein Button oder Text)
  final Widget child;

  /// Verzögerung vor Animationsstart (für sequentielle Animationen)
  final Duration delay;

  const AnimatedBounceIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedBounceIn> createState() => _AnimatedBounceInState();
}

/// State-Klasse mit Animation-Logik.
/// TickerProviderStateMixin ist ESSENTIEL für AnimationController!
class _AnimatedBounceInState extends State<AnimatedBounceIn>
    with TickerProviderStateMixin {
  /// AnimationController - das "Herz" jeder Flutter-Animation
  /// Dauer: 600ms, vsync: this (für 60fps Updates)
  late AnimationController _controller;

  /// Scale-Animation: Startet bei 0.3 (klein) → 1.0 (normal)
  /// Curve: elasticOut für Spring-Effekt (überschwingt und federt zurück)
  late Animation<double> _scaleAnimation;

  /// Opacity-Animation: Startet bei 0.0 (unsichtbar) → 1.0 (vollständig sichtbar)
  /// Curve: easeIn für sanftes Einblenden
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    /// 1. AnimationController erstellen
    /// duration: Wie lange die Animation läuft (600ms)
    /// vsync: this - verhindert Batterieverschwendung wenn Widget nicht sichtbar
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    /// 2. Scale-Animation definieren
    /// Tween: Startwert 0.3, Endwert 1.0
    /// animate(): Verbindet Tween mit Controller und Curve
    _scaleAnimation =
        Tween<double>(
          begin: 0.3, // Start: 30% der normalen Größe
          end: 1.0, // Ende: 100% der normalen Größe
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves
                .elasticOut, // Spring-Effekt: Überschwingt und federt zurück
          ),
        );

    /// 3. Opacity-Animation definieren
    /// Tween: Startwert 0.0, Endwert 1.0
    _opacityAnimation =
        Tween<double>(
          begin: 0.0, // Start: Komplett unsichtbar
          end: 1.0, // Ende: Volle Sichtbarkeit
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeIn, // Sanftes Einblenden
          ),
        );

    /// Animation mit optionaler Verzögerung starten
    /// Future.delayed() für sequentielle Animationen (z.B. Element 1, dann Element 2)
    /// mounted-Check verhindert Fehler wenn Widget schon disposed wurde
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward(); // .forward() startet die Animation
    });
  }

  @override
  void dispose() {
    /// WICHTIG: AnimationController immer disposen um Memory Leaks zu vermeiden!
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// AnimatedBuilder - das "Gehirn" der Animation
    /// Rebuildet das Widget bei jedem Frame (60x pro Sekunde)
    /// animation: _controller - hört auf Controller-Änderungen
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        /// Transform.scale - skaliert das Widget basierend auf _scaleAnimation.value
        /// FadeTransition - ändert Opacity basierend auf _opacityAnimation.value
        /// Kombination ergibt: Springender Scale-Effekt + sanftes Einblenden
        return Transform.scale(
          scale: _scaleAnimation.value, // Aktueller Scale-Wert (0.3 → 1.0)
          child: FadeTransition(
            opacity: _opacityAnimation, // Aktuelle Opacity (0.0 → 1.0)
            child: child, // Das ursprüngliche Widget
          ),
        );
      },

      /// child: widget.child - Performance-Optimierung
      /// Wird nicht bei jedem Frame neu gebaut, nur einmal übergeben
      child: widget.child,
    );
  }
}
