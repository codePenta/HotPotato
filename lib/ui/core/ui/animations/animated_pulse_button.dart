import 'package:flutter/material.dart';

/// ANIMATIONS-GRUNDKONZEPTE:
/// repeat(reverse: true) - Animation läuft endlos vor/zurück
/// Gut für: Aufmerksamkeit erregen, wichtige Buttons hervorheben
/// Beispiel: Start-Button soll "klick mich!" signalisieren

/// Ein Button-Widget mit kontinuierlicher Puls-Animation.
/// Verwendet: Endlos-Skalierung für Aufmerksamkeit.
/// Beispiel: AnimatedPulseButton child: ElevatedButton(...press me...)
class AnimatedPulseButton extends StatefulWidget {
  /// Das Widget, das gepulst werden soll (normalerweise ein Button)
  final Widget child;

  /// Callback wenn Button gedrückt wird
  final VoidCallback? onPressed;

  /// Wie stark der Puls-Effekt ist (1.0 = keine Änderung, 1.05 = 5% größer)
  final double scaleFactor;

  const AnimatedPulseButton({
    super.key,
    required this.child,
    this.onPressed,
    this.scaleFactor = 1.05, // Standard: 5% größer
  });

  @override
  State<AnimatedPulseButton> createState() => _AnimatedPulseButtonState();
}

class _AnimatedPulseButtonState extends State<AnimatedPulseButton>
    with TickerProviderStateMixin {
  /// Controller für die Puls-Animation
  late AnimationController _controller;

  /// Scale-Animation für den Puls-Effekt
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    /// AnimationController mit repeat(reverse: true)
    /// Das bedeutet: 1.0 → 1.05 → 1.0 → 1.05 → ... endlos
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500), // 1.5 Sekunden pro Puls
      vsync: this,
    )..repeat(reverse: true); // ..repeat() verkettet die Methodenaufrufe

    /// Scale-Animation: Normalgröße → scaleFactor → Normalgröße
    _scaleAnimation =
        Tween<double>(
          begin: 1.0, // Start: Normale Größe
          end: widget.scaleFactor, // Ende: scaleFactor (z.B. 1.05 = 5% größer)
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut, // Sanfte Beschleunigung/Debeschleunigung
          ),
        );
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
        /// Transform.scale für Größenänderung
        /// value ändert sich: 1.0 → 1.05 → 1.0 → 1.05 → ...
        return Transform.scale(
          scale: _scaleAnimation.value, // Aktueller Scale-Wert
          child: child, // Das ursprüngliche Widget
        );
      },
      child: widget.child,
    );
  }
}
