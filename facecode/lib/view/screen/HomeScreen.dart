import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "HomeScreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF3F2F5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "FaceCode",
        ),
      ),
      body: Center(child: Text("Home Screeeeeen" , style: TextStyle(color: Colors.black , fontSize: 40,fontWeight: FontWeight.bold),)),
    );
  }
}