import 'package:flutter/material.dart';
import 'package:hot_potato/routing/route_paths.dart';
import 'package:hot_potato/ui/timer/view_model/timer_viewmodel.dart';
import 'package:provider/provider.dart';

class GameEndingWidget extends StatefulWidget {
  const GameEndingWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GameEndingWidget();
  }
}

class _GameEndingWidget extends State<GameEndingWidget>
    with TickerProviderStateMixin {
  final TextStyle headingStyle = TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    var timerViewModel = Provider.of<TimerViewModel>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Game Over!", style: headingStyle),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                timerViewModel.restartTimer();
                Navigator.of(context).pushNamed(RoutePaths.homeRoute);
              },
              child: const Text("Start new game"),
            ),
          ],
        ),
      ),
    );
  }
}
