import 'package:flutter/material.dart';

Map<int, Color> _swatchOpacity = {
  50: const Color.fromRGBO(255, 143, 171, .1),
  100: const Color.fromRGBO(255, 143, 171, .2),
  200: const Color.fromRGBO(255, 143, 171, .3),
  300: const Color.fromRGBO(255, 143, 171, .4),
  400: const Color.fromRGBO(255, 143, 171, .5),
  500: const Color.fromRGBO(255, 143, 171, .6),
  600: const Color.fromRGBO(255, 143, 171, .7),
  700: const Color.fromRGBO(255, 143, 171, .8),
  800: const Color.fromRGBO(255, 143, 171, .9),
  900: const Color.fromRGBO(255, 143, 171, 1),
};

abstract class CustomColors {
  static Color customContrastColor = Colors.purple.shade100;

  static MaterialColor customSwatchColor =
      MaterialColor(0xFFFF8FAB, _swatchOpacity);
}
