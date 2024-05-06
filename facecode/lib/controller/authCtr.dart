import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCtrl {
  static createAccount(
      {required String email,
      required String password,
      required String firstName,
      required String jobTitle,
      required String lastName,
      required String phone,
      required String region,
      required Function onSuccess,
      required Function onError,
      required String imageUrl}) async {
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
          region: region);
      
      UserCtr.addUser(model);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
        print('The account already exists for that email.');
      }
    }
  }

  static login(String email, String password, Function onSuccess,
      Function onError) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user!.emailVerified) {
        UserModel? userModel = await UserCtr.getUserById(credential.user!.uid);
        onSuccess(userModel);
      } else {
        onError("Please verify your account");
      }
    } on FirebaseAuthException catch (e) {
      onError(e.message);
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
