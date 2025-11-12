import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hot_potato/data/model/math_challenge_model.dart';

class MathChallengeViewModel extends ChangeNotifier {
  late MathChallengeModel _currentChallenge;

  MathChallengeViewModel() {
    // create initial challenge
    generateChallenge();
  }

  void generateChallenge() {
    const operators = ['+', '-'];
    final op = operators[Random().nextInt(operators.length)];

    late int first, second;
    first = Random().nextInt(100);
    second = Random().nextInt(100);

    _currentChallenge = MathChallengeModel(first, second, op);
    notifyListeners();
  }

  String get getMathChallenge {
    return _currentChallenge.readableChallenge;
  }

  /// Checks the user's input (string) against the correct answer.
  /// Returns true if correct, false otherwise.
  bool checkAnswer(String input) {
    final value = int.tryParse(input.trim());
    if (value == null) return false;
    final correct = _currentChallenge.correctAnswer;
    final isCorrect = value == correct;
    if (isCorrect) {
      // generate a new challenge automatically on correct answer
      generateChallenge();
    }
    notifyListeners();
    return isCorrect;
  }
}
