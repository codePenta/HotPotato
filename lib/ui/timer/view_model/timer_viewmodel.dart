import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hot_potato/data/model/gametimer_model.dart';

class TimerViewModel extends ChangeNotifier {
  final GameTimer gameTimer = GameTimer(Duration(seconds: 30));
  bool isRunning = false;
  Timer? _timer;

  /// UI hint: when true the UI should show a wrong-answer pulse (e.g. red flash)
  bool showWrongPulse = false;

  /// UI hint: when true the UI should show a correct-answer pulse (e.g. green flash)
  bool showCorrectPulse = false;

  double get progress {
    final totalMS = gameTimer.totalDuration.inMilliseconds;
    if (totalMS <= 0) return 0.0;
    final remainingMS = gameTimer.remainingTime.inMilliseconds.clamp(
      0,
      totalMS,
    );
    return remainingMS / totalMS;
  }

  void startTimer() {
    if (isRunning) return;

    isRunning = true;
    const tick = Duration(milliseconds: 50);
    _timer = Timer.periodic(tick, (Timer timer) {
      if (gameTimer.getTimeLeft.inSeconds <= 0) {
        stopTimer();
      } else {
        gameTimer.remainingTime = gameTimer.getTimeLeft - tick;
        notifyListeners();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    isRunning = false;
    gameTimer.remainingTime = Duration.zero;
    notifyListeners();
  }

  /// Subtract [penalty] from the remaining time. If the remaining time
  /// reaches zero the timer will be stopped. Notifies listeners.
  void deductTime(Duration penalty) {
    final totalMs = gameTimer.totalDuration.inMilliseconds;
    final remainingMs =
        gameTimer.getTimeLeft.inMilliseconds - penalty.inMilliseconds;
    final newRemaining = Duration(milliseconds: remainingMs.clamp(0, totalMs));
    gameTimer.remainingTime = newRemaining;
    notifyListeners();
    if (gameTimer.getTimeLeft.inMilliseconds <= 0) {
      stopTimer();
    }
  }

  void triggerWrongPulse({
    Duration duration = const Duration(milliseconds: 350),
  }) {
    if (showWrongPulse) return;
    showWrongPulse = true;
    notifyListeners();
    Future<void>.delayed(duration, () {
      showWrongPulse = false;
      notifyListeners();
    });
  }

  void triggerCorrectPulse({
    Duration duration = const Duration(milliseconds: 350),
  }) {
    if (showCorrectPulse) return;
    showCorrectPulse = true;
    notifyListeners();
    Future<void>.delayed(duration, () {
      showCorrectPulse = false;
      notifyListeners();
    });
  }
}
