import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xFF377DFF);
  static final MaterialColor primaryMaterialColor =
      MaterialColor(primaryColor.value, primaryColorMap);
  static final primaryColorMap = {
    50: const Color.fromRGBO(55, 125, 255, .1),
    100: const Color.fromRGBO(55, 125, 255, .2),
    200: const Color.fromRGBO(55, 125, 255, .3),
    300: const Color.fromRGBO(55, 125, 255, .4),
    400: const Color.fromRGBO(55, 125, 255, .5),
    500: const Color.fromRGBO(55, 125, 255, .6),
    600: const Color.fromRGBO(55, 125, 255, .7),
    700: const Color.fromRGBO(55, 125, 255, .8),
    800: const Color.fromRGBO(55, 125, 255, .9),
    900: const Color.fromRGBO(55, 125, 255, 1),
  };
  
  static const searchBarColor = Color(0xFFF7F7F9);
  static final MaterialColor materialSearchBarColor =
      MaterialColor(searchBarColor.value, searchBarColorMap);
  static final searchBarColorMap = {
    50: const Color.fromRGBO(247, 247, 249, .1),
    100: const Color.fromRGBO(247, 247, 249, .2),
    200: const Color.fromRGBO(247, 247, 249, .3),
    300: const Color.fromRGBO(247, 247, 249, .4),
    400: const Color.fromRGBO(247, 247, 249, .5),
    500: const Color.fromRGBO(247, 247, 249, .6),
    600: const Color.fromRGBO(247, 247, 249, .7),
    700: const Color.fromRGBO(247, 247, 249, .8),
    800: const Color.fromRGBO(247, 247, 249, .9),
    900: const Color.fromRGBO(247, 247, 249, 1),
  };

  static const fontColor = Color(0xFF243443);
  static const hintColor = Color(0xFFAAB0B7);
}
