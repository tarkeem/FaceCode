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

  static Future<void> likePost(String id) async {
    DocumentReference postRef = getPostsCollection().doc(id);
    DocumentSnapshot snapshot = await postRef.get();

    if (snapshot.exists) {
      Map<String, dynamic> old = snapshot.data() as Map<String, dynamic>;
      int newLikesNum = (old['likesNum']) + 1;
      await postRef.update({'likesNum': newLikesNum});
    } else {
      throw Exception('Post not found');
    }
  }

  static Future<void> disLikePost(String id) async {
    DocumentReference postRef = getPostsCollection().doc(id);
    DocumentSnapshot snapshot = await postRef.get();

    if (snapshot.exists) {
      Map<String, dynamic> old = snapshot.data() as Map<String, dynamic>;
      int newLikesNum = (old['']) + 1;
      await postRef.update({'disLikesNum': newLikesNum});
    } else {
      throw Exception('Post not found');
    }
  }

  static Stream<QuerySnapshot<PostModel>> getTimeLinePosts(
      List<String> followingIds) {
    return getPostsCollection()
        .where('userId', whereIn: followingIds)
        .orderBy('date', descending: true)
        .snapshots();
  }

  // static late CollectionReference<Map<String, dynamic>> _roomInstant;

  // static CollectionReference<Map<String, dynamic>> initializePost() {
  //   _roomInstant = FirebaseFirestore.instance.collection('posts');

  //   return _roomInstant;
  // }

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

  // static Future<List<PostModel>> getPosts() async {
  //   var res = await getPostsCollection.get();
  //   List<PostModel> posts = [];
  //   res.docs.forEach((e) {
  //     var post = PostModel.fromFirestore(e);

  //     posts.add(post);
  //   });

  //   return posts;
  // }

  // static Future<void> likePost(String id) async {
  //   DocumentSnapshot<PostModel> snap = await getPostsCollection().doc(id).get();

  //   snap.update({'likesNum': old['likesNum'] + 1});
  // }

  // static Future<void> DislikePost(String id) async {
  //   var res = await _roomInstant.doc(id);
  //   var old = await res.get();
  //   res.update({'likesNum': old['likesNum'] - 1});
  // }

  // static Future<void> addCommentToPost(Comment comment) async {
  //   try {
  //     var postRef = _roomInstant.doc(comment.postId);

  //     var commentDocRef = postRef.collection('comments').doc();

  //     comment.commentId = commentDocRef.id;

  //     await commentDocRef.set(comment.toFirestore());

  //     print('Comment added successfully');
  //   } catch (error) {
  //     print('Error adding comment: $error');
  //   }
  // }

  // static Future<List<Comment>> getCommentsForPost(String postId) async {
  //   try {
  //     var querySnapshot =
  //         await _roomInstant.doc(postId).collection('comments').get();
  //     List<Comment> comments = [];

  //     querySnapshot.docs.forEach((doc) {
  //       var comment = Comment.fromFirestore(doc);
  //       comments.add(comment);
  //     });

  //     return comments;
  //   } catch (error) {
  //     print('Error getting comments for post: $error');
  //     return [];
  //   }
  // }
}
