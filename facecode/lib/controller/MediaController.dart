import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class MediaController {
  static Future<List<String>?> pickMedia() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedFiles =
        await picker.pickMultiImage(); 

    

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      return pickedFiles.map((file) => file.path).toList();
    }
    return null;
  }

  static Future<List<String>> uploadMedia(List<String> mediaPaths) async {
    List<String> mediaUrls = [];
    for (String path in mediaPaths) {
      File file = File(path);
      String fileName = path.split('/').last;
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child('posts')
          .child(fileName)
          .putFile(file);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      mediaUrls.add(downloadUrl);
      
    }
    return mediaUrls;
  }
}
