// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class CommentModel {
  String? userId;
  String? commentId;
  String? postId;
  String? text;
  DateTime? date;
  int? likesNum;
  int? dislikesNum;
  List<String?>? contents = [];
  List<String>? likersList = [];
  List<String>? dislikersList = [];

  CommentModel({
    required this.userId,
    required this.postId,
    required this.text,
    required this.date,
    required this.likesNum,
    required this.dislikesNum,
    this.contents,
    this.commentId,
    this.dislikersList,
    this.likersList,
  });
  CommentModel.fromJson(Map<String, dynamic> json)
      : this(
          commentId: json['commentId'],
          userId: json['userId'],
          postId: json['postId'],
          contents: List<String>.from(json['contents'] ?? []),
          text: json['text'],
          date: (json['date'] as Timestamp).toDate(),
          likesNum: json['likesNum'],
          dislikesNum: json['dislikesNum'],
          likersList: List<String>.from(json['likersList'] ?? []),
          dislikersList: List<String>.from(json['dislikersList'] ?? []),
        );

  Map<String, dynamic> toJson() {
    return {
      "postId": postId,
      "userId": userId,
      "date": date,
      "likesNum": likesNum,
      "dislikesNum": dislikesNum,
      "text": text,
      "commentId": commentId,
      "contents": contents,
      "likersList": likersList,
      "dislikersList": dislikersList,
    };
  }
}
