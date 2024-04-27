// ignore_for_file: must_be_immutable

import 'package:facecode/controller/authCtr.dart';
import 'package:facecode/view/screen/homepage.dart';
import 'package:facecode/view/screen/auth/resetPassword.dart';
import 'package:facecode/view/screen/auth/signUpScreen.dart';
import 'package:facecode/view/widget/app_bar.dart';
import 'package:facecode/view/widget/policy_and_privacy_widget.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:facecode/view/widget/textFormPasswordWidget.dart';
import 'package:facecode/view/widget/textFormWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoginScreen extends StatelessWidget {
  static const String routeName = "LoginPage";

  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppBar(),
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
                  AppLocalizations.of(context)!.welcome_message,
                  style: TextStyle(color: Color(0xFFB24020), fontSize: 30),
                  maxLines: 2,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  AppLocalizations.of(context)!.email,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 10),
                TextFormWidget(controller: emailContoller, message: AppLocalizations.of(context)!.please_enter_mail, type: TextInputType.emailAddress),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.password,
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
                    AppLocalizations.of(context)!.forgot_password,
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
                              context, HomePage.routeName, (route) => false);
                        },     
                        (message) {
                          ShowDialog.showCustomDialog(
                              context, "Error", Text(message), () {
                            Navigator.pop(context);
                          });
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
                      AppLocalizations.of(context)!.sign_in,
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
                    Text(AppLocalizations.of(context)!.or),
                    Expanded(
                      child: Divider(
                        indent: 15,
                      ),
                    ),
                  ],
                ),
                PrivacyAndPolicyWidget(),
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
                      AppLocalizations.of(context)!.new_to_facecode,
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
