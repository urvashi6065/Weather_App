import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool isSwitch = false;

  set setTheme(value) {
    isSwitch = value;
    notifyListeners();
  }

  get getTheme {
    return isSwitch;
  }
}
