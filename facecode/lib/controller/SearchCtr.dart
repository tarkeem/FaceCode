import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/model/entities/user_model.dart';

class SearchCtr {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Stream<List<UserModel>> searchUsers(String query) {
    String normalizedQuery = query.toLowerCase();

    return _firestore
        .collection('Users')
        .where('fullNameLowerCase', isGreaterThanOrEqualTo: normalizedQuery)
        .where('fullNameLowerCase', isLessThan: normalizedQuery + 'z')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) {
                return UserModel.fromJson(doc.data() as Map<String, dynamic>);
              })
              .toList();
        });
  }
}
//   void searchUsers(String firstName, String lastName) async {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//       .collection('Users')
//       .where('firstName', isEqualTo: firstName)
//       .where('lastName', isEqualTo: lastName)
//       .get();

//     if (querySnapshot.docs.isNotEmpty) {
//       querySnapshot.docs.forEach((doc) {
//         var userData = doc.data();
//         print('User found: $userData');
//       });
//     }
//     else {
//       print('User not found');
//     }
// }

//   void searchPosts(String searchTerm) async {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('posts')
//         .where('textContent', isEqualTo: searchTerm)
//         .get();

//     if (querySnapshot.docs.isNotEmpty) {
//       querySnapshot.docs.forEach((doc) {
//         var postData = doc.data();
//         print('Post found: $postData');
//       });
//     }
//     else {
//       print('Post not found');
//     }
//   }

  ////////////////////////////////////////////////////////////////lesa hn3ml el groups////////////////////////////////////////////
/*  
  void searchGroups(String searchTerm) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('groups')
        .where('name', isEqualTo: searchTerm)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((doc) {
        var groupData = doc.data();
        print('Group found: $groupData');
      });
    } 
    else {
      print('Group not found');
    }
  }
*/
//}
