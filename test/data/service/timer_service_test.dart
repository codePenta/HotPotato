import 'package:flutter_test/flutter_test.dart';
import 'package:hot_potato/data/service/timer_service.dart';

void main() {
  group('TimerService', () {
    late TimerService service;

    setUp(() {
      service = TimerService();
    });

    test('getTimer returns GameTimer with default 30 second duration', () {
      final timer = service.getTimer();
      expect(timer.remainingTime, const Duration(seconds: 30));
      expect(timer.totalDuration, const Duration(seconds: 30));
    });

    test('getTimer returns GameTimer with custom duration', () {
      const custom = Duration(seconds: 60);
      final timer = service.getTimer(duration: custom);
      expect(timer.remainingTime, custom);
      expect(timer.totalDuration, custom);
    });

    test('getTimer returns a new instance each call', () {
      final timer1 = service.getTimer();
      final timer2 = service.getTimer();
      expect(identical(timer1, timer2), isFalse);
    });
  });
}
