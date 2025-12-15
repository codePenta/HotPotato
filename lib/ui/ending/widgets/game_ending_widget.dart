import 'package:flutter/material.dart';
import 'package:hot_potato/ui/timer/view_model/timer_viewmodel.dart';
import 'package:hot_potato/ui/timer/widgets/timer_widget.dart';
import 'package:provider/provider.dart';

class GameEndingWidget extends StatelessWidget {
  final TextStyle headingStyle = TextStyle(fontSize: 20);

  GameEndingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var timerViewModel = Provider.of<TimerViewModel>(context);
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Game Over!", style: headingStyle),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              timerViewModel.restartTimer();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => TimerWidget()),
              );
            },
            child: const Text("Start new game?"),
          ),
        ],
      ),
    );
  }
}
