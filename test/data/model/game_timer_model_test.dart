import 'package:flutter_test/flutter_test.dart';
import 'package:hot_potato/data/model/gametimer_model.dart';

void main() {
  group('GameTimer', () {
    test('initializes with correct remainingTime and totalDuration', () {
      final timer = GameTimer(const Duration(seconds: 30));

      expect(timer.remainingTime, const Duration(seconds: 30));
      expect(timer.totalDuration, const Duration(seconds: 30));
    });

    group('isGameRunning', () {
      test('returns true when time remains', () {
        final timer = GameTimer(const Duration(seconds: 30));
        expect(timer.isGameRunning, isTrue);
      });

      test('returns false when time is zero', () {
        final timer = GameTimer(Duration.zero);
        expect(timer.isGameRunning, isFalse);
      });

      test('returns false when remainingTime is set to zero', () {
        final timer = GameTimer(const Duration(seconds: 30));
        timer.remainingTime = Duration.zero;
        expect(timer.isGameRunning, isFalse);
      });
    });

    group('getTimeLeft', () {
      test('returns current remainingTime', () {
        final timer = GameTimer(const Duration(seconds: 15));
        expect(timer.getTimeLeft, const Duration(seconds: 15));
      });

      test('reflects updated remainingTime', () {
        final timer = GameTimer(const Duration(seconds: 30));
        timer.remainingTime = const Duration(seconds: 10);
        expect(timer.getTimeLeft, const Duration(seconds: 10));
      });
    });

    group('setTimeLeft', () {
      test('updates remainingTime', () {
        final timer = GameTimer(const Duration(seconds: 30));
        timer.setTimeLeft = const Duration(seconds: 20);
        expect(timer.remainingTime, const Duration(seconds: 20));
      });
    });

    group('getTimeLeftReadable', () {
      test('returns seconds as plain number when above 10', () {
        final timer = GameTimer(const Duration(seconds: 30));
        expect(timer.getTimeLeftReadable, '30');
      });

      test('returns minutes:seconds format when exactly 10 seconds', () {
        final timer = GameTimer(const Duration(seconds: 10));
        expect(timer.getTimeLeftReadable, '0:10');
      });

      test('returns minutes:seconds format when below 10 seconds', () {
        final timer = GameTimer(const Duration(seconds: 5));
        expect(timer.getTimeLeftReadable, '0:05');
      });

      test('pads single-digit seconds with zero', () {
        final timer = GameTimer(const Duration(seconds: 3));
        expect(timer.getTimeLeftReadable, '0:03');
      });

      test('returns 0:00 when time is zero', () {
        final timer = GameTimer(Duration.zero);
        expect(timer.getTimeLeftReadable, '0:00');
      });

      test('returns 11 without format when exactly 11 seconds', () {
        final timer = GameTimer(const Duration(seconds: 11));
        expect(timer.getTimeLeftReadable, '11');
      });
    });
  });
}
