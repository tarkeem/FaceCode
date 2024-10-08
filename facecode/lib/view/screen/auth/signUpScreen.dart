// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:typed_data';

import 'package:csc_picker/csc_picker.dart';
import 'package:facecode/controller/authCtr.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/auth/loginScreen.dart';
import 'package:facecode/view/widget/shared_signedOut_app_bar.dart';
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
  TextEditingController _retypePasswordController = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  String? _country;
  String? _state;
  String? _city;
  Uint8List? _image;
  String? imageUrl;
  String? selectedJobTitle;
  List<String> jobTitles = [
    'Flutter Developer',
    'Frontend Developer',
    'Backend Developer',
    'Full Stack Developer',
    'Android Mobile Developer',
    'IOS Mobile Developer',
    'Data Scientist',
    'Machine Learning Engineer',
    'AI Developer',
    'Embedded Systems Developer',
    'Game Developer',
    'Cybersecurity Engineer',
    'Blockchain Developer',
    'Cloud Engineer',
    'Robotics Engineer',
    'Bioinformatics Programmer',
    'Software Development Manager',
    'Technical Project Manager',
    'Systems Administrator',
    'Network Engineer',
    'UX/UI Designer',
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: SharedSignedOutAppBar(
        showBackButton: false,
      ),
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
                                  // PickImageCtr.pickAndUploadImage(context, _setImage, imageUrl);
                                  // print(imageUrl);
                                  //Picking Image
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file = await imagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  print('${file?.path}');

                                  if (file == null) return;
                                  setState(() {
                                    _image = File(file.path).readAsBytesSync();
                                  });
                                  String uniqueFileName = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();

                                  //Get a reference to storage root
                                  Reference referenceRoot =
                                      FirebaseStorage.instance.ref();
                                  Reference referenceDirImages =
                                      referenceRoot.child('images');

                                  //Create reference for image to be stored
                                  Reference referenceImageToUpload =
                                      referenceDirImages.child(uniqueFileName);

                                  try {
                                    //store file
                                    await referenceImageToUpload
                                        .putFile(File(file.path));
                                    //success, get download url
                                    imageUrl = await referenceImageToUpload
                                        .getDownloadURL();
                                  } catch (error) {}
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
                        "Re-Enter Password",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: 10),
                      TextFormPasswordWidget(
                          controller: _retypePasswordController,
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
                      DropdownButtonFormField<String>(
                        value: selectedJobTitle,
                        items: jobTitles.map((String job) {
                          return DropdownMenuItem<String>(
                            value: job,
                            child: Text(job),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedJobTitle = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: "Select a Job",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_job_title;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!.region,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: 10),
                      CSCPicker(
                        countryDropdownLabel: "Select Country",
                        stateDropdownLabel: "Select State",
                        cityDropdownLabel: "Select City",
                        layout: Layout.vertical,
                        flagState: CountryFlag.ENABLE,
                        onCountryChanged: (country) {
                          String trimmedCountry = "";
                          for (int i = 0; i <= 3; i++) {
                            trimmedCountry += country[i];
                          }
                          trimmedCountry += ' ';
                          for (int i = 8; i < country.length; i++) {
                            trimmedCountry += country[i];
                          }
                          _country = trimmedCountry;
                        },
                        onStateChanged: (state) {
                          _state = state;
                          print(_state);
                        },
                        onCityChanged: (city) {
                          _city = city;
                          print(_city);
                        },
                        dropdownDialogRadius: 12,
                        searchBarRadius: 30,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: provider.myTheme == ThemeMode.dark
                                ? Colors.white
                                : Colors.grey,
                            width: 1,
                          ),
                        ),
                        dropdownItemStyle:
                            TextStyle(color: Colors.black, fontSize: 15),
                        disabledDropdownDecoration: BoxDecoration(
                          color: Colors.grey.shade600,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: provider.myTheme == ThemeMode.dark
                                ? Colors.white
                                : Colors.grey.shade600,
                            width: 1,
                          ),
                        ),
                      ),
                      PrivacyAndPolicyWidget(),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String emailPattern = r'^[^@]+@[^@]+\.[^@]+$';
                            RegExp regex = RegExp(emailPattern);
                            if (!regex.hasMatch(_emailController.text)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                "Please Enter correct Email.",
                                style: TextStyle(fontSize: 15),
                              )));
                              return;
                            }
                            if (_passwordController.text !=
                                _retypePasswordController.text) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                "Password Mismatch During Account Creation.",
                                style: TextStyle(fontSize: 15),
                              )));
                              print(_passwordController.text);
                              print(
                                  "retype: ${_retypePasswordController.text}");
                              return;
                            }
                            if (RegExp(r'[0-9]').hasMatch(firstName.text) ||
                                RegExp(r'[0-9]').hasMatch(lastName.text)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                "Names can not contain numbers.",
                                style: TextStyle(fontSize: 15),
                              )));
                              return;
                            }
                            if (phone.text.length != 11) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                "Phone number must be 11 digits.",
                                style: TextStyle(fontSize: 15),
                              )));
                              return;
                            }
                            if (this._country == null ||
                                this._city == null ||
                                this._state == null) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Please select your Counrty, City and State.",
                                      style: TextStyle(fontSize: 15))));
                              return;
                            }
                            firstName.text = firstName.text[0].toUpperCase() +
                                firstName.text.substring(1);
                            lastName.text = lastName.text[0].toUpperCase() +
                                lastName.text.substring(1);
                            //String _imageUrl =  await PickImageCtr.uploadImagetoStorage("ProfileImage", _image!);
                            AuthCtrl.createAccount(
                              imageUrl: imageUrl,
                              email: _emailController.text,
                              password: _passwordController.text,
                              firstName: firstName.text,
                              jobTitle: selectedJobTitle!,
                              lastName: lastName.text,
                              phone: phone.text,
                              city: _city!,
                              state: _state!,
                              country: _country!,
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
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                LoginScreen.routeName,
                                (route) => false,
                              );
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
