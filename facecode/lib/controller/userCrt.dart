import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/entities/user_model.dart';

class UserCtr{
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

  static Future<void> addUser(UserModel userModel){
    var collection = getUsersCollection();
    //Assigning id that taken from signUp 
    var docRef = collection.doc(userModel.id);
    return docRef.set(userModel);
  }

  static Future<UserModel?> getUserById(String userId) async {
    // Implement your logic here to fetch user details from wherever they are stored
    // For example, if you are using Firebase Firestore:
    // Assuming you have a collection named 'users' where each document's ID is the user's ID
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    if (snapshot.exists) {
      // Convert the snapshot data into a UserModel object
      return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    } else {
      // User not found
      return null;
    }
  }
}