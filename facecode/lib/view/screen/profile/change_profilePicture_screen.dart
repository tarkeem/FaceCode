import 'dart:io';
import 'dart:typed_data';

import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfileScreen extends StatefulWidget {
  static const String routeName = "changeProfileScreen";

  ChangeProfileScreen({super.key});

  @override
  State<ChangeProfileScreen> createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                print('${file?.path}');

                if (file == null) return;
                setState(() {
                  profileImage = File(file.path).readAsBytesSync();
                });
                String uniqueFileName =
                    DateTime.now().millisecondsSinceEpoch.toString();

                //Get a reference to storage root
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = referenceRoot.child('images');

                //Create reference for image to be stored
                Reference referenceImageToUpload =
                    referenceDirImages.child(uniqueFileName);
                try {
                  //store file
                  await referenceImageToUpload.putFile(File(file.path));
                  //success, get download url
                  imageUrl = await referenceImageToUpload.getDownloadURL();

                  //model.imageUrl = imageUrl;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    "Image Uploaded Successfully.",
                    style: TextStyle(fontSize: 15),
                  )));
                  print(imageUrl);
                } catch (error) {
                  print(error.toString());
                }
              },
              child: Column(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Change Profile Picture",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.edit)
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: ElevatedButton(
                onPressed: () {
                  if (imageUrl.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      "Please Upload an Image firstly, then Update profile",
                      style: TextStyle(fontSize: 15),
                    )));
                    return;
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
                  );
                  UserCtr.updateProfilePicture(model.id!, imageUrl);
                  ShowDialog.showCustomDialog(
                      context, "Success", Text("Updated Successfully"), () {
                        Navigator.pop(context);
                    Navigator.pop(context, updatedModel);
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
            ),
          ],
        ),
      ),
    );
  }
}
