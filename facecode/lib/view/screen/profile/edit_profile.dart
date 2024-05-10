// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:facecode/controller/editProfileCtr.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:facecode/view/widget/textFormWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  static const String routeName = "editProfile";
  CscCountry? _country;
  String? _state;
  String? _city;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
  TextEditingController phone = TextEditingController();
  EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var model = ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 5)),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: model.imageUrl ?? "",
                          placeholder: (context, url) => Center(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    Text(
                      "Change Profile Picture",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.first_name,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 10),
              TextFormWidget(
                  hintText_: model.firstName,
                  type: TextInputType.name,
                  controller: firstName,
                  message:
                      AppLocalizations.of(context)!.please_enter_first_name),
              Text(
                AppLocalizations.of(context)!.last_name,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 10),
              TextFormWidget(
                  hintText_: model.lastName,
                  type: TextInputType.name,
                  controller: lastName,
                  message:
                      AppLocalizations.of(context)!.please_enter_last_name),
              Text(
                AppLocalizations.of(context)!.phone_number,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 10),
              TextFormWidget(
                  hintText_: model.phone,
                  type: TextInputType.phone,
                  controller: phone,
                  message: AppLocalizations.of(context)!.please_enter_phone),
              Text(
                AppLocalizations.of(context)!.job_title,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 10),
              TextFormWidget(
                  hintText_: model.jobTitle,
                  type: TextInputType.text,
                  controller: jobTitle,
                  message:
                      AppLocalizations.of(context)!.please_enter_job_title),
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
                  _country = country as CscCountry?;
                  print(_country);
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
                dropdownItemStyle: TextStyle(color: Colors.black, fontSize: 15),
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
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (firstName.text.isNotEmpty) {
                    model.firstName = firstName.text;
                  }
                  if (lastName.text.isNotEmpty) {
                    model.lastName = lastName.text;
                  }
                  if (phone.text.isNotEmpty) {
                    model.phone = phone.text;
                  }
                  if (jobTitle.text.isNotEmpty) {
                    model.jobTitle = jobTitle.text;
                  }
                  
                  UserModel UpdatedModel = UserModel(
                      id: model.id,
                      email: model.email,
                      firstName: model.firstName,
                      jobTitle: model.jobTitle,
                      lastName: model.lastName,
                      phone: model.phone,
                      city: model.city,
                      country: model.country,
                      state: model.state,
                      imageUrl: model.imageUrl);
                  EditProfileCtr.editUser(UpdatedModel);
                  ShowDialog.showCustomDialog(
                      context, "Success", Text("Updated Successfully"), () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Center(
                  child: Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
