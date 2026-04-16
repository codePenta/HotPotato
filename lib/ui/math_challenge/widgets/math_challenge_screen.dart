import 'package:flutter/material.dart';
import 'package:hot_potato/view_models/math_challenge_viewmodel.dart';
import 'package:hot_potato/ui/math_challenge/widgets/math_challenge_view.dart';
import 'package:hot_potato/view_models/timer_viewmodel.dart';
import 'package:provider/provider.dart';

class MathChallengeScreen extends StatefulWidget {
  const MathChallengeScreen({super.key});

  @override
  State<MathChallengeScreen> createState() => _MathChallengeScreenState();
}

class _MathChallengeScreenState extends State<MathChallengeScreen> {
  final TextEditingController _inputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _inputController.dispose();
    _focusNode.dispose();
    super.dispose();
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
    }

    _focusNode.requestFocus();
    _inputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final mathViewModel = context.watch<MathChallengeViewModel>();
    final timerViewModel = context.watch<TimerViewModel>();

    return MathChallengeView(
      mathChallenge: mathViewModel.getMathChallenge,
      editingController: _inputController,
      focusNode: _focusNode,
      onSubmitCallback: () => _submitAnswer(mathViewModel, timerViewModel),
    );
  }
}
