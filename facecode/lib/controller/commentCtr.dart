import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/model/entities/comment_model.dart';

class CommentCtrl {
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

  static Future<void> likeComment(
      CommentModel comment, bool Notliked, String commenterID) async {
    try {
      var postRef = PostCtr.getPostsCollection().doc(comment.postId);
      var commentDocRef = postRef.collection('comments').doc(comment.commentId);

      var old = await commentDocRef.get();
      if (old.exists) {
        if (Notliked) {
          commentDocRef.update({
            'likesNum': old['likesNum'] + 1,
            'likersList': FieldValue.arrayUnion([commenterID])
          });
        } else {
          commentDocRef.update({
            'likesNum': old['likesNum'] - 1,
            'likersList': FieldValue.arrayRemove([commenterID])
          });
        }
      } else {
        print('Document does not exist!');
      }
    } catch (error) {
      print('Error liking comment: $error');
    }
  }

  static Future<void> dislikeComment(
      CommentModel comment, bool Notliked, String commenterID) async {
    try {
      var postRef = PostCtr.getPostsCollection().doc(comment.postId);
      var commentDocRef = postRef.collection('comments').doc(comment.commentId);

      var old = await commentDocRef.get();
      if (old.exists) {
        if (Notliked) {
          commentDocRef.update({
            'dislikesNum': old['dislikesNum'] + 1,
            'dislikersList': FieldValue.arrayUnion([commenterID])
          });
        } else {
          commentDocRef.update({
            'dislikesNum': old['dislikesNum'] - 1,
            'dislikersList': FieldValue.arrayRemove([commenterID])
          });
        }
      } else {
        print('Document does not exist!');
      }
    } catch (error) {
      print('Error liking comment: $error');
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
