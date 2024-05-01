// ignore_for_file: must_be_immutable

import 'package:facecode/controller/authCtr.dart';
import 'package:facecode/providers/my_provider.dart';
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
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {
  static const String routeName = "LoginPage";

  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: SharedAppBar(),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.80,
          decoration: BoxDecoration(
            color: provider.myTheme == ThemeMode.dark ? Color(0xFF181818) : Colors.white,
            borderRadius: BorderRadius.circular(15)
          ),
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
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
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: 10),
                  TextFormWidget(controller: emailContoller, message: AppLocalizations.of(context)!.please_enter_mail, type: TextInputType.emailAddress),
                  SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.password,
                    style: Theme.of(context).textTheme.bodySmall,
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
                      style: Theme.of(context).textTheme.bodyMedium,
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
                                context, "Error", Text(message ,style: Theme.of(context).textTheme.bodySmall,), () {
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
                      Text(AppLocalizations.of(context)!.or,style: Theme.of(context).textTheme.bodySmall,),
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
      ),
    );
  }
}
