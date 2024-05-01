import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier{
  String languageCode = "en";
  ThemeMode myTheme = ThemeMode.light;

  changeTheme(ThemeMode mode){
    myTheme = mode;
    print(myTheme);
    notifyListeners();
  }

  changeLaguage(String code){
    languageCode = code;
    notifyListeners();
  }
}