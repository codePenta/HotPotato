import 'package:flutter/material.dart';

class AnimationHelper {
  static Color playPulse(bool goodCondition, bool badCondition) {
    if (goodCondition) {
      return positiveColor;
    } else if (badCondition) {
      return negativeColor;
    }

    return Colors.transparent;
  }

  static Color get positiveColor {
    return Color.fromRGBO(76, 175, 80, 0.75);
  }

  static Color get negativeColor {
    return Color.fromRGBO(244, 67, 54, 0.75);
  }
}
