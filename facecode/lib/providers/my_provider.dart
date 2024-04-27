import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier{
  String languageCode = "en";

  changeLaguage(String code){
    languageCode = code;
    notifyListeners();
  }
}