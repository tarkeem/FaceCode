// ignore_for_file: avoid_web_libraries_in_flutter

// import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/model/entities/Post.dart';
import 'package:facecode/model/entities/comment.dart';
import 'package:flutter/material.dart';

class PostCtr {
   late CollectionReference<Map<String, dynamic>> _roomInstant;

   CollectionReference<Map<String, dynamic>> initializePost() {
    _roomInstant = FirebaseFirestore.instance.collection('posts');

    return _roomInstant;
  }

   Future<int> analysePost(String postDescription) async {
//   // var apiUrl = 'http://192.168.1.12:8000/predict';
//   // var inputData = {'input': postDescription};

//   // var responseJSon = await http.post(
//   //   Uri.parse(apiUrl),
//   //   headers: {'Content-Type': 'application/json'},
//   //   body: jsonEncode(inputData),
//   // );

//   // var response = jsonDecode(responseJSon.body);

//   // var prediction = response['prediction'];
//   int prediction = 1;
//   print(prediction);

//   if (prediction == 1) {
//     showAcc(context);
//   } else {
//     showRejec(context);
    return 1;
  }

   Future<int> addPost({required Post post}) async {
    int result = await analysePost(post.textContent!);
    if (result == 0) {
      return 0;
    } else {
      post.postId = FirebaseFirestore.instance.collection('posts').doc().id;
      await _roomInstant.add(post.toFirestore());
      return 1;
    }
  }

   Future<List<Post>> getPosts() async {
    var res = await _roomInstant.get();
    List<Post> posts = [];
    res.docs.forEach((e) {
      var post = Post.fromFirestore(e);

      posts.add(post);
    });

    return posts;
  }

   Future<void> getpostsPagination(int limit) async {
    var res =
        await _roomInstant.orderBy('date', descending: true).limit(limit).get();
    res.docs.forEach((e) {
      var post = Post.fromFirestore(e);
      print(post.textContent);
    });
  }

   Future<void> likePost(String id) async {
    var res = await _roomInstant.doc(id);
    var old = await res.get();
    res.update({'likesNum': old['likesNum'] + 1});
  }

   Future<void> DislikePost(String id) async {
    var res = await _roomInstant.doc(id);
    var old = await res.get();
    res.update({'likesNum': old['likesNum'] - 1});
  }

   Future<void> deletePost(String id) async {
    var res = await _roomInstant.doc(id);
    res.delete();
  }

   Future<void> addCommentToPost(Comment comment) async {
    try {
      var postRef = _roomInstant.doc(comment.postId);

      var commentDocRef = postRef.collection('comments').doc();

      comment.commentId = commentDocRef.id;

      await commentDocRef.set(comment.toFirestore());

      print('Comment added successfully');
    } catch (error) {
      print('Error adding comment: $error');
    }
  }

   Future<List<Comment>> getCommentsForPost(String postId) async {
    try {
      var querySnapshot =
          await _roomInstant.doc(postId).collection('comments').get();
      List<Comment> comments = [];

      querySnapshot.docs.forEach((doc) {
        var comment = Comment.fromFirestore(doc);
        comments.add(comment);
      });

      return comments;
    } catch (error) {
      print('Error getting comments for post: $error');
      return [];
    }
  }
}
