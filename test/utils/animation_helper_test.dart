import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hot_potato/utils/animation_helper.dart';

void main() {
  group('AnimationHelper', () {
    group('playPulse', () {
      test('returns positiveColor when goodCondition is true', () {
        final color = AnimationHelper.playPulse(true, false);
        expect(color, AnimationHelper.positiveColor);
      });

      test('returns negativeColor when badCondition is true', () {
        final color = AnimationHelper.playPulse(false, true);
        expect(color, AnimationHelper.negativeColor);
      });

      test('returns transparent when both conditions are false', () {
        final color = AnimationHelper.playPulse(false, false);
        expect(color, Colors.transparent);
      });

      test('returns positiveColor when both conditions are true (good takes priority)', () {
        final color = AnimationHelper.playPulse(true, true);
        expect(color, AnimationHelper.positiveColor);
      });
    });

    group('positiveColor', () {
      test('is a green-ish color with opacity', () {
        final color = AnimationHelper.positiveColor;
        expect(color, isA<Color>());
        expect(color.opacity, closeTo(0.75, 0.01));
        expect(color.green, greaterThan(color.red));
      });
    });

    group('negativeColor', () {
      test('is a red-ish color with opacity', () {
        final color = AnimationHelper.negativeColor;
        expect(color, isA<Color>());
        expect(color.opacity, closeTo(0.75, 0.01));
        expect(color.red, greaterThan(color.green));
      });
    });
  });
}
