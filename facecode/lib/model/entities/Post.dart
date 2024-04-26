// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/model/entities/comment.dart';

class Post {
  String? userId;
  String? textContent;
  List<String?>? contents;
  List<Comment?>? comments;
  int? likesNum;
  DateTime date;

  Post({
    required this.contents,
    required this.comments,
    required this.date,
    required this.likesNum,
    required this.textContent,
    required this.userId,
  });

  factory Post.fromFirestore(
    QueryDocumentSnapshot<Object?> snapshot,
  ) {
    final data = snapshot.data() as Map;
    return Post(
        comments: [...data['comments']],
        contents: [...data['contents']],
        date: data['date'],
        likesNum: data['likesNum'],
        textContent: data['textContent'],
        userId: data['userId']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "comments": comments,
      "contents": contents,
      "date": date,
      "likesNum": likesNum,
      "textContent": textContent,
      "userId": userId
    };
  }
}
