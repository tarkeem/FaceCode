import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/model/entities/user_model.dart';

class EditProfileCtr {
  static Future<void> editUser(UserModel model) {
    return UserCtr.getUsersCollection().doc(model.id).update(model.toJson());
  }

  
}
