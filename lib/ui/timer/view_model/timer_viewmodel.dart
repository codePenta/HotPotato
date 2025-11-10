import 'package:flutter/material.dart';

class TimerViewmodel extends ChangeNotifier {
  Duration timeLeft;
  bool timerStarted;

  void startTimer() {
    timerStarted = true;
    notifyListeners();
  }
}
