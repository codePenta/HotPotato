import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hot_potato/data/model/gametimer_model.dart';

class TimerViewModel extends ChangeNotifier {
  final GameTimer gameTimer = GameTimer(Duration(seconds: 30));
  Timer? _timer;

  bool showWrongPulse = false;
  bool showCorrectPulse = false;

  TimerViewModel();

  void _handleTimerTick(Timer timer) {
    const tick = Duration(milliseconds: 50);

    if (gameTimer.getTimeLeft.inSeconds <= 0) {
      stopTimer();
    } else {
      gameTimer.remainingTime = gameTimer.getTimeLeft - tick;
      notifyListeners();
    }
  }

  bool get isSystemTimerRunning {
    if (_timer == null) {
      return false;
    }

    return _timer!.isActive;
  }

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
    _timer?.cancel();

    const tick = Duration(milliseconds: 50);

    _timer = Timer.periodic(tick, _handleTimerTick);
  }

  void restartTimerAfterChallengeCompleted(bool isChallengeComplete) {
    if (!isChallengeComplete) return;

    restartTimer();
    startTimer();
  }

  void restartTimer() {
    _timer?.cancel();
    gameTimer.setTimeLeft = gameTimer.totalDuration;
  }

  void stopTimer() {
    _timer?.cancel();
    gameTimer.remainingTime = Duration.zero;
    notifyListeners();
  }

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
