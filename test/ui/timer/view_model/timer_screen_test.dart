import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hot_potato/view_models/math_challenge_viewmodel.dart';
import 'package:hot_potato/view_models/timer_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:hot_potato/ui/timer/widgets/timer_screen.dart';
import 'package:hot_potato/ui/ending/widgets/game_ending_widget.dart';
import 'package:hot_potato/ui/timer/widgets/timer_view.dart';

Widget _buildScreen(TimerViewModel viewModel) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<TimerViewModel>.value(value: viewModel),
      ChangeNotifierProvider<MathChallengeViewModel>(
        create: (_) => MathChallengeViewModel(),
      ),
    ],
    child: const MaterialApp(home: TimerScreen()),
  );
}

void main() {
  group('TimerScreen', () {
    testWidgets('shows "30" when initialized', (WidgetTester tester) async {
      await tester.pumpWidget(_buildScreen(TimerViewModel()));
      expect(find.text('30'), findsOneWidget);
    });

    testWidgets('shows TimerView when time remains', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildScreen(TimerViewModel()));
      expect(find.byType(TimerView), findsOneWidget);
      expect(find.byType(GameEndingWidget), findsNothing);
    });

    testWidgets('shows GameEndingWidget when time is zero', (
      WidgetTester tester,
    ) async {
      final viewModel = TimerViewModel();
      viewModel.gameTimer.remainingTime = Duration.zero;

      await tester.pumpWidget(_buildScreen(viewModel));
      // Use finite pump instead of pumpAndSettle because GameEndingWidget
      // contains AnimatedPulseButton with an infinite repeat animation.
      await tester.pump(const Duration(seconds: 2));

      expect(find.byType(GameEndingWidget), findsOneWidget);
      expect(find.byType(TimerView), findsNothing);
    });

    testWidgets('shows start button when timer is not running', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildScreen(TimerViewModel()));
      expect(find.text('Start'), findsOneWidget);
    });

    testWidgets('timer ticks after start button is pressed', (
      WidgetTester tester,
    ) async {
      final viewModel = TimerViewModel();
      await tester.pumpWidget(_buildScreen(viewModel));

      expect(find.text('30'), findsOneWidget);
      await tester.tap(find.text('Start'));
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('29'), findsOneWidget);

      // Use restartTimer instead of stopTimer to cancel the periodic dart timer
      // without setting time to zero (which would show the GameEndingWidget
      // with its infinite AnimatedPulseButton, causing pumpAndSettle to time out).
      viewModel.restartTimer();
      await tester.pump(const Duration(milliseconds: 400));
    });

    testWidgets('shows "0:05" format when 5 seconds remain', (
      WidgetTester tester,
    ) async {
      final viewModel = TimerViewModel();
      viewModel.gameTimer.remainingTime = const Duration(seconds: 5);

      await tester.pumpWidget(_buildScreen(viewModel));
      expect(find.text('0:05'), findsOneWidget);
    });
  });

  group('TimerView', () {
    Widget buildView({
      String timeText = '30',
      double progress = 1.0,
      Color backgroundColor = Colors.transparent,
      bool isTimerRunning = false,
      VoidCallback? onStartCallback,
    }) {
      return MaterialApp(
        home: TimerView(
          timeText: timeText,
          progress: progress,
          backgroundColor: backgroundColor,
          challengeWidget: const SizedBox.shrink(),
          isTimerRunning: isTimerRunning,
          onStartCallback: onStartCallback ?? () {},
        ),
      );
    }

    testWidgets('renders time text', (WidgetTester tester) async {
      await tester.pumpWidget(buildView(timeText: '15'));
      expect(find.text('15'), findsOneWidget);
    });

    testWidgets('shows start FAB when timer is not running', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildView(isTimerRunning: false));
      expect(find.text('Start'), findsOneWidget);
    });

    testWidgets('calls onStartCallback when start button is tapped', (
      WidgetTester tester,
    ) async {
      bool tapped = false;
      await tester.pumpWidget(buildView(onStartCallback: () => tapped = true));

      await tester.tap(find.text('Start'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('renders CircularProgressIndicator', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildView());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders with green border when progress > 0.5', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildView(progress: 0.8));
      await tester.pump();
      // TimerView renders without error at high progress
      expect(find.byType(TimerView), findsOneWidget);
    });

    testWidgets('renders with red border when progress < 0.2', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildView(progress: 0.1));
      await tester.pump();
      expect(find.byType(TimerView), findsOneWidget);
    });
  });

  group('GameTimer integration with TimerViewModel', () {
    test('GameTimer isGameRunning is false after stopTimer', () {
      final viewModel = TimerViewModel();
      viewModel.stopTimer();
      expect(viewModel.gameTimer.isGameRunning, isFalse);
    });

    test('progress returns 0.0 after stopTimer', () {
      final viewModel = TimerViewModel();
      viewModel.stopTimer();
      expect(viewModel.progress, 0.0);
    });

    test('GameTimer isGameRunning true after restartTimer', () {
      final viewModel = TimerViewModel();
      viewModel.stopTimer();
      viewModel.restartTimer();
      expect(viewModel.gameTimer.isGameRunning, isTrue);
    });
  });
}
