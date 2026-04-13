class GameTimer {
  Duration remainingTime;

  late Duration totalDuration;

  GameTimer(Duration timeLeft) : remainingTime = timeLeft {
    totalDuration = timeLeft;
  }

  bool get isGameRunning {
    return remainingTime.inMilliseconds > 0;
  }

  Duration get getTimeLeft {
    return remainingTime;
  }

  set setTimeLeft(Duration timeLeft) {
    remainingTime = timeLeft;
  }

  String get getTimeLeftReadable {
    int totalSeconds = remainingTime.inSeconds;

    if (totalSeconds <= 10) {
      int minutes = totalSeconds ~/ 60;
      int seconds = totalSeconds % 60;
      return "$minutes:${seconds.toString().padLeft(2, '0')}";
    }

    return totalSeconds.toString();
  }
}
