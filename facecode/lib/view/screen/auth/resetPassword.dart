// ignore_for_file: must_be_immutable

import 'package:facecode/controller/authCtr.dart';
import 'package:facecode/view/screen/auth/loginScreen.dart';
import 'package:facecode/view/widget/textFormWidget.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const String routeName = "resetPass";
  var emailContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF3F2F0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "FaceCode",
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Forgot password",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
              Spacer(),
              TextFormWidget(
                  controller: emailContoller,
                  message: "Please enter your email",
                  type: TextInputType.emailAddress),
              SizedBox(height: 15),
              Text(
                "We’ll send a verification code to this email or phone number if it matches an existing FaceCode account.",
                maxLines: 3,
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      AuthCtrl.resetPassword(
                        emailContoller.text,
                        () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Success",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.09,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("We sent an Email to"),
                                      Text(
                                        emailContoller.text,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("Please Reset your password"),
                                    ],
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      backgroundColor: Colors.black,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        LoginScreen.routeName,
                                        (route) => false,
                                      );
                                    },
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        () {},
                      );
                    }
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
