import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class Comment {
  String? userId;
  String? commentId;
  String? postId;
  String text;
  DateTime? date;
  int? likesNum;
  int? dislikesNum;

  Comment({
    required this.userId,
    required this.postId,
    required this.text,
    required this.date,
    required this.likesNum,
    required this.dislikesNum,
    this.commentId,
  });
  factory Comment.fromFirestore(
    QueryDocumentSnapshot<Object?> snapshot,
  ) {
    final data = snapshot.data() as Map;
    return Comment(
      commentId: snapshot.id,
      userId: data['userId'],
      postId: data['postId'],
      text: data['text'],
      date: (data['date'] as Timestamp).toDate(),
      likesNum: data['likesNum'],
      dislikesNum: data['dislikesNum'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "postId": postId,
      "userId": userId,
      "date": date,
      "likesNum": likesNum,
      "dislikesNum": dislikesNum,
      "text": text,
      "commentId":commentId,
    };
  }
}
