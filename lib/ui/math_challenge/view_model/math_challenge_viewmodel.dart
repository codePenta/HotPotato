import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hot_potato/data/model/math_challenge_model.dart';

class MathChallengeViewModel extends ChangeNotifier {
  late MathChallengeModel _currentChallenge;

  MathChallengeViewModel() {
    generateChallenge();
  }

  void generateChallenge() {
    const operators = ['+', '-'];
    final op = operators[Random().nextInt(operators.length)];

    late int first, second;
    first = Random().nextInt(50);
    second = Random().nextInt(50);

    _currentChallenge = MathChallengeModel(first, second, op);
    notifyListeners();
  }

  String get getMathChallenge {
    return _currentChallenge.readableChallenge;
  }

  bool checkAnswer(String input) {
    final value = int.tryParse(input.trim());
    if (value == null) return false;
    final correct = _currentChallenge.correctAnswer;
    final isCorrect = value == correct;
    if (isCorrect) {
      generateChallenge();
    }
    notifyListeners();
    return isCorrect;
  }
}
