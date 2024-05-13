// ignore_for_file: must_be_immutable

import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:facecode/view/widget/textFormWidget.dart';
import 'package:flutter/material.dart';

class EditBioScreen extends StatelessWidget {
  static const String routeName = "editBioScreen";
  TextEditingController _bioController = TextEditingController();
  EditBioScreen({super.key });

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Bio",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Edit Bio",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 30),
            TextFormWidget(
              hintText_: model.additionalAttributes?['bio'],
              controller: _bioController,
              message: "",
              type: TextInputType.text,
            ),
            SizedBox(height: 30),
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
                  model.additionalAttributes?['bio'] = bio;
                  // UserCtr.updateProfilePicture(model.id!, imageUrl);
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
            ),
          ],
        ),
      ),
    );
  }
}
