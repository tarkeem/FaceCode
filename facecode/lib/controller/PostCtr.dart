// ignore_for_file: avoid_web_libraries_in_flutter

// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/model/entities/Post.dart';
import 'package:facecode/model/entities/comment.dart';

class PostCtr {
  late CollectionReference<Map<String, dynamic>> _roomInstant;

  CollectionReference<Map<String, dynamic>> initializePost() {
    _roomInstant = FirebaseFirestore.instance.collection('posts');

    return _roomInstant;
  }

  Future<void> post({required Post post}) async {
    await _roomInstant.add(post.toFirestore());
  }

  Future<void> getposts() async {
    var res = await _roomInstant.get();

    print(res.docs.length);
    res.docs.forEach((e) {
      var post = Post.fromFirestore(e);
      print(post.textContent);
    });
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

  Future<void> deletePost(String id) async {
    var res = await _roomInstant.doc(id);
    //var old = await res.get();
    res.delete();
  }
   Future<void> addCommentToPost(String postId, Comment comment) async {
    var postRef = _roomInstant.doc(postId);
    await postRef.collection('comments').add(comment.toFirestore());
  }
  Future<List<Comment>> getCommentsForPost(String postId) async {
    var postRef = _roomInstant.doc(postId);
    var commentsSnapshot = await postRef.collection('comments').get();
    return commentsSnapshot.docs.map((e) => Comment.fromFirestore(e)).toList();
  }

//   Future<void> commentPost(String postid,Comment comment)async
//   {

// //TODO
// /*
//     var res= await _roomInstant.doc(id);
//     var old=await res.get();
//     var oldcomments=[...old['comments']];
//     oldcomments.add(comment);
//     res.update({
//       'comments':
//     });

//   }
//   */

// }
}
