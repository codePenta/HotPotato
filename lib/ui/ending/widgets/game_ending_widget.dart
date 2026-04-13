import 'package:flutter/material.dart';
import 'package:hot_potato/routing/route_paths.dart';
import 'package:hot_potato/ui/core/ui/animations/animated_bounce_in.dart';
import 'package:hot_potato/ui/core/ui/animations/animated_slide_in_card.dart';
import 'package:hot_potato/ui/core/ui/animations/animated_pulse_button.dart';
import 'package:hot_potato/viewmodels/timer_viewmodel.dart';
import 'package:provider/provider.dart';

class GameEndingWidget extends StatefulWidget {
  const GameEndingWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GameEndingWidget();
  }
}

class _GameEndingWidget extends State<GameEndingWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timerViewModel = Provider.of<TimerViewModel>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF312244), Color(0xFF4A148C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: AnimatedBounceIn(
              child: Card(
                elevation: 14,
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
                      AnimatedSlideInCard(
                        delay: const Duration(milliseconds: 200),
                        slideOffset: const Offset(0, -0.5),
                        child: Text(
                          'Game Over!',
                          style: theme.textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AnimatedSlideInCard(
                        delay: const Duration(milliseconds: 400),
                        slideOffset: const Offset(0, -0.5),
                        child: Text(
                          'Du hast es geschafft. Möchtest du noch einmal spielen?',
                          style: theme.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),
                      AnimatedPulseButton(
                        scaleFactor: 1.08,
                        child: ElevatedButton(
                          onPressed: () {
                            timerViewModel.restartTimer();
                            Navigator.of(
                              context,
                            ).pushNamed(RoutePaths.startRoute);
                          },
                          child: const Text('Neues Spiel starten'),
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
