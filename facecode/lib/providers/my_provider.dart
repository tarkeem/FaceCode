import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier{
  String languageCode = "en";
  ThemeMode myTheme = ThemeMode.light;
  String? userId;

  changeTheme(ThemeMode mode){
    myTheme = mode;
    notifyListeners();
  }

  changeLaguage(String code){
    languageCode = code;
    notifyListeners();
  }

  void setUserId(String id) {
    userId = id;
    notifyListeners();
  }
}