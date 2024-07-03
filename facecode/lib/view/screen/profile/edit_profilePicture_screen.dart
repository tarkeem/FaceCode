import 'dart:io';
import 'dart:typed_data';

import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/view/widget/edit_delete_widget.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePictureScreen extends StatefulWidget {
  static const String routeName = "changeProfileScreen";

  EditProfilePictureScreen({super.key});

  @override
  State<EditProfilePictureScreen> createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<EditProfilePictureScreen> {
  Uint8List? profileImage;
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change profile",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.70,
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
                        : model.imageUrl != null && model.imageUrl!.isNotEmpty
                            ? CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 64,
                                backgroundImage: NetworkImage(model.imageUrl!),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 64,
                                backgroundImage: AssetImage(
                                  "images/avatardefault.png",
                                ),
                              ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                EditDeleteWidget(
                  delete: () async {
                    await UserCtr.deleteProfilePicture(model.id!);
                    model.imageUrl = null;
                    setState(() {
                      profileImage = null;
                      imageUrl = '';
                    });
                    model.imageUrl = imageUrl;
                    var updatedModel = UserModel(
                      id: model.id,
                      email: model.email,
                      firstName: model.firstName,
                      lastName: model.lastName,
                      jobTitle: model.jobTitle,
                      phone: model.phone,
                      city: model.city,
                      country: model.country,
                      state: model.state,
                      imageUrl: model.imageUrl,
                      followers: model.followers,
                      following: model.following,
                    );
                    ShowDialog.showCustomDialog(
                        context, "Success", Text("Deleted Successfully"), () {
                      Navigator.pop(context);
                      Navigator.pop(context, updatedModel);
                    });
                  },
                  edit: () async {
                    ImagePicker imagePicker = ImagePicker();
                    XFile? file = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    print('${file?.path}');

                    if (file == null) return;
                    setState(() {
                      profileImage = File(file.path).readAsBytesSync();
                    });
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');

                    //Create reference for image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      "Please wait while Image is completely uploaded.",
                      style: TextStyle(fontSize: 15),
                    )));
                    try {
                      //store file
                      await referenceImageToUpload.putFile(File(file.path));
                      //success, get download url
                      imageUrl = await referenceImageToUpload.getDownloadURL();
                    } catch (error) {
                      print(error.toString());
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        "Failed to upload image: $error",
                        style: TextStyle(fontSize: 15),
                      )));
                    }
                    model.imageUrl = imageUrl;
                    var updatedModel = UserModel(
                        id: model.id,
                        email: model.email,
                        firstName: model.firstName,
                        lastName: model.lastName,
                        jobTitle: model.jobTitle,
                        phone: model.phone,
                        city: model.city,
                        country: model.country,
                        state: model.state,
                        imageUrl: model.imageUrl,
                        followers: model.following,
                        following: model.following);
                    UserCtr.updateProfilePicture(model.id!, imageUrl);
                    ShowDialog.showCustomDialog(
                        context, "Success", Text("Updated Successfully"), () {
                      Navigator.pop(context);
                      Navigator.pop(context, updatedModel);
                    });
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
