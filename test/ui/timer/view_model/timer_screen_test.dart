import 'package:flutter_test/flutter_test.dart';

import 'package:hot_potato/ui/timer/widgets/timer_screen.dart';

void main() {
  testWidgets('Timer starts with value 30', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TimerScreen());

    // Verify that our counter starts at 0.
    expect(find.text('30'), findsOneWidget);
  });
}
