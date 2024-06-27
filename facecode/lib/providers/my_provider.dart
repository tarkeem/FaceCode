import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  String languageCode = "en";
  ThemeMode myTheme = ThemeMode.light;
  String? userId;
  UserModel? userModel;
  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  changeTheme(ThemeMode mode) {
    myTheme = mode;
    notifyListeners();
  }

  changeLaguage(String code) {
    languageCode = code;
    notifyListeners();
  }

  void setUserId(String id) {
    userId = id;
    notifyListeners();
  }

  initUser() async {
    userModel = await UserCtr.readUser();
    notifyListeners();
  }

  logout(){
    FirebaseAuth.instance.signOut();
    firebaseUser = null;
    userModel = null;
    notifyListeners();
  }
}
