import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hot_potato/data/model/gametimer_model.dart';

class TimerViewmodel extends ChangeNotifier {
  final GameTimer gameTimer = GameTimer(Duration(seconds: 30));
  bool isRunning = false;
  Timer? _timer;

  void startTimer() {
    isRunning = true;
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      if (gameTimer.getTimeLeft.inSeconds <= 0) {
        isRunning = false;
      } else {
        gameTimer.remainingTime = gameTimer.getTimeLeft - oneSecond;
        notifyListeners();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    isRunning = false;
    notifyListeners();
  }
}
