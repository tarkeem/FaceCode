// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? userId;
  String? textContent;
  String? postId;
  List<String?>? contents = [];
  int likesNum = 0;
  DateTime? date;

  Post({
    this.contents,
    required this.date,
    required this.likesNum,
    required this.textContent,
    required this.userId,
    this.postId,
  });

  factory Post.fromFirestore(
    QueryDocumentSnapshot<Object?> snapshot,
  ) {
    final data = snapshot.data() as Map;
    return Post(
        postId: snapshot.id,
        contents: [...data['contents']],
        date: (data['date'] as Timestamp).toDate(),
        likesNum: data['likesNum'],
        textContent: data['textContent'],
        userId: data['userId']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "contents": contents,
      "date": date,
      "likesNum": likesNum,
      "textContent": textContent,
      "userId": userId
    };
  }
}
