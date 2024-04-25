import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class Comment {
  final String commentId;
  final String userId;
  final String postId;
  final String text;
  final DateTime time;
  final int likesNum;
  final int dislikesNum;

  Comment(
      {required this.commentId,
      required this.userId,
      required this.postId,
      required this.text,
      required this.time,
      required this.likesNum,
      required this.dislikesNum});
  factory Comment.fromFirestore(
    QueryDocumentSnapshot<Object?> snapshot,
  ) {
    final data = snapshot.data() as Map;
    return Comment(
      commentId: snapshot.id,
      userId: data['userId'],
      postId: data['postId'],
      text: data['text'],
      time: data['time'],
      likesNum: data['likesNum'],
      dislikesNum: data['dislikesNum'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "commentId": commentId,
      "postID" : postId,
      "userId": userId,
      "time": time,
      "likesNum": likesNum,
      "dislikesNum": dislikesNum,
      "text": text,
    };
  }
}
