import 'package:flutter/material.dart';
import 'package:hot_potato/ui/math_challenge/view_model/math_challenge_viewmodel.dart';
import 'package:hot_potato/ui/math_challenge/widgets/math_challenge_view.dart';
import 'package:hot_potato/ui/timer/view_model/timer_viewmodel.dart';
import 'package:provider/provider.dart';

class MathChallengeScreen extends StatefulWidget {
  const MathChallengeScreen({super.key});

  @override
  State<MathChallengeScreen> createState() => _MathChallengeScreenState();
}

class _MathChallengeScreenState extends State<MathChallengeScreen> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _inputController.dispose();
  }

  void _submitAnswer(
    MathChallengeViewModel mathViewModel,
    TimerViewModel timerViewModel,
  ) {
    final suggestedSolution = _inputController.text;
    final correct = mathViewModel.checkAnswer(suggestedSolution);
    if (!correct) {
      timerViewModel.deductTime(const Duration(seconds: 3));
      timerViewModel.triggerWrongPulse();
      mathViewModel.generateChallenge();
    } else {
      timerViewModel.triggerCorrectPulse();
      timerViewModel.restartTimerAfterChallengeCompleted(correct);
      _inputController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mathViewModel = context.watch<MathChallengeViewModel>();
    final timerViewModel = context.watch<TimerViewModel>();

    return MathChallengeView(
      mathChallenge: mathViewModel.getMathChallenge,
      editingController: _inputController,
      onSubmitCallback: () => _submitAnswer(mathViewModel, timerViewModel),
    );
  }
}
