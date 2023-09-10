import 'package:flutter/material.dart';

Map<int, Color> _swatcOpacity = {
  50: Color.fromRGBO(251, 111, 146, .1),
  100: Color.fromRGBO(251, 111, 146, .2),
  200: Color.fromRGBO(251, 111, 146, .3),
  300: Color.fromRGBO(251, 111, 146, .4),
  400: Color.fromRGBO(251, 111, 146, .5),
  500: Color.fromRGBO(251, 111, 146, .6),
  600: Color.fromRGBO(251, 111, 146, .7),
  700: Color.fromRGBO(251, 111, 146, .8),
  800: Color.fromRGBO(251, 111, 146, .9),
  900: Color.fromRGBO(251, 111, 146, 1),
};

abstract class CustomColors {
  static Color customContrastColor = Colors.pink.shade700;

  static MaterialColor customSwatchColor = MaterialColor(
    0xFFFB6F92,
    _swatcOpacity,
  );
}
