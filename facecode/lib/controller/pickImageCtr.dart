import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageCtr {
  static Future<void> pickAndUploadImage(
      BuildContext context, Function(Uint8List?) setImage , String imageUrl) async {
    //Picking Image
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

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
      // Load image into memory
      Uint8List imageData = await File(file.path).readAsBytes();
      // Set the image data and update the UI
      setImage(imageData);
    } catch (error) {
      print("Error uploading image: $error");
    }
  }
}
