// ignore_for_file: must_be_immutable

import 'package:facecode/controller/authCtr.dart';
import 'package:facecode/view/screen/auth/loginScreen.dart';
import 'package:facecode/view/widget/app_bar.dart';
import 'package:facecode/view/widget/policy_and_privacy_widget.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:facecode/view/widget/textFormPasswordWidget.dart';
import 'package:facecode/view/widget/textFormWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = "signUpPage";
  SignUpScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController region = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F2F5),
      appBar: SharedAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.make_the_most_of_your_professional_life,
                  style: TextStyle(color: Color(0xFFB24020), fontSize: 25),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.email,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      TextFormWidget(
                          type: TextInputType.emailAddress,
                          controller: _emailController,
                          message:
                              AppLocalizations.of(context)!.please_enter_mail),
                      Text(
                        AppLocalizations.of(context)!.password,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      TextFormPasswordWidget(
                          controller: _passwordController,
                          obscureText: _obscureText),
                      SizedBox(height: 10),
                      Text(
                        AppLocalizations.of(context)!.first_name,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      TextFormWidget(
                          type: TextInputType.name,
                          controller: firstName,
                          message: AppLocalizations.of(context)!.please_enter_first_name),
                      Text(
                        AppLocalizations.of(context)!.last_name,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      TextFormWidget(
                          type: TextInputType.name,
                          controller: lastName,
                          message: AppLocalizations.of(context)!.please_enter_last_name),
                      Text(
                        AppLocalizations.of(context)!.phone_number,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      TextFormWidget(
                          type: TextInputType.phone,
                          controller: phone,
                          message: AppLocalizations.of(context)!.please_enter_phone),
                      Text(
                        AppLocalizations.of(context)!.job_title,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      TextFormWidget(
                          type: TextInputType.text,
                          controller: jobTitle,
                          message: AppLocalizations.of(context)!.please_enter_job_title),
                      Text(
                        AppLocalizations.of(context)!.region,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      TextFormWidget(
                        type: TextInputType.text,
                        controller: region,
                        message: AppLocalizations.of(context)!.please_enter_region,
                      ),
                      PrivacyAndPolicyWidget(),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AuthCtrl.createAccount(
                              email: _emailController.text,
                              password: _passwordController.text,
                              firstName: firstName.text,
                              jobTitle: jobTitle.text,
                              lastName: lastName.text,
                              phone: phone.text,
                              region: region.text,
                              onSuccess: () {
                                ShowDialog.showCustomDialog(
                                    context,
                                    "Success",
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.09,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(AppLocalizations.of(context)!.we_sent_an_email_to),
                                          Text(
                                            _emailController.text,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(AppLocalizations.of(context)!.please_verify_your_mail),
                                        ],
                                      ),
                                    ), () {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      LoginScreen.routeName, (route) => false);
                                });
                              },
                              onError: (errorMessage) {
                                ShowDialog.showCustomDialog(
                                    context, "Error", Text(errorMessage), () {
                                  Navigator.pop(context);
                                });
                              },
                            );
                            print("sucesss");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.agree_and_join,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.already_on_faceCode,
                            style: TextStyle(fontSize: 18),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, routeName, (route) => false,
                                  arguments: _emailController.text);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.sign_in,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
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
