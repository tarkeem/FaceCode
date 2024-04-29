import 'package:cloud_firestore/cloud_firestore.dart';

class CommentCtrl {
  Future<void> likeComment(String commentId, String postId) async {
    var res = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId);
    var old = await res.get();
    res.update({'likesNum': old['likesNum'] + 1});
  }

  Future<void> removeLikeComment(String commentId, String postId) async {
    var res = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId);
    var old = await res.get();
    res.update({'likesNum': old['likesNum'] + -1});
  }

  Future<void> dislikeComment(String commentId, String postId) async {
    var res = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId);
    var old = await res.get();
    res.update({'dislikesNum': old['dislikesNum'] + 1});
  }

  Future<void> removeDisLikeComment(String commentId, String postId) async {
    var res = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId);
    var old = await res.get();
    res.update({'dislikesNum': old['dislikesNum'] + -1});
  }

  Future<void> deleteComment(String commentId,String postId) async {
    var res = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId);
    res.delete();
  }
}
