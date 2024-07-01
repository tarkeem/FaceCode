// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? userId;
  String? textContent;
  String? postId;
  List<String?>? contents = [];
  int likesNum = 0;
  int disLikesNum = 0;
  DateTime? date;

  PostModel({
    this.contents,
    required this.date,
    required this.likesNum,
    required this.disLikesNum,
    required this.textContent,
    required this.userId,
    required this.postId,
  });

  PostModel.fromJson(Map<String, dynamic> json)
      : this(
          postId: json['id'],
          contents: List<String>.from(json['contents'] ?? []),
          date: (json['date'] as Timestamp).toDate(),
          likesNum: json['likesNum'],
          disLikesNum: json['disLikesNum'],
          textContent: json['textContent'],
          userId: json['userId'],
        );

  Map<String, dynamic> toJson() {
    return {
      "contents": contents,
      "date": date,
      "likesNum": likesNum,
      "textContent": textContent,
      "userId": userId,
      "disLikesNum" : disLikesNum
    };
  }
}
