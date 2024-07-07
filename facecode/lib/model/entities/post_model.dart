import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? userId;
  String? textContent;
  String? postId;
  List<String>? images ;
  String? video;

  int likesNum = 0;
  int disLikesNum = 0;
  DateTime? date;
  List<String>? likersList = [];
  List<String>? dislikersList = [];

  PostModel({
    // this.Comments,
    this.images,
    required this.date,
    required this.likesNum,
    required this.disLikesNum,
    required this.textContent,
    required this.userId,
    this.postId,
    this.video,
    this.dislikersList,
    this.likersList,
  });

  PostModel.fromJson(Map<String, dynamic> json)
      : this(
          postId: json['postId'],
          video: json['video'],
          images: List<String>.from(json['images'] ?? []),
          date: (json['date'] as Timestamp).toDate(),
          likesNum: json['likesNum'],
          disLikesNum: json['disLikesNum'],
          textContent: json['textContent'],
          userId: json['userId'],
          likersList: List<String>.from(json['likersList'] ?? []),
          dislikersList: List<String>.from(json['dislikersList'] ?? []),
        );

  Map<String, dynamic> toJson() {
    return {
      "postId": postId,
      "video": video,
      "images": images,
      "date": date,
      "likesNum": likesNum,
      "textContent": textContent,
      "userId": userId,
      "disLikesNum": disLikesNum,
      "likersList": likersList,
      "dislikersList": dislikersList,
    };
  }
}
