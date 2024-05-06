// ignore_for_file: must_be_immutable

import 'package:facecode/controller/authCtr.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/auth/loginScreen.dart';
import 'package:facecode/view/widget/shared_app_bar.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:facecode/view/widget/textFormWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordScreen extends StatelessWidget {
  static const String routeName = "resetPass";
  var emailContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SharedAppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: provider.myTheme == ThemeMode.dark
              ? Color(0xFF181818)
              : Colors.white,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.forgot_password,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Spacer(),
              TextFormWidget(
                  controller: emailContoller,
                  message: "Please enter your email",
                  type: TextInputType.emailAddress),
              SizedBox(height: 15),
              Text(
                AppLocalizations.of(context)!.we_will_send,
                maxLines: 3,
                style: Theme.of(context).textTheme.bodyMedium,
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
                          ShowDialog.showCustomDialog(
                              context,
                              "Success",
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.09,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "We sent an Email to",
                                      style:Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      emailContoller.text,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    Text(
                                      "Please Reset your password",
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ), () {
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              LoginScreen.routeName,
                              (route) => false,
                            );
                          });
                        },
                        (errorMessage) {
                          ShowDialog.showCustomDialog(
                              context,
                              "Error",
                              Text(
                                errorMessage,
                                style: Theme.of(context).textTheme.bodySmall,
                              ), () {
                            Navigator.pop(context);
                          });
                        },
                      );
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.next,
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
                    AppLocalizations.of(context)!.back,
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
