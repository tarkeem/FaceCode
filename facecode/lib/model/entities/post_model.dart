import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/model/entities/comment_model.dart';

class PostModel {
  String? userId;
  String? textContent;
  String? postId;
  List<String?>? contents = [];
  int likesNum = 0;
  int disLikesNum = 0;
  DateTime? date;
  // List<CommentModel>? Comments;

  PostModel({
    // this.Comments,
    this.contents,
    required this.date,
    required this.likesNum,
    required this.disLikesNum,
    required this.textContent,
    required this.userId,
    this.postId,
  });

  PostModel.fromJson(Map<String, dynamic> json)
      : this(
          postId: json['postId'],
          contents: List<String>.from(json['contents'] ?? []),
          // Comments: List<CommentModel>.from(json['Comments'] ?? []),
          date: (json['date'] as Timestamp).toDate(),
          likesNum: json['likesNum'],
          disLikesNum: json['disLikesNum'],
          textContent: json['textContent'],
          userId: json['userId'],
        );

  Map<String, dynamic> toJson() {
    return {
      "postId": postId,
      "contents": contents,
      // "Comments": Comments,
      "date": date,
      "likesNum": likesNum,
      "textContent": textContent,
      "userId": userId,
      "disLikesNum": disLikesNum,
    };
  }
}
