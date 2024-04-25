import 'package:facecode/controller/authCtr.dart';
import 'package:facecode/view/screen/HomeScreen.dart';
import 'package:facecode/view/widget/textFormWidget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "signUpPage";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "FaceCode",
        ),
      ),
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
                  "Make the most of your professional life.",
                  maxLines: 1,
                  style: TextStyle(fontSize: 20),
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
                        "Email or phone",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      TextFormWidget(
                          type: TextInputType.emailAddress,
                          controller: _emailController,
                          message: "Please enter your email"),
                      Text(
                        "Password (6+ characters)",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password with at least 6 characters';
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusColor: Colors.black,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "First Name",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      TextFormWidget(
                          type: TextInputType.name,
                          controller: firstName,
                          message: "Please enter your First Name"),
                      Text(
                        "Last Name",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      TextFormWidget(
                          type: TextInputType.name,
                          controller: lastName,
                          message: "Please enter your last name"),
                      Text(
                        "Phone Number",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      TextFormWidget(
                          type: TextInputType.phone,
                          controller: phone,
                          message: "Please enter your phone number"),
                      Text(
                        "Job title",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      TextFormWidget(
                          type: TextInputType.text,
                          controller: jobTitle,
                          message: 'Please enter your job title'),
                      Text(
                        "Region",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      TextFormWidget(
                        type: TextInputType.text,
                        controller: region,
                        message: 'Please enter your Region',
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: Text(
                          "By clicking Continue, you agree to FaceCode’s",
                        ),
                      ),
                      const Row(
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
                      SizedBox(height: 30),
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
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Success",style: TextStyle(fontWeight: FontWeight.bold),),
                                      content: SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.09,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("We sent an Email to"),
                                            Text(_emailController.text,style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text("Please verify your mail"),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                            backgroundColor: Colors.black,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
                                          },
                                          child: Text("Ok",style: TextStyle(color: Colors.white),),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              onError: (errorMessage) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(errorMessage),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Ok"),
                                        )
                                      ],
                                    );
                                  },
                                );
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
                            "Agree & Join",
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
                            "Already on FaceCode?",
                            style: TextStyle(fontSize: 18),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  SignUpScreen.routeName, (route) => false,
                                  arguments: _emailController.text);
                            },
                            child: Text(
                              " Sign in",
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