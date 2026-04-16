import 'package:flutter_test/flutter_test.dart';
import 'package:hot_potato/view_models/math_challenge_viewmodel.dart';

void main() {
  group('MathChallengeViewModel', () {
    late MathChallengeViewModel viewModel;

    setUp(() {
      viewModel = MathChallengeViewModel();
    });

    group('initialization', () {
      test('initializes with a challenge', () {
        expect(viewModel.currentChallenge, isNotNull);
      });

      test('getMathChallenge returns a non-empty string', () {
        expect(viewModel.getMathChallenge, isNotEmpty);
      });

      test('getMathChallenge matches readable challenge format', () {
        final challenge = viewModel.getMathChallenge;
        final parts = challenge.split(' ');
        expect(parts.length, 3);
      });
    });

    group('generateChallenge', () {
      test('replaces the current challenge', () {
        final before = viewModel.currentChallenge;
        viewModel.generateChallenge();
        // A new instance is created each time
        expect(identical(viewModel.currentChallenge, before), isFalse);
      });
    });

    group('checkAnswer', () {
      test('returns false for wrong numeric answer', () {
        final correct = viewModel.currentChallenge.correctAnswer;
        final wrong = (correct + 1).toString();
        expect(viewModel.checkAnswer(wrong), isFalse);
      });

      test('returns false for non-numeric input', () {
        expect(viewModel.checkAnswer('abc'), isFalse);
      });

      test('returns false for empty input', () {
        expect(viewModel.checkAnswer(''), isFalse);
      });

      test('returns false for whitespace-only input', () {
        expect(viewModel.checkAnswer('   '), isFalse);
      });

      test('returns true for correct answer', () {
        final correct = viewModel.currentChallenge.correctAnswer.toString();
        expect(viewModel.checkAnswer(correct), isTrue);
      });

      test('generates a new challenge after correct answer', () {
        final before = viewModel.currentChallenge;
        final correct = before.correctAnswer.toString();
        viewModel.checkAnswer(correct);
        expect(identical(viewModel.currentChallenge, before), isFalse);
      });

      test('does not generate a new challenge after wrong answer', () {
        final before = viewModel.currentChallenge;
        final wrong = (before.correctAnswer + 1).toString();
        viewModel.checkAnswer(wrong);
        // Challenge is regenerated on wrong answer too (generateChallenge is called)
        // Actually looking at the code again... for wrong answers, generateChallenge
        // is NOT called in checkAnswer itself. It returns false and the Screen calls
        // generateChallenge separately. So the challenge stays the same here.
        expect(identical(viewModel.currentChallenge, before), isTrue);
      });

      test('trims whitespace from input before parsing', () {
        final correct = '  ${viewModel.currentChallenge.correctAnswer}  ';
        expect(viewModel.checkAnswer(correct), isTrue);
      });
    });
  });
}
