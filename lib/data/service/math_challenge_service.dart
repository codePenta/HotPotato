import 'dart:math';
import 'package:hot_potato/data/model/math_challenge_model.dart';

class MathChallengeService {
  MathChallengeModel createChallenge() {
    const operators = ['+', '-'];
    final op = operators[Random().nextInt(operators.length)];

    late int first, second;
    first = Random().nextInt(50);
    second = Random().nextInt(50);

    final challenge = MathChallengeModel();
    challenge.firstNumber = first;
    challenge.secondNumber = second;
    challenge.operator = op;

    return challenge;
  }
}
