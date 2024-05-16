import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/model/entities/user_model.dart';

class UserCtr {
  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static Future<void> addUser(UserModel userModel) {
    var collection = getUsersCollection();
    //Assigning id that taken from signUp
    var docRef = collection.doc(userModel.id);
    return docRef.set(userModel);
  }

  static Future<UserModel?> getUserById(String userId) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    if (snapshot.exists) {
      // Convert the snapshot data into a UserModel object
      return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    } else {
      // User not found
      return null;
    }
  }

  //This function takes map<String , dynamic> and add them in database
  static Future<void> addOrUpdateAdditionalAttributes(
      String userId, Map<String, dynamic> additionalAttributes) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(userId);

    // get user from Firestore
    DocumentSnapshot snapshot = await docRef.get();

    if (snapshot.exists) {
      await docRef.update(additionalAttributes);
    } else {
      // User not found
      print('User not found');
    }
  }

  static Future<void> updateProfilePicture(String id, String imageUrl) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(id);
    DocumentSnapshot snapshot = await docRef.get();
    if (snapshot.exists) {
      UserModel userModel = snapshot.data() as UserModel;
      userModel.imageUrl = imageUrl;
      await docRef.set(userModel);
    } else {
      print('User not found');
    }
  }
}
