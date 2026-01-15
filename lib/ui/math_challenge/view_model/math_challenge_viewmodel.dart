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
    final inputAsInt = _convertInputToInt(input);
    if (inputAsInt == null) return false;

    _currentChallenge.guess = inputAsInt;
    bool solved = _currentChallenge.solved;

    if (solved) {
      generateChallenge();
    }
    notifyListeners();
    return solved;
  }

  int? _convertInputToInt(String input) {
    final trimmed = input.trim();
    final value = int.tryParse(trimmed);
    return value;
  }
}
