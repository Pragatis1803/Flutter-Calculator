import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/prefs/preference.dart';

class ThemeProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  bool _darkTheme = false;
  ThemePreference preference = ThemePreference();

  //getter
  bool get darkTheme => _darkTheme;
  //setter
  set darkTheme(bool value) {
    _darkTheme = value;
    preference.setTheme(value);
    notifyListeners();
  }
}
