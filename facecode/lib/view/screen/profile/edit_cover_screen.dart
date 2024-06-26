import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/view/widget/edit_delete_widget.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditCoverScreen extends StatefulWidget {
  static const String routeName = "changeCover";
  const EditCoverScreen({super.key});

  @override
  State<EditCoverScreen> createState() => _ChangeCoverScreenState();
}

class _ChangeCoverScreenState extends State<EditCoverScreen> {
  Uint8List? profileImage;
  String covereUrl = '';
  bool deleted = false;

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Cover",
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
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: double.infinity,
                  //Check if there is no cover and there is no picked image, it renders default
                  child: (profileImage == null &&
                          (model.coverUrl == null || model.coverUrl == ''))
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
                  height: 20,
                ),
                EditDeleteWidget(
                  delete: () async {
                    await UserCtr.deleteCoverPicture(model.id!);
                    model.coverUrl = null;
                    setState(() {
                      profileImage = null;
                      covereUrl = '';
                    });
                    Map<String, dynamic> additionalAttributes = {
                      'coverUrl': null,
                    };
                    await UserCtr.addOrUpdateAdditionalAttributes(
                        model.id!, additionalAttributes);
                    UserModel? updatedUser =
                        await UserCtr.getUserById(model.id!);
                    model.coverUrl = covereUrl;
                    ShowDialog.showCustomDialog(
                        context, "Success", Text("Deleted Successfully"), () {
                      Navigator.pop(context);
                      Navigator.pop(context, updatedUser);
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
                      covereUrl = await referenceImageToUpload.getDownloadURL();
                    } catch (error) {
                      print(error.toString());
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        "Failed to upload image: $error",
                        style: TextStyle(fontSize: 15),
                      )));
                    }
                    Map<String, dynamic> additionalAttributes = {
                      'coverUrl': covereUrl,
                    };
                    await UserCtr.addOrUpdateAdditionalAttributes(
                        model.id!, additionalAttributes);
                    UserModel? updatedUser =
                        await UserCtr.getUserById(model.id!);
                    model.coverUrl = covereUrl;
                    ShowDialog.showCustomDialog(
                        context, "Success", Text("Updated Successfully"), () {
                      Navigator.pop(context);
                      Navigator.pop(context, updatedUser);
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
