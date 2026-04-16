import 'package:flutter_test/flutter_test.dart';
import 'package:hot_potato/data/service/math_challenge_service.dart';

void main() {
  group('MathChallengeService', () {
    late MathChallengeService service;

    setUp(() {
      service = MathChallengeService();
    });

    test('createChallenge returns a challenge with operator + or -', () {
      for (int i = 0; i < 20; i++) {
        final challenge = service.createChallenge();
        expect(['+', '-'], contains(challenge.operator));
      }
    });

    test('createChallenge returns numbers in range [0, 49]', () {
      for (int i = 0; i < 20; i++) {
        final challenge = service.createChallenge();
        expect(challenge.firstNumber, inInclusiveRange(0, 49));
        expect(challenge.secondNumber, inInclusiveRange(0, 49));
      }
    });

    test('createChallenge returns a new instance each call', () {
      final c1 = service.createChallenge();
      final c2 = service.createChallenge();
      expect(identical(c1, c2), isFalse);
    });

    test('createChallenge returns a challenge with readable format', () {
      final challenge = service.createChallenge();
      final parts = challenge.readableChallenge.split(' ');
      expect(parts.length, 3);
      expect(int.tryParse(parts[0]), isNotNull);
      expect(['+', '-'], contains(parts[1]));
      expect(int.tryParse(parts[2]), isNotNull);
    });
  });
}
