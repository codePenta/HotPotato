import 'package:flutter_test/flutter_test.dart';
import 'package:hot_potato/view_models/timer_viewmodel.dart';

void main() {
  group('TimerViewModel', () {
    late TimerViewModel viewModel;

    setUp(() {
      viewModel = TimerViewModel();
    });

    tearDown(() {
      viewModel.stopTimer();
    });

    group('initialization', () {
      test('initializes with 30 seconds remaining', () {
        expect(viewModel.gameTimer.remainingTime, const Duration(seconds: 30));
      });

      test('isSystemTimerRunning is false initially', () {
        expect(viewModel.isSystemTimerRunning, isFalse);
      });

      test('progress is 1.0 initially', () {
        expect(viewModel.progress, 1.0);
      });

      test('showWrongPulse is false initially', () {
        expect(viewModel.showWrongPulse, isFalse);
      });

      test('showCorrectPulse is false initially', () {
        expect(viewModel.showCorrectPulse, isFalse);
      });
    });

    group('progress', () {
      test('returns 0.0 when totalDuration is zero', () {
        final vm = TimerViewModel();
        vm.gameTimer.remainingTime = Duration.zero;
        vm.gameTimer.totalDuration = Duration.zero;
        expect(vm.progress, 0.0);
      });

      test('returns 0.5 when half time remains', () {
        viewModel.gameTimer.remainingTime = const Duration(seconds: 15);
        expect(viewModel.progress, closeTo(0.5, 0.001));
      });

      test('clamps to 0.0 when remainingTime is negative-equivalent', () {
        viewModel.gameTimer.remainingTime = Duration.zero;
        expect(viewModel.progress, 0.0);
      });
    });

    group('startTimer', () {
      test('sets isSystemTimerRunning to true', () {
        viewModel.startTimer();
        expect(viewModel.isSystemTimerRunning, isTrue);
        viewModel.stopTimer();
      });

      test('cancels previous timer before starting new one', () {
        viewModel.startTimer();
        viewModel.startTimer();
        expect(viewModel.isSystemTimerRunning, isTrue);
        viewModel.stopTimer();
      });
    });

    group('stopTimer', () {
      test('sets isSystemTimerRunning to false', () {
        viewModel.startTimer();
        viewModel.stopTimer();
        expect(viewModel.isSystemTimerRunning, isFalse);
      });

      test('sets remainingTime to zero', () {
        viewModel.startTimer();
        viewModel.stopTimer();
        expect(viewModel.gameTimer.remainingTime, Duration.zero);
      });
    });

    group('restartTimer', () {
      test('resets remainingTime to totalDuration', () {
        viewModel.gameTimer.remainingTime = const Duration(seconds: 10);
        viewModel.restartTimer();
        expect(
          viewModel.gameTimer.remainingTime,
          viewModel.gameTimer.totalDuration,
        );
      });

      test('cancels the running timer', () {
        viewModel.startTimer();
        viewModel.restartTimer();
        expect(viewModel.isSystemTimerRunning, isFalse);
      });
    });

    group('restartTimerAfterChallengeCompleted', () {
      test('does nothing when isChallengeComplete is false', () {
        final remainingBefore = viewModel.gameTimer.remainingTime;
        viewModel.restartTimerAfterChallengeCompleted(false);
        expect(viewModel.gameTimer.remainingTime, remainingBefore);
        expect(viewModel.isSystemTimerRunning, isFalse);
      });

      test('restarts and starts timer when isChallengeComplete is true', () {
        viewModel.restartTimerAfterChallengeCompleted(true);
        expect(viewModel.isSystemTimerRunning, isTrue);
        expect(
          viewModel.gameTimer.remainingTime,
          viewModel.gameTimer.totalDuration,
        );
        viewModel.stopTimer();
      });
    });

    group('deductTime', () {
      test('reduces remainingTime by penalty', () {
        viewModel.deductTime(const Duration(seconds: 3));
        expect(
          viewModel.gameTimer.remainingTime,
          const Duration(seconds: 27),
        );
      });

      test('clamps remainingTime to zero when penalty exceeds time left', () {
        viewModel.deductTime(const Duration(seconds: 60));
        expect(viewModel.gameTimer.remainingTime, Duration.zero);
      });

      test('stops timer when time hits zero', () {
        viewModel.startTimer();
        viewModel.deductTime(const Duration(seconds: 60));
        expect(viewModel.isSystemTimerRunning, isFalse);
      });

      test('does not stop timer when time remains after deduction', () {
        viewModel.startTimer();
        viewModel.deductTime(const Duration(seconds: 3));
        expect(viewModel.isSystemTimerRunning, isTrue);
        viewModel.stopTimer();
      });
    });

    group('triggerWrongPulse', () {
      test('sets showWrongPulse to true immediately', () {
        viewModel.triggerWrongPulse(duration: const Duration(milliseconds: 50));
        expect(viewModel.showWrongPulse, isTrue);
      });

      test('resets showWrongPulse to false after duration', () async {
        viewModel.triggerWrongPulse(duration: Duration.zero);
        expect(viewModel.showWrongPulse, isTrue);
        await Future<void>.delayed(Duration.zero);
        expect(viewModel.showWrongPulse, isFalse);
      });

      test('does not re-trigger if already showing', () async {
        viewModel.triggerWrongPulse(duration: const Duration(milliseconds: 50));
        viewModel.triggerWrongPulse(duration: const Duration(milliseconds: 50));
        expect(viewModel.showWrongPulse, isTrue);
      });
    });

    group('triggerCorrectPulse', () {
      test('sets showCorrectPulse to true immediately', () {
        viewModel.triggerCorrectPulse(
          duration: const Duration(milliseconds: 50),
        );
        expect(viewModel.showCorrectPulse, isTrue);
      });

      test('resets showCorrectPulse to false after duration', () async {
        viewModel.triggerCorrectPulse(duration: Duration.zero);
        expect(viewModel.showCorrectPulse, isTrue);
        await Future<void>.delayed(Duration.zero);
        expect(viewModel.showCorrectPulse, isFalse);
      });

      test('does not re-trigger if already showing', () async {
        viewModel.triggerCorrectPulse(
          duration: const Duration(milliseconds: 50),
        );
        viewModel.triggerCorrectPulse(
          duration: const Duration(milliseconds: 50),
        );
        expect(viewModel.showCorrectPulse, isTrue);
      });
    });
  });
}
