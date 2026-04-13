import 'package:flutter/material.dart';

/// ANIMATIONS-GRUNDKONZEPTE:
/// LinearProgressIndicator mit animiertem value
/// didUpdateWidget für dynamische Wert-Änderungen
/// Gut für: Ladebalken, Fortschritt, Timer-Visualisierung

/// Eine animierte Progress-Bar mit sanften Wertübergängen.
/// Verwendet: LinearProgressIndicator mit animiertem value-Parameter.
/// Beispiel: AnimatedProgressBar value: _progress
class AnimatedProgressBar extends StatefulWidget {
  /// Der aktuelle Fortschritt (0.0 = 0%, 1.0 = 100%)
  final double value;

  /// Minimale Höhe der Progress-Bar
  final double minHeight;

  /// Hintergrundfarbe der Bar (unteil)
  final Color? backgroundColor;

  /// Farbe des Fortschrittsbereichs
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

  /// WICHTIG: didUpdateWidget für dynamische Wertänderungen
  /// Beispiel: Progress ändert sich von 0.3 → 0.7
  @override
  void didUpdateWidget(AnimatedProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// Nur animieren wenn sich der Wert tatsächlich geändert hat
    if (oldWidget.value != widget.value) {
      /// Neue Animation erstellen
      /// begin: _progressAnimation.value (aktueller animierter Wert)
      /// end: widget.value (neuer Zielwert)
      _progressAnimation =
          Tween<double>(
            begin: _progressAnimation.value, // Von aktueller Position
            end: widget.value, // Zu neuem Zielwert
          ).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOut, // Sanfte Bewegung
            ),
          );

      /// Animation von vorne starten (from: 0)
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
        /// LinearProgressIndicator mit animiertem value
        /// value ändert sich sanft von altem zu neuem Wert
        return LinearProgressIndicator(
          value: _progressAnimation.value, // Animierter Progress-Wert
          minHeight: widget.minHeight, // Höhe der Bar
          backgroundColor: widget.backgroundColor ?? Colors.white24,
          valueColor: AlwaysStoppedAnimation<Color>(
            widget.valueColor ?? Colors.greenAccent,
          ),
        );
      },
    );
  }
}
