import 'package:flutter/material.dart';
import 'package:hot_potato/ui/ending/widgets/game_ending_widget.dart';
import 'package:hot_potato/ui/math_challenge/view_model/math_challenge_viewmodel.dart';
import 'package:hot_potato/ui/math_challenge/widgets/math_challenge_screen.dart';
import 'package:hot_potato/ui/timer/view_model/timer_viewmodel.dart';
import 'package:hot_potato/ui/timer/widgets/timer_view.dart';
import 'package:hot_potato/utils/animation_helper.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final timerViewModel = context.watch<TimerViewModel>();
    final mathViewModel = context.watch<MathChallengeViewModel>();

    if (timerViewModel.gameTimer.getTimeLeft.inSeconds == 0) {
      return const GameEndingWidget();
    }

    return TimerView(
      timeText: timerViewModel.gameTimer.getTimeLeftReadable,
      progress: timerViewModel.progress,
      backgroundColor: AnimationHelper.playPulse(
        mathViewModel.currentChallenge.solved,
      ),
      challengeWidget: timerViewModel.isSystemTimerRunning
          ? const MathChallengeScreen()
          : const SizedBox.shrink(),
      onStartCallback: timerViewModel.startTimer,
    );
  }
}
