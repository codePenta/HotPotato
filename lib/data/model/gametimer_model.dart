class GameTimer {
  Duration remainingTime;

  late Duration totalDuration;

  GameTimer(Duration timeLeft) : remainingTime = timeLeft {
    totalDuration = timeLeft;
  }

  Duration get getTimeLeft {
    return remainingTime;
  }

  set setTimeLeft(Duration timeLeft) {
    remainingTime = timeLeft;
  }

  String get getTimeLeftReadable {
    int seconds = remainingTime.inSeconds;
    int milliseconds = remainingTime.inMilliseconds % 1000;

    if (remainingTime.inSeconds <= 5) {
      return "$seconds:${milliseconds.toString().padLeft(3, '0')}";
    }

    return seconds.toString();
  }
}
