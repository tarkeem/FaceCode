import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChangeCoverScreen extends StatefulWidget {
  static const String routeName = "changeCover";
  const ChangeCoverScreen({super.key});

  @override
  State<ChangeCoverScreen> createState() => _ChangeCoverScreenState();
}

class _ChangeCoverScreenState extends State<ChangeCoverScreen> {
  Uint8List? profileImage;
  String covereUrl = '';

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Cover",
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
                  covereUrl = await referenceImageToUpload.getDownloadURL();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    "Image Uploaded Successfully.",
                    style: TextStyle(fontSize: 15),
                  )));
                  print(covereUrl);
                } catch (error) {
                  print(error.toString());
                }
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.infinity,
                    //Check if there is no cover and there is no picked image, it renders default
                    child: (profileImage == null && model.coverUrl == null)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'images/defaultCover.jpg',
                              fit: BoxFit.cover,
                            ),
                          )
                        : (profileImage == null)
                            ? ClipRRect(
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
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image(
                                  key: UniqueKey(),
                                  image:
                                      MemoryImage(profileImage ?? Uint8List(0)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Change Cover Photo",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        width: 10,
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
                onPressed: () async {
                  if (covereUrl.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      "Please Upload an Image firstly, then Update profile",
                      style: TextStyle(fontSize: 15),
                    )));
                    return;
                  }
                  Map<String, dynamic> additionalAttributes = {
                    'coverUrl': covereUrl,
                  };
                  await UserCtr.addOrUpdateAdditionalAttributes(
                      model.id!, additionalAttributes);
                  UserModel? updatedUser = await UserCtr.getUserById(model.id!);
                  model.coverUrl = covereUrl;
                  ShowDialog.showCustomDialog(
                      context, "Success", Text("Updated Successfully"), () {
                    Navigator.pop(context);
                    Navigator.pop(context, updatedUser);
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
