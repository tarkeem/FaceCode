import 'package:facecode/styles/my_theme.dart';
import 'package:facecode/view/screen/addpost.dart';
import 'package:facecode/view/screen/homepage.dart';
import 'package:facecode/view/screen/auth/loginScreen.dart';
import 'package:facecode/view/screen/auth/resetPassword.dart';
import 'package:facecode/view/screen/auth/signUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './firebase_options.dart';

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        Addpost.routeName:(context)=>Addpost(),
        ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
      },
      theme: MyTheme.theme,
    );
  }
}
