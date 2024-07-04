import 'package:flutter/material.dart';
import 'package:facecode/providers/my_provider.dart';

class MyTheme {
  final MyProvider provider;

  MyTheme(this.provider);

  static Color scaffoldLightColor = Color(0xFFF3F2F5);
  static Color scaffoldDarkColor = Color(0xFF2C2C2C);

  ThemeData get lightTheme => ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.black, backgroundColor: Colors.white),
      scaffoldBackgroundColor: scaffoldLightColor,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontSize: 22,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        bodySmall: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
      ));

  ThemeData get darkTheme => ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white,
            backgroundColor: Colors.black),
        scaffoldBackgroundColor: scaffoldDarkColor,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      );
}
