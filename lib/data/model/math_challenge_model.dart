class MathChallengeModel {
  final int firstNumber;
  final int secondNumber;
  final String operator;

  MathChallengeModel(this.firstNumber, this.secondNumber, this.operator);

  String get readableChallenge {
    return "$firstNumber $operator $secondNumber";
  }

  /// Compute the expected integer answer for this challenge.
  /// For division ('÷') performs integer division using ~/ and avoids division by zero.
  int get correctAnswer {
    switch (operator) {
      case '+':
        return firstNumber + secondNumber;
      case '-':
        return firstNumber - secondNumber;
      case '×':
        return firstNumber * secondNumber;
      case '÷':
        return firstNumber ~/ secondNumber;
      default:
        return 0;
    }
  }
}
