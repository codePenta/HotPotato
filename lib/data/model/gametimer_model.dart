class GameTimer {
  Duration _remainingTime;

  GameTimer(Duration timeLeft) : _remainingTime = timeLeft;

  Duration get getTimeLeft {
    return _remainingTime;
  }

  String get getTimeLeftReadable {
    int seconds = _remainingTime.inSeconds;
    int milliseconds = _remainingTime.inMilliseconds % 1000;

    if (_remainingTime.inSeconds <= 5) {
      return "$seconds:${milliseconds.toString().padLeft(3, '0')}";
    }

    return seconds.toString();
  }

  set remainingTime(Duration time) {
    _remainingTime = time;
  }
}
