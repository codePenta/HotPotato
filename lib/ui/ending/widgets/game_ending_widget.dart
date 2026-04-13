import 'package:flutter/material.dart';
import 'package:hot_potato/routing/route_paths.dart';
import 'package:hot_potato/ui/timer/view_model/timer_viewmodel.dart';
import 'package:provider/provider.dart';

class GameEndingWidget extends StatefulWidget {
  const GameEndingWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GameEndingWidget();
  }
}

class _GameEndingWidget extends State<GameEndingWidget>
    with TickerProviderStateMixin {
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
                    Text(
                      'Game Over!',
                      style: theme.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Du hast es geschafft. Möchtest du noch einmal spielen? ',
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        timerViewModel.restartTimer();
                        Navigator.of(context).pushNamed(RoutePaths.startRoute);
                      },
                      child: const Text('Neues Spiel starten'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
