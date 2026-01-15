class MathChallengeModel {
  int firstNumber = 0;
  int secondNumber = 0;
  String operator;
  int guess = 0;

  MathChallengeModel(this.firstNumber, this.secondNumber, this.operator);

  String get readableChallenge {
    return "$firstNumber $operator $secondNumber";
  }

  bool get solved {
    return correctAnswer == guess;
  }

  int get correctAnswer {
    switch (operator) {
      case '+':
        return firstNumber + secondNumber;
      case '-':
        return firstNumber - secondNumber;
      default:
        return 0;
    }
  }
}
