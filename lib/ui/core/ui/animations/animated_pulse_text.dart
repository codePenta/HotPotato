import 'package:flutter/material.dart';

/// ANIMATIONS-GRUNDKONZEPTE:
/// Wie AnimatedPulseButton, aber für Text-Widgets
/// Gut für: Wichtige Texte hervorheben, Titel animieren
/// Unterschied zu Button: Kürzere Dauer (800ms vs 1500ms)

/// Ein Text-Widget mit kontinuierlicher Puls-Animation.
/// Verwendet: Schnellere Puls-Animation für Text-Elemente.
/// Beispiel: AnimatedPulseText child: Text("WICHTIG!")
class AnimatedPulseText extends StatefulWidget {
  /// Das Text-Widget, das gepulst werden soll
  final Widget child;

  /// Wie stark der Puls-Effekt ist (1.0 = keine Änderung, 1.05 = 5% größer)
  final double scaleFactor;

  const AnimatedPulseText({
    super.key,
    required this.child,
    this.scaleFactor = 1.05, // Standard: 5% größer
  });

  @override
  State<AnimatedPulseText> createState() => _AnimatedPulseTextState();
}

class _AnimatedPulseTextState extends State<AnimatedPulseText>
    with TickerProviderStateMixin {
  /// Controller für Text-Puls (kürzer als Button-Puls)
  late AnimationController _controller;

  /// Scale-Animation für den Text-Puls
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    /// Kürzere Dauer als Button (800ms vs 1500ms)
    /// Text soll schneller pulsieren als Buttons
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800), // Schneller als Button
      vsync: this,
    )..repeat(reverse: true); // Endlos vor/zurück

    /// Scale-Animation: Normal → scaleFactor → Normal
    _scaleAnimation =
        Tween<double>(
          begin: 1.0, // Start: Normale Größe
          end: widget.scaleFactor, // Ende: scaleFactor (z.B. 1.05)
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut, // Sanfte Beschleunigung
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
    /// AnimatedBuilder für kontinuierliche Text-Updates
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        /// Transform.scale für Text-Größenänderung
        return Transform.scale(
          scale: _scaleAnimation.value, // Aktueller Scale-Wert
          child: child, // Der Text
        );
      },
      child: widget.child,
    );
  }
}
