import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/model/entities/comment_model.dart';

class CommentCtrl {
  static CollectionReference<CommentModel> getCommentsCollection() {
    return FirebaseFirestore.instance
        .collection("comments")
        .withConverter<CommentModel>(
      fromFirestore: (snapshot, _) {
        return CommentModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static Future<void> addCommentToPost(CommentModel comment) async {
    try {
      var postRef = PostCtr.getPostsCollection().doc(comment.postId);
      var commentDocRef = postRef.collection('comments').doc();

      comment.commentId = commentDocRef.id;

      await commentDocRef.set(comment.toJson());

      print('Comment added successfully');
    } catch (error) {
      print('Error adding comment: $error');
    }
  }

  static Stream<QuerySnapshot<CommentModel>> getCommentsForPost(String postId) {
    var postRef = PostCtr.getPostsCollection().doc(postId);
    return postRef
        .collection('comments')
        .withConverter<CommentModel>(
          fromFirestore: (snapshot, _) =>
              CommentModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson(),
        )
        .orderBy('date', descending: true)
        .snapshots();
  }

  static Future<void> likeComment(String commentId, String postId) async {
    try {
      var res = await FirebaseFirestore.instance
          .collection('Posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId);
      var old = await res.get();
      if (old.exists) {
        res.update({'likesNum': old['likesNum'] + 1});
      } else {
        print('Document does not exist!');
      }
    } catch (error) {
      print('Error liking comment: $error');
    }
  }

  static Future<void> removeLikeComment(String commentId, String postId) async {
    try {
      var res = await FirebaseFirestore.instance
          .collection('Posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId);
      var old = await res.get();
      if (old.exists) {
        res.update({'likesNum': old['likesNum'] - 1});
      } else {
        print('Document does not exist!');
      }
    } catch (error) {
      print('Error removing like from comment: $error');
    }
  }

  static Future<void> dislikeComment(String commentId, String postId) async {
    try {
      var res = await FirebaseFirestore.instance
          .collection('Posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId);
      var old = await res.get();
      if (old.exists) {
        res.update({'dislikesNum': old['dislikesNum'] + 1});
      } else {
        print('Document does not exist!');
      }
    } catch (error) {
      print('Error disliking comment: $error');
    }
  }

  static Future<void> removeDisLikeComment(
      String commentId, String postId) async {
    try {
      var res = await FirebaseFirestore.instance
          .collection('Posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId);
      var old = await res.get();
      if (old.exists) {
        res.update({'dislikesNum': old['dislikesNum'] - 1});
      } else {
        print('Document does not exist!');
      }
    } catch (error) {
      print('Error removing dislike from comment: $error');
    }
  }

  static Future<void> deleteComment(String commentId, String postId) async {
    try {
      var postRef = PostCtr.getPostsCollection().doc(postId);
      var commentDocRef = postRef.collection('comments').doc(commentId);

      await commentDocRef.delete();
      print('Comment deleted successfully');
    } catch (error) {
      print('Error deleting comment: $error');
    }
  }
}
