import 'package:flutter/material.dart';

class Style {
  static ThemeData themeData(bool isDarkTheme) {
    return ThemeData(
        primaryColor: Colors.blue,
        brightness: isDarkTheme ? Brightness.dark : Brightness.light);
  }
}
