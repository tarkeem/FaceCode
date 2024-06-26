import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCtrl {
  static createAccount(
      {required String email,
      required String password,
      required String firstName,
      required String jobTitle,
      required String lastName,
      required String phone,
      required String city,
      required String country,
      required String state,
      required Function onSuccess,
      required Function onError,
      String? imageUrl}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user!.sendEmailVerification();
      UserModel model = UserModel(
          imageUrl: imageUrl,
          id: credential.user!.uid,
          email: email,
          firstName: firstName,
          jobTitle: jobTitle,
          lastName: lastName,
          phone: phone,
          city: city,
          country: country,
          state: state,);
      
      UserCtr.addUser(model);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
        //print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
        print('The account already exists for that email.');
      }
    }
  }

  static Future<void> login(String email, String password, Function(UserModel) onSuccess, Function(String) onError) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
        if (userDoc.exists) {
          UserModel userModel = UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
          onSuccess(userModel);
        } else {
          onError("User data not found");
        }
      } else {
        onError("User not found");
      }
    } catch (e) {
      onError(e.toString());
    }
  }

  static resetPassword(
      String email, Function onSuccess, Function onError) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      print(e);
      onError(e.message);
    }
  }
}
