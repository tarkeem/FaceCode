// ignore_for_file: must_be_immutable

import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:facecode/view/widget/textFormWidget.dart';
import 'package:flutter/material.dart';

class EditBioScreen extends StatefulWidget {
  static const String routeName = "editBioScreen";

  EditBioScreen({super.key});

  @override
  State<EditBioScreen> createState() => _EditBioScreenState();
}

class _EditBioScreenState extends State<EditBioScreen> {
  TextEditingController _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Bio",
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormWidget(
              hintText_: model.bio,
              controller: _bioController,
              message: "",
              type: TextInputType.text,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: ElevatedButton(
                onPressed: () async {
                  String bio = _bioController.text;
                  if (bio.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      "Please Edit Bio firstly, then Update.",
                      style: TextStyle(fontSize: 15),
                    )));
                    return;
                  }
                  Map<String, dynamic> additionalAttributes = {
                    'bio': bio,
                  };
                  await UserCtr.addOrUpdateAdditionalAttributes(
                      model.id!, additionalAttributes);
                  UserModel? updatedUser = await UserCtr.getUserById(model.id!);
                  model.bio = bio;
                  // UserCtr.updateProfilePicture(model.id!, imageUrl);
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
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                if(model.bio == null){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      "No Bio to Delete.",
                      style: TextStyle(fontSize: 15),
                    )));
                    return;
                }
                await UserCtr.deleteBio(model.id!);
                model.bio = null;
                Map<String, dynamic> additionalAttributes = {
                  'bio': null,
                };
                await UserCtr.addOrUpdateAdditionalAttributes(
                    model.id!, additionalAttributes);
                UserModel? updatedUser = await UserCtr.getUserById(model.id!);
                ShowDialog.showCustomDialog(
                    context, "Success", Text("Deleted Successfully"), () {
                  Navigator.pop(context);
                  Navigator.pop(context, updatedUser);
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
