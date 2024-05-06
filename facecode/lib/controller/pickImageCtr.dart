import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

//storing image in storage
class PickImageCtr {
  static pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print("No Image Selected");
  }
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<String>uploadImagetoStorage(String childName , Uint8List file) async {
    Reference ref = _storage.ref().child(childName).child("path");
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //Future<String>saveData({required String name , required String})
}
