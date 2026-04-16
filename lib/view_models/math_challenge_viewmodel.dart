import 'package:flutter/material.dart';
import 'package:hot_potato/data/model/math_challenge_model.dart';
import 'package:hot_potato/data/service/math_challenge_service.dart';

class MathChallengeViewModel extends ChangeNotifier {
  late MathChallengeModel _currentChallenge;
  final MathChallengeService _service = MathChallengeService();

  MathChallengeModel get currentChallenge => _currentChallenge;

  MathChallengeViewModel() {
    _currentChallenge = _service.createChallenge();
  }

  void generateChallenge() {
    _currentChallenge = _service.createChallenge();
    notifyListeners();
  }

  String get getMathChallenge {
    return currentChallenge.readableChallenge;
  }

  bool checkAnswer(String input) {
    final inputAsInt = _convertInputToInt(input);
    if (inputAsInt == null) return false;

    currentChallenge.guess = inputAsInt;
    bool solved = currentChallenge.solved;

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
