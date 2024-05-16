// ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:facecode/controller/editProfileCtr.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/profile/change_cover_screen.dart';
import 'package:facecode/view/screen/profile/change_profilePicture_screen.dart';
import 'package:facecode/view/screen/profile/edit_bio_screen.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:facecode/view/widget/textFormWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  static const String routeName = "editProfile";

  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? _country;
  String? _state;
  String? _city;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
  TextEditingController phone = TextEditingController();
  Uint8List? profileImage;

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
                //inner column of image and text
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ChangeProfileScreen.routeName,
                      arguments: model,
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: profileImage != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: MemoryImage(profileImage!),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 64,
                                  backgroundImage: NetworkImage(
                                    model.imageUrl ?? "",
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Change Profile Picture",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Cover Photo",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () async {
                        Navigator.pushNamed(
                            context, ChangeCoverScreen.routeName,
                            arguments: model);
                      },
                      icon: Icon(Icons.edit))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                child: model.coverUrl == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image(
                          image: AssetImage("images/defaultCover.jpg"),
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: model.coverUrl!,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Bio",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () async {
                        Navigator.pushNamed(
                          context,
                          EditBioScreen.routeName,
                          arguments: model,
                        ) as UserModel?;
                      },
                      icon: Icon(Icons.edit))
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: Text(model.bio ?? "No bio",
                    style: Theme.of(context).textTheme.bodyMedium),
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
                message: AppLocalizations.of(context)!.please_enter_first_name,
              ),
              Text(
                AppLocalizations.of(context)!.last_name,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 10),
              TextFormWidget(
                hintText_: model.lastName,
                type: TextInputType.name,
                controller: lastName,
                message: AppLocalizations.of(context)!.please_enter_last_name,
              ),
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
                message: AppLocalizations.of(context)!.please_enter_job_title,
              ),
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
                  model.country = _country;
                },
                onStateChanged: (state) {
                  _state = state;
                  model.state = _state;
                  print(_state);
                },
                onCityChanged: (city) {
                  _city = city;
                  model.city = _city;
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
                onPressed: () async {
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
                      imageUrl: model.imageUrl,
                      bio: model.bio,
                      coverUrl: model.coverUrl);
                  EditProfileCtr.editUser(UpdatedModel);
                  ShowDialog.showCustomDialog(
                      context, "Success", Text("Updated Successfully"), () {
                    Navigator.pop(context);
                    Navigator.pop(context, model);
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
