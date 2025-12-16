import 'package:flutter/material.dart';
import 'package:hot_potato/ui/core/ui/animations/animated_entry_wrapper.dart';
import 'package:hot_potato/ui/math_challenge/view_model/math_challenge_viewmodel.dart';
import 'package:hot_potato/ui/timer/view_model/timer_viewmodel.dart';
import 'package:provider/provider.dart';

class MathChallengeWidget extends StatefulWidget {
  const MathChallengeWidget({super.key});

  @override
  State<MathChallengeWidget> createState() => _MathChallengeWidgetState();
}

class _MathChallengeWidgetState extends State<MathChallengeWidget>
    with TickerProviderStateMixin {
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _inputController.dispose();
  }

  void _submitAnswer(BuildContext context, MathChallengeViewModel viewModel) {
    final timerViewModel = Provider.of<TimerViewModel>(context, listen: false);
    final suggestedSolution = _inputController.text;
    final correct = viewModel.checkAnswer(suggestedSolution);
    if (!correct) {
      timerViewModel.deductTime(const Duration(seconds: 3));
      timerViewModel.triggerWrongPulse();
      viewModel.generateChallenge();
    } else {
      timerViewModel.triggerCorrectPulse();
      timerViewModel.restartTimerAfterChallengeCompleted(correct);
      _inputController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mathViewModel = Provider.of<MathChallengeViewModel>(context);

    return AnimatedEntryWrapper(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              mathViewModel.getMathChallenge,
              style: const TextStyle(fontSize: 40, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 140,
                  child: TextField(
                    controller: _inputController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Result',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                    ),
                    onSubmitted: (_) => _submitAnswer(context, mathViewModel),
                    textInputAction: TextInputAction.search,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _submitAnswer(context, mathViewModel),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
