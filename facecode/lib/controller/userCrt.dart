import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/model/entities/user_model.dart';

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
}