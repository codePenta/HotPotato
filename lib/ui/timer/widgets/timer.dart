import 'package:flutter/material.dart';
import 'package:hot_potato/ui/timer/view_model/timer_viewmodel.dart';
import 'package:provider/provider.dart'; // Import the Provider package
import 'package:hot_potato/ui/math_challenge/widgets/math_challenge.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final timerViewModel = Provider.of<TimerViewModel>(context);

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: timerViewModel.showWrongPulse
            ? Color.fromRGBO(244, 67, 54, 0.75)
            : timerViewModel.showCorrectPulse
            ? Color.fromRGBO(76, 175, 80, 0.75)
            : Colors.transparent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const MathChallengeWidget(),
              const SizedBox(height: 20),
              Text(
                timerViewModel.gameTimer.getTimeLeftReadable,
                style: const TextStyle(fontSize: 60),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 300,
                child: LinearProgressIndicator(
                  value: timerViewModel.progress,
                  minHeight: 8,
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: timerViewModel.startTimer,
        child: Icon(Icons.start),
      ),
    );
  }
}
