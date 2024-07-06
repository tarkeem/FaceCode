import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class MediaController {
  static Future<List<String>> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedImages = await picker.pickMultiImage();

    List<XFile> pickedFiles = [];
    if (pickedImages != null) pickedFiles.addAll(pickedImages);

    if (pickedFiles.isNotEmpty) {
      return pickedFiles.map((file) => file.path).toList();
    }
    return [];
  }

  static Future<String> pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedVideo =
        await picker.pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      return pickedVideo.path;
    }
    return "";
  }

  static Future<List<String>> uploadimages(List<String> mediaPaths) async {
    List<String> mediaUrls = [];
    for (String path in mediaPaths) {
      File file = File(path);
      String fileName = path.split('/').last;
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child('photos')
          .child(fileName)
          .putFile(file);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      mediaUrls.add(downloadUrl);
    }
    return mediaUrls;
  }

  static Future<String> uploadvideo(String videoPath) async {
    File file = File(videoPath);
    String fileName = videoPath.split('/').last;
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child('videos')
        .child(fileName)
        .putFile(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
