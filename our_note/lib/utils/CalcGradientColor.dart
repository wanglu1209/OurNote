import 'package:flutter/material.dart';

class CalcGradientColor {
  static Color calc(int step, int totalStep, Color startColor, Color endColor) {
    int redStart = startColor.red;
    int blueStart = startColor.blue;
    int greenStart = startColor.green;
    int alphaStart = startColor.alpha;

    int redEnd = endColor.red;
    int blueEnd = endColor.blue;
    int greenEnd = endColor.green;
    int alphaEnd = endColor.alpha;
    if (totalStep == 0) totalStep = 1;

    int redCurrent =
        (redStart + (redEnd - redStart) / totalStep * step).toInt();
    int blueCurrent =
        (blueStart + (blueEnd - blueStart) / totalStep * step).toInt();
    int greenCurrent =
        (greenStart + (greenEnd - greenStart) / totalStep * step).toInt();
    int alphaCurrent =
        (alphaStart + (alphaEnd - alphaStart) / totalStep * step).toInt();

    return Color.fromARGB(alphaCurrent, redCurrent, greenCurrent, blueCurrent);
  }
}
