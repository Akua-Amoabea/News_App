
import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  bool switchValue = false;
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;



  void setTheme( bool value) {
    if(_themeMode == ThemeMode.light){
      switchValue = true;
      _themeMode = ThemeMode.dark;
    }
    else{
      switchValue = false;
      _themeMode = ThemeMode.light;

    }

    notifyListeners();
  }
}

