import 'package:flutter/material.dart';

class Themes {
  static ThemesColors colors = ThemesColors();

  static ThemeTextStyles textStyle = ThemeTextStyles();
}

class ThemesColors {
  final Color light = const Color(0xffF6FFF8);
  final Color mediumLight = const Color(0xffEAF4F4);
  final Color medium = const Color(0xffCCE3DE);
  final Color mediumDark = const Color(0xffA4C3B2);
  final Color dark = const Color(0xff6B9080);
}

class ThemeTextStyles {
  final TextStyle headline1 =
      TextStyle(fontSize: 28, color: Themes.colors.dark);
  final TextStyle headline2 =
      TextStyle(fontSize: 20, color: Themes.colors.dark);
  final TextStyle headline3 =
      TextStyle(fontSize: 15, color: Themes.colors.dark);
  final TextStyle buttonText =
      TextStyle(fontSize: 16, color: Themes.colors.light);
}
