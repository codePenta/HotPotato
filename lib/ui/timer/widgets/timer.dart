import 'package:flutter/material.dart';
import 'package:hot_potato/ui/timer/view_model/timer_viewmodel.dart';
import 'package:provider/provider.dart'; // Import the Provider package

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final timerViewModel = Provider.of<TimerViewmodel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Gametimer")),
      body: Text(timerViewModel.gameTimer.getTimeLeftReadable),
      floatingActionButton: FloatingActionButton(
        onPressed: timerViewModel.startTimer,
        child: Icon(Icons.start),
      ),
    );
  }
}
