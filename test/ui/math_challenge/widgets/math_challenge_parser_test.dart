import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hot_potato/ui/math_challenge/widgets/math_challenge_parser.dart';

Widget _buildInApp(Widget child) {
  return MaterialApp(home: Scaffold(body: child));
}

void main() {
  group('MathChallengeParser', () {
    late MathChallengeParser parser;
    late ThemeData theme;

    setUp(() {
      parser = MathChallengeParser();
      theme = ThemeData.light();
    });

    testWidgets('buildChallengeText returns "? + ?" for empty input', (
      WidgetTester tester,
    ) async {
      final widget = parser.buildChallengeText('', theme);
      await tester.pumpWidget(_buildInApp(widget));
      expect(find.text('? + ?'), findsOneWidget);
    });

    testWidgets('buildChallengeText renders RichText for valid "a op b" format', (
      WidgetTester tester,
    ) async {
      final widget = parser.buildChallengeText('12 + 7', theme);
      await tester.pumpWidget(_buildInApp(widget));
      expect(find.byType(RichText), findsAtLeastNWidgets(1));
    });

    testWidgets('buildChallengeText renders fallback Text for unparseable input', (
      WidgetTester tester,
    ) async {
      final widget = parser.buildChallengeText('invalid', theme);
      await tester.pumpWidget(_buildInApp(widget));
      expect(find.text('invalid'), findsOneWidget);
    });

    testWidgets('buildChallengeText renders fallback Text for two-part input', (
      WidgetTester tester,
    ) async {
      final widget = parser.buildChallengeText('12 +', theme);
      await tester.pumpWidget(_buildInApp(widget));
      expect(find.text('12 +'), findsOneWidget);
    });
  });

  group('ParsedChallenge', () {
    test('stores firstNumber, operator, and secondNumber', () {
      const parsed = ParsedChallenge(
        firstNumber: '10',
        operator: '-',
        secondNumber: '4',
      );
      expect(parsed.firstNumber, '10');
      expect(parsed.operator, '-');
      expect(parsed.secondNumber, '4');
    });
  });
}
