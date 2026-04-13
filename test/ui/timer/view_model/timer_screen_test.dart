import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hot_potato/viewmodels/timer_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:hot_potato/ui/timer/widgets/timer_screen.dart';

void main() {
  testWidgets('Timer is initialized with value 30', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<TimerViewModel>(
        create: (_) => TimerViewModel(),
        child: const MaterialApp(home: TimerScreen()),
      ),
    );

    expect(find.text('30'), findsOneWidget);
  });

  testWidgets('Timer runs until the end', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<TimerViewModel>(
        create: (_) => TimerViewModel(),
        child: const MaterialApp(home: TimerScreen()),
      ),
    );

    expect(find.text('30'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.start));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('29'), findsOneWidget);
  });
}
