import 'package:flutter/material.dart';

class MathChallengeParser {
  Widget buildChallengeText(String challenge, ThemeData theme) {
    if (challenge.isEmpty) {
      return _buildEmptyChallengeText(theme);
    }

    final parsedChallenge = _parseChallenge(challenge);
    if (parsedChallenge != null) {
      return _buildParsedChallengeText(parsedChallenge, theme);
    }

    return _buildFallbackChallengeText(challenge, theme);
  }

  Widget _buildEmptyChallengeText(ThemeData theme) {
    return Text(
      '? + ?',
      style: theme.textTheme.displayLarge?.copyWith(
        color: theme.colorScheme.onSecondaryContainer,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildParsedChallengeText(ParsedChallenge challenge, ThemeData theme) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          _buildNumberTextSpan(challenge.firstNumber, theme),
          _buildOperatorTextSpan(challenge.operator, theme),
          _buildNumberTextSpan(challenge.secondNumber, theme),
        ],
      ),
    );
  }

  Widget _buildFallbackChallengeText(String challenge, ThemeData theme) {
    return Text(
      challenge,
      style: theme.textTheme.displayLarge?.copyWith(
        color: theme.colorScheme.onSecondaryContainer,
      ),
      textAlign: TextAlign.center,
    );
  }

  TextSpan _buildNumberTextSpan(String number, ThemeData theme) {
    return TextSpan(
      text: number,
      style: theme.textTheme.displayLarge?.copyWith(
        color: theme.colorScheme.onSecondaryContainer,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextSpan _buildOperatorTextSpan(String operator, ThemeData theme) {
    return TextSpan(
      text: ' $operator ',
      style: theme.textTheme.displayLarge?.copyWith(
        color: theme.colorScheme.onSecondaryContainer,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  ParsedChallenge? _parseChallenge(String challenge) {
    final parts = challenge.split(' ');
    if (parts.length == 3) {
      return ParsedChallenge(
        firstNumber: parts[0],
        operator: parts[1],
        secondNumber: parts[2],
      );
    }
    return null;
  }
}

class ParsedChallenge {
  final String firstNumber;
  final String operator;
  final String secondNumber;

  const ParsedChallenge({
    required this.firstNumber,
    required this.operator,
    required this.secondNumber,
  });
}
