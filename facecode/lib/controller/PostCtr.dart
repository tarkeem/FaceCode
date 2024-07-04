// ignore_for_file: avoid_web_libraries_in_flutter

// import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/model/entities/post_model.dart';

class PostCtr {
  static CollectionReference<PostModel> getPostsCollection() {
    return FirebaseFirestore.instance
        .collection("Posts")
        .withConverter<PostModel>(
      fromFirestore: (snapshot, _) {
        return PostModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static Future<void> addPost({required PostModel postModel}) async {
    var collection = getPostsCollection();
    var docRef = collection.doc();

    // Assign the document ID to the postId field of postModel
    postModel.postId = docRef.id;

    return docRef.set(postModel);
  }

  static Future<void> deletePost(String id) {
    return getPostsCollection().doc(id).delete();
  }

  static Stream<QuerySnapshot<PostModel>> getProfilePosts(String id) {
    return getPostsCollection()
        .where('userId', isEqualTo: id)
        .orderBy('date', descending: true)
        .snapshots();
  }

  static Future<void> likePost(
      String postID, String userId, bool Notliked) async {
    try {
      var postRef = PostCtr.getPostsCollection().doc(postID);

      var old = await postRef.get();
      if (old.exists) {
        if (Notliked) {
          postRef.update({
            'likesNum': old['likesNum'] + 1,
            'likersList': FieldValue.arrayUnion([userId])
          });
        } else {
          postRef.update({
            'likesNum': old['likesNum'] - 1,
            'likersList': FieldValue.arrayRemove([userId])
          });
        }
      } else {
        print('Document does not exist!');
      }
    } catch (error) {
      print('Error liking comment: $error');
    }
  }

  static Future<void> dislikePost(
      String postID, String userId, bool isNotdisliked) async {
    try {
      var postRef = PostCtr.getPostsCollection().doc(postID);

      var old = await postRef.get();
      if (old.exists) {
        if (isNotdisliked) {
          postRef.update({
            'disLikesNum': old['disLikesNum'] + 1,
            'dislikersList': FieldValue.arrayUnion([userId])
          });
        } else {
          postRef.update({
            'disLikesNum': old['disLikesNum'] - 1,
            'dislikersList': FieldValue.arrayRemove([userId])
          });
        }
      } else {
        print('Document does not exist!');
      }
    } catch (error) {
      print('Error liking comment: $error');
    }
  }

  static Stream<QuerySnapshot<PostModel>> getTimeLinePosts(
      List<String> followingIds) {
    return getPostsCollection()
        .where('userId', whereIn: followingIds)
        .orderBy('date', descending: true)
        .snapshots();
  }

//   static Future<int> analysePost(String postDescription) async {
// //   // var apiUrl = 'http://192.168.1.12:8000/predict';
// //   // var inputData = {'input': postDescription};

// //   // var responseJSon = await http.post(
// //   //   Uri.parse(apiUrl),
// //   //   headers: {'Content-Type': 'application/json'},
// //   //   body: jsonEncode(inputData),
// //   // );

// //   // var response = jsonDecode(responseJSon.body);

// //   // var prediction = response['prediction'];
// //   int prediction = 1;
// //   print(prediction);

// //   if (prediction == 1) {
// //     showAcc(context);
// //   } else {
// //     showRejec(context);
//     return 1;
//   }
}
