import 'package:hot_potato/data/model/gametimer_model.dart';

class TimerService {
  GameTimer getTimer({Duration duration = const Duration(seconds: 30)}) {
    GameTimer gameTimer = GameTimer(duration);
    return gameTimer;
  }
}
