import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageCtr {
  static Future<List<String?>?> pickimage() async {
    final ImagePicker picker = ImagePicker();
    List<String?> mediaFiles = [];

    final List<XFile>? pickedImages = await picker.pickMultiImage();
    if (pickedImages != null) {
      for (var pickedFile in pickedImages) {
        File file = File(pickedFile.path);
        Uint8List fileBytes = await file.readAsBytes();
        String base64String = base64Encode(fileBytes);
        mediaFiles.add(base64String);
      }
    }

    return mediaFiles;
  }

  static Future<List<Uint8List>> getImages(List<String?> mediaFiles) async {
    List<Uint8List> imagesBytes = [];

    if (mediaFiles != null) {
      for (var fil in mediaFiles) {
        if (fil != null) {
          Uint8List imageBytes = base64Decode(fil);
          imageBytes = Uint8List.fromList(imageBytes);

          imagesBytes.add(imageBytes);
        }
      }
    }

    return imagesBytes;
  }
}
