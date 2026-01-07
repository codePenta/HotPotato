import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hot_potato/ui/ending/widgets/game_ending_widget.dart';
import 'package:hot_potato/ui/timer/view_model/timer_viewmodel.dart';
import 'package:hot_potato/utils/animation_helper.dart';
import 'package:provider/provider.dart';
import 'package:hot_potato/ui/math_challenge/widgets/math_challenge_widget.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidget();
}

class _TimerWidget extends State<TimerWidget> {
  @override
  void initState() {
    super.initState();

    log("Created Timer Widget");
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TimerViewModel>(context);

    return viewModel.gameTimer.getTimeLeft.inSeconds == 0
        ? GameEndingWidget()
        : Scaffold(
            body: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: AnimationHelper.playPulse(
                viewModel.showCorrectPulse,
                viewModel.showWrongPulse,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ?viewModel.isSystemTimerRunning
                        ? const MathChallengeWidget()
                        : null,
                    const SizedBox(height: 20),
                    Text(
                      viewModel.gameTimer.getTimeLeftReadable,
                      style: const TextStyle(fontSize: 60),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: 300,
                      child: LinearProgressIndicator(
                        value: viewModel.progress,
                        minHeight: 8,
                        backgroundColor: Colors.white24,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.greenAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: viewModel.startTimer,
              child: Icon(Icons.start),
            ),
          );
  }
}
