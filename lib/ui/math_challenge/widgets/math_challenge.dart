import 'package:flutter/material.dart';
import 'package:hot_potato/ui/math_challenge/view_model/math_challenge_viewmodel.dart';
import 'package:hot_potato/ui/timer/view_model/timer_viewmodel.dart';
import 'package:provider/provider.dart';

class MathChallengeWidget extends StatefulWidget {
  const MathChallengeWidget({super.key});

  @override
  State<MathChallengeWidget> createState() => _MathChallengeWidgetState();
}

class _MathChallengeWidgetState extends State<MathChallengeWidget> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _submitAnswer(BuildContext context) {
    final challengeViewModel = Provider.of<MathChallengeViewModel>(
      context,
      listen: false,
    );
    final timerViewModel = Provider.of<TimerViewModel>(context, listen: false);
    final suggestedSolution = _inputController.text;
    final correct = challengeViewModel.checkAnswer(suggestedSolution);
    if (!correct) {
      timerViewModel.deductTime(const Duration(seconds: 3));
      timerViewModel.triggerWrongPulse();
      challengeViewModel.generateChallenge();
    } else {
      timerViewModel.triggerCorrectPulse();
      _inputController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mathViewModel = Provider.of<MathChallengeViewModel>(context);

    return Padding(
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
                  onSubmitted: (_) => _submitAnswer(context),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _submitAnswer(context),
                child: const Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
