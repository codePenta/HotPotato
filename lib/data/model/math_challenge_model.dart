class MathChallengeModel {
  int _firstNumber;
  int _secondNumber;
  String _operator;

  MathChallengeModel(int firstNumber, int secondNumber, String operator)
    : _firstNumber = firstNumber,
      _secondNumber = secondNumber,
      _operator = operator;

  String get readableChallenge {
    return "$_firstNumber $operator $secondNumber";
  }

  int get firstNumber {
    return _firstNumber;
  }

  set firstNumber(int firstNumber) {
    _firstNumber = firstNumber;
  }

  int get secondNumber {
    return _secondNumber;
  }

  set secondNumber(int secondNumber) {
    _secondNumber = secondNumber;
  }

  String get operator {
    return _operator;
  }

  set operator(String operator) {
    _operator = operator;
  }

  /// Compute the expected integer answer for this challenge.
  /// For division ('÷') performs integer division using ~/ and avoids division by zero.
  int get correctAnswer {
    switch (_operator) {
      case '+':
        return _firstNumber + _secondNumber;
      case '-':
        return _firstNumber - _secondNumber;
      case '×':
        return _firstNumber * _secondNumber;
      case '÷':
        return _firstNumber ~/ _secondNumber;
      default:
        return 0;
    }
  }
}
