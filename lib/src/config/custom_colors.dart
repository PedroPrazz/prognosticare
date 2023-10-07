import 'package:flutter/material.dart';

Map<int, Color> _swatchOpacity = {
  50: const Color.fromRGBO(85, 231, 199, .1),
  100: const Color.fromRGBO(85, 231, 199, .2),
  200: const Color.fromRGBO(85, 231, 199, .3),
  300: const Color.fromRGBO(85, 231, 199, .4),
  400: const Color.fromRGBO(85, 231, 199, .5),
  500: const Color.fromRGBO(85, 231, 199, .6),
  600: const Color.fromRGBO(85, 231, 199, .7),
  700: const Color.fromRGBO(85, 231, 199, .8),
  800: const Color.fromRGBO(85, 231, 199, .9),
  900: const Color.fromRGBO(85, 231, 199, 1),
};

abstract class CustomColors {
  static Color customContrastColor = Colors.blue.shade200;

  static MaterialColor customSwatchColor =
      MaterialColor(0xFF55E7C7, _swatchOpacity);
}
