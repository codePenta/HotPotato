class GameTimer {
  Duration _remainingTime;

  GameTimer(Duration timeLeft) : _remainingTime = timeLeft;

  Duration get getTimeLeft {
    return _remainingTime;
  }

  String get getTimeLeftReadable {
    String readableSeconds = _remainingTime.inSeconds.toString();
    String readableMilliseconds = _remainingTime.inMilliseconds.toString();

    if (_remainingTime.inSeconds <= 5) {
      return "$readableSeconds:$readableMilliseconds";
    }

    return readableSeconds;
  }

  set remainingTime(Duration time) {
    _remainingTime = time;
  }
}
