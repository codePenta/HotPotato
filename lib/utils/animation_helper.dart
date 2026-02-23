import 'package:flutter/material.dart';

class AnimationHelper {
  static Color playPulse(bool solved) {
    if (solved) {
      return positiveColor;
    }

    return negativeColor;
  }

  static Color get positiveColor {
    return Color.fromRGBO(76, 175, 80, 0.75);
  }

  static Color get negativeColor {
    return Color.fromRGBO(244, 67, 54, 0.75);
  }
}
