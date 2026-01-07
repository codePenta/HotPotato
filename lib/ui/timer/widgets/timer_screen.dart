import 'package:flutter/material.dart';
import 'package:hot_potato/ui/ending/widgets/game_ending_widget.dart';
import 'package:hot_potato/ui/math_challenge/widgets/math_challenge_widget.dart';
import 'package:hot_potato/ui/timer/view_model/timer_viewmodel.dart';
import 'package:hot_potato/ui/timer/widgets/timer_view.dart';
import 'package:hot_potato/utils/animation_helper.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TimerViewModel>();

    if (viewModel.gameTimer.getTimeLeft.inSeconds == 0) {
      return const GameEndingWidget();
    }

    return TimerView(
      timeText: viewModel.gameTimer.getTimeLeftReadable,
      progress: viewModel.progress,
      backgroundColor: AnimationHelper.playPulse(
        viewModel.showCorrectPulse,
        viewModel.showWrongPulse,
      ),
      challengeWidget: viewModel.isSystemTimerRunning
          ? const MathChallengeWidget()
          : const SizedBox.shrink(),
      onStartCallback: viewModel.startTimer,
    );
  }
}
