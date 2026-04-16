import 'package:flutter_test/flutter_test.dart';
import 'package:hot_potato/data/model/math_challenge_model.dart';

void main() {
  group('MathChallengeModel', () {
    group('constructors', () {
      test('default constructor initializes with zeroes and + operator', () {
        final model = MathChallengeModel();
        expect(model.firstNumber, 0);
        expect(model.secondNumber, 0);
        expect(model.operator, '+');
        expect(model.guess, 0);
      });

      test('setup constructor sets provided values', () {
        final model = MathChallengeModel.setup(5, 3, '-');
        expect(model.firstNumber, 5);
        expect(model.secondNumber, 3);
        expect(model.operator, '-');
      });

      test('empty constructor initializes with zeroes', () {
        final model = MathChallengeModel.empty();
        expect(model.firstNumber, 0);
        expect(model.secondNumber, 0);
      });
    });

    group('readableChallenge', () {
      test('formats challenge as "a op b"', () {
        final model = MathChallengeModel.setup(12, 7, '+');
        expect(model.readableChallenge, '12 + 7');
      });

      test('works with subtraction operator', () {
        final model = MathChallengeModel.setup(20, 8, '-');
        expect(model.readableChallenge, '20 - 8');
      });
    });

    group('correctAnswer', () {
      test('returns sum for + operator', () {
        final model = MathChallengeModel.setup(10, 5, '+');
        expect(model.correctAnswer, 15);
      });

      test('returns difference for - operator', () {
        final model = MathChallengeModel.setup(10, 5, '-');
        expect(model.correctAnswer, 5);
      });

      test('returns negative result for - operator when second > first', () {
        final model = MathChallengeModel.setup(3, 10, '-');
        expect(model.correctAnswer, -7);
      });

      test('returns 0 for unknown operator', () {
        final model = MathChallengeModel.setup(10, 5, '*');
        expect(model.correctAnswer, 0);
      });
    });

    group('solved', () {
      test('returns true when guess matches correctAnswer', () {
        final model = MathChallengeModel.setup(4, 3, '+');
        model.guess = 7;
        expect(model.solved, isTrue);
      });

      test('returns false when guess does not match correctAnswer', () {
        final model = MathChallengeModel.setup(4, 3, '+');
        model.guess = 5;
        expect(model.solved, isFalse);
      });

      test('returns true for subtraction when correct', () {
        final model = MathChallengeModel.setup(10, 4, '-');
        model.guess = 6;
        expect(model.solved, isTrue);
      });
    });
  });
}
