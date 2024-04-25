import 'package:facecode/controller/authCtr.dart';
import 'package:facecode/view/screen/HomeScreen.dart';
import 'package:facecode/view/screen/auth/resetPassword.dart';
import 'package:facecode/view/screen/auth/signUpScreen.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:facecode/view/widget/textFormPasswordWidget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginPage";

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "FaceCode",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to your professional community",
                  style: TextStyle(color: Color(0xFFB24020), fontSize: 30),
                  maxLines: 2,
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Email or phone",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: emailContoller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email or phone';
                    }
                    return null;
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusColor: Colors.black,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Password",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 10),
                TextFormPasswordWidget(
                    controller: passwordController, obscureText: _obscureText),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ResetPasswordScreen.routeName);
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      AuthCtrl.login(
                        emailContoller.text,
                        passwordController.text,
                        () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, HomeScreen.routeName, (route) => false);
                        },
                        (message) {
                          ShowDialog.showCustomDialog(context, "Error", Text(message), (){Navigator.pop(context);});
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Center(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        endIndent: 15,
                      ),
                    ),
                    Text('or'),
                    Expanded(
                      child: Divider(
                        indent: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "By clicking Continue, you agree to FaceCode’s",
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "User Agreement",
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text(","),
                    Text(
                      " Privacy Policy",
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text(", and"),
                    Text(
                      " Cookie Policy.",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.black),
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Center(
                    child: Text(
                      "New to FaceCode? Join now",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
