import 'package:flutter/material.dart';
import 'package:hot_potato/ui/core/ui/animations/animated_slide_in_card.dart';
import 'package:hot_potato/ui/core/ui/animations/animated_pulse_button.dart';

class GameStartView extends StatelessWidget {
  final String greetingsText;
  final VoidCallback onStartCallback;

  const GameStartView({
    super.key,
    required this.greetingsText,
    required this.onStartCallback,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7C4DFF), Color(0xFF4A148C)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: AnimatedSlideInCard(
              child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        greetingsText,
                        style: theme.textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Bereit für eine Runde Hot Potato? Drücke Start und beginne.',
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 28),
                      AnimatedPulseButton(
                        onPressed: onStartCallback,
                        child: ElevatedButton(
                          onPressed: onStartCallback,
                          child: const Text('Start'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
