// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:typed_data';

import 'package:facecode/controller/authCtr.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/auth/loginScreen.dart';
import 'package:facecode/view/widget/shared_app_bar.dart';
import 'package:facecode/view/widget/policy_and_privacy_widget.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:facecode/view/widget/textFormPasswordWidget.dart';
import 'package:facecode/view/widget/textFormWidget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "signUpPage";
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController region = TextEditingController();
  Uint8List? _image;
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: SharedAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!
                      .make_the_most_of_your_professional_life,
                  style: TextStyle(
                      color: Color(0xFFB24020),
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: provider.myTheme == ThemeMode.dark
                        ? Color(0xFF181818)
                        : Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            _image != null
                                ? CircleAvatar(
                                    radius: 64,
                                    backgroundImage: MemoryImage(_image!),
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 64,
                                    backgroundImage: AssetImage(
                                      "images/avatardefault.png",
                                    ),
                                  ),
                            Positioned(
                              bottom: -12,
                              left: 85,
                              child: IconButton(
                                onPressed: () async {
                                  //Picking Image
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file =await imagePicker.pickImage(source: ImageSource.gallery);
                                  print('${file?.path}');
                                  
                                  if(file== null) return;
                                  setState(() {
                                    _image = File(file.path).readAsBytesSync();
                                  });
                                  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
                                  
                                  //Get a reference to storage root
                                  Reference referenceRoot = FirebaseStorage.instance.ref();
                                  Reference referenceDirImages = referenceRoot.child('images');
                                  
                                  //Create reference for image to be stored
                                  Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
                                  
                                  try{
                                    //store file
                                  await referenceImageToUpload.putFile(File(file.path));
                                  //success, get download url
                                  imageUrl = await referenceImageToUpload.getDownloadURL();
                                  }catch(error){}
                                },
                                icon: Icon(
                                  color: provider.myTheme == ThemeMode.dark
                                      ? Colors.white
                                      : Color(0xFF2B2B2B),
                                  Icons.add_a_photo_sharp,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        AppLocalizations.of(context)!.email,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: 10),
                      TextFormWidget(
                          type: TextInputType.emailAddress,
                          controller: _emailController,
                          message:
                              AppLocalizations.of(context)!.please_enter_mail),
                      Text(
                        AppLocalizations.of(context)!.password,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: 10),
                      TextFormPasswordWidget(
                          controller: _passwordController,
                          obscureText: _obscureText),
                      SizedBox(height: 10),
                      Text(
                        AppLocalizations.of(context)!.first_name,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: 10),
                      TextFormWidget(
                          type: TextInputType.name,
                          controller: firstName,
                          message: AppLocalizations.of(context)!
                              .please_enter_first_name),
                      Text(
                        AppLocalizations.of(context)!.last_name,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: 10),
                      TextFormWidget(
                          type: TextInputType.name,
                          controller: lastName,
                          message: AppLocalizations.of(context)!
                              .please_enter_last_name),
                      Text(
                        AppLocalizations.of(context)!.phone_number,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: 10),
                      TextFormWidget(
                          type: TextInputType.phone,
                          controller: phone,
                          message:
                              AppLocalizations.of(context)!.please_enter_phone),
                      Text(
                        AppLocalizations.of(context)!.job_title,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: 10),
                      TextFormWidget(
                          type: TextInputType.text,
                          controller: jobTitle,
                          message: AppLocalizations.of(context)!
                              .please_enter_job_title),
                      Text(
                        AppLocalizations.of(context)!.region,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: 10),
                      TextFormWidget(
                        type: TextInputType.text,
                        controller: region,
                        message:
                            AppLocalizations.of(context)!.please_enter_region,
                      ),
                      PrivacyAndPolicyWidget(),
                      ElevatedButton(
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            if(imageUrl.isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Upload an Image")));
                              return;
                            }
                            //String _imageUrl =  await PickImageCtr.uploadImagetoStorage("ProfileImage", _image!);
                            AuthCtrl.createAccount(
                              imageUrl: imageUrl,
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
                                          Text(
                                            AppLocalizations.of(context)!
                                                .we_sent_an_email_to,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              _emailController.text,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .please_verify_your_mail,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      ),
                                    ), () {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      LoginScreen.routeName, (route) => false);
                                });
                              },
                              onError: (errorMessage) {
                                ShowDialog.showCustomDialog(
                                    context,
                                    "Error",
                                    Text(
                                      errorMessage,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ), () {
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
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.already_on_faceCode,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  SignUpScreen.routeName, (route) => false,
                                  arguments: _emailController.text);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.sign_in,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: provider.myTheme == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.black,
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
