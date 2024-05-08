import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool isSwitch = false;

  ThemeProvider(){
    getThemeShared();
  }

  set setTheme(value) {
    isSwitch = value;
    setThemeShared(value);
    notifyListeners();
  }

  get getTheme {
    return isSwitch;
  }

  setThemeShared(value) async {
    SharedPreferences sharedVar=await SharedPreferences.getInstance();
    sharedVar.setBool('isSwitch', value);
    notifyListeners();
  }
  getThemeShared() async {
    SharedPreferences sharedVar=await SharedPreferences.getInstance();
    isSwitch=sharedVar.getBool('isSwitch')??false;
    notifyListeners();
  }


}
