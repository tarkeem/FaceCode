// ignore_for_file: avoid_web_libraries_in_flutter

// import 'dart:html';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/model/entities/post_model.dart';

class PostCtr {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

    postModel.postId = docRef.id;

    return docRef.set(postModel);
  }

  static Future<void> editPost({required PostModel postModel}) async {
    var postRef = PostCtr.getPostsCollection().doc(postModel.postId);

    return postRef.set(postModel);
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

  static Stream<List<PostModel>> getFavPosts(String userId) {
    try {
      return _firestore
          .collection("Users")
          .doc(userId)
          .snapshots()
          .map((doc) => List<String>.from(doc['favPosts']))
          .asyncMap((favPosts) async {
        List<PostModel> posts = [];

        for (String postId in favPosts) {
          DocumentSnapshot postDoc =
              await _firestore.collection("Posts").doc(postId).get();
          if (postDoc.exists) {
            PostModel postModel =
                PostModel.fromJson(postDoc.data()! as Map<String, dynamic>);
            posts.add(postModel);
          }
        }
        return posts;
      });
    } catch (e) {
      print('Error streaming favorite posts: $e');
      throw e;
    }
  }

  static Future<void> addToFavouritePosts(
      {required String postId, required String userId}) async {
    try {
      await _firestore.collection("Users").doc(userId).update({
        'favPosts': FieldValue.arrayUnion([postId])
      });
    } catch (e) {
      print('Error Finding user: $e');
      throw e;
    }
  }

  static Future<void> removeFromFavouritePosts({
    required String postId,
    required String userId,
  }) async {
    try {
      await _firestore.collection("Users").doc(userId).update({
        'favPosts': FieldValue.arrayRemove([postId]),
      });
    } catch (e) {
      print('Error removing post from favourite posts: $e');
      throw e;
    }
  }

  static Future<int> analysePost(String postDescription) async {
    var apiUrl = 'http://192.168.1.2:8000/predict';
    var inputData = {'input': postDescription};

    var responseJSon = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(inputData),
    );

    var response = jsonDecode(responseJSon.body);

    var prediction = response['prediction'];
    print(prediction);
    return prediction;
    return 1;
  }
}
