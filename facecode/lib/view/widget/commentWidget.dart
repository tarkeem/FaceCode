import 'package:facecode/controller/commentCtr.dart';
import 'package:facecode/model/entities/comment.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class CommentWidget extends StatefulWidget {
  final Comment comment;
  final VoidCallback refreshTimeline;

  const CommentWidget({
    super.key,
    required this.comment,
    required this.refreshTimeline,
  });

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  UserModel? user;
  String? userName;
  String? commentText;
  DateTime? date;
  int likesCount = 0;
  int dislikesCount = 0;
  bool isExpanded = false;
  String? postId;
  String? commentId;

  @override
  void initState() {
    super.initState();

    getCommentData();
    getUserData();
  }

  void getCommentData() async {
      commentId = widget.comment.commentId;
      postId = widget.comment.postId;
      commentText = widget.comment.text;
      likesCount = widget.comment.likesNum!;
      dislikesCount = widget.comment.dislikesNum!;
      date = widget.comment.date;
      print("=====================================");

      print(widget.comment.postId);
    
  }

  void getUserData() async {

    setState(() {
      //user = userr;
      if (user != null) {
        userName = user!.firstName! + " " + user!.lastName!;
      }
    });
  }

  Future<bool?> _handleLikeButtonPress(bool isLiked) async {
    try {

      !isLiked
          ? await CommentCtrl.likeComment(
              widget.comment.commentId!, widget.comment.postId!)
          : await CommentCtrl.removeLikeComment(
              widget.comment.commentId!, widget.comment.postId!);

      return !isLiked;
    } catch (error) {
      setState(() {
        if (!isLiked) {
          likesCount++;
        } else {
          likesCount--;
        }
      });
      print('Error updating likes count: $error');
      return isLiked;
    }
  }

  Future<bool?> _handledisLikeButtonPress(bool isdisLiked) async {
    try {

      !isdisLiked
          ? await CommentCtrl.dislikeComment(
              widget.comment.commentId!, widget.comment.postId!)
          : await CommentCtrl.removeDisLikeComment(
              widget.comment.commentId!, widget.comment.postId!);

      return !isdisLiked;
    } catch (error) {
      setState(() {
        if (!isdisLiked) {
          likesCount++;
        } else {
          likesCount--;
        }
      });
      print('Error updating likes count: $error');
      return isdisLiked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(30)),
            child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage("images/mark.jpg"),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        userName ?? "",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        CommentCtrl.deleteComment(commentId!, postId!);
                        widget.refreshTimeline();
                      },
                      child: Text(
                        "Delete Post",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    PopupMenuItem(
                      child: Text(
                        "copy Post",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Column(children: [
                    Text(
                      commentText!.length > 50
                          ? isExpanded
                              ? commentText!
                              : commentText!.substring(0, 50)
                          : commentText!,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    commentText!.length > 50
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Text(
                              isExpanded ? "Read Less" : "Read More",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        : SizedBox(),
                  ]),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LikeButton(
                  onTap: (isLiked) => _handleLikeButtonPress(isLiked),
                  circleSize: 50,
                  likeCountPadding: EdgeInsets.only(right: 10),
                  likeBuilder: (isLiked) => isLiked
                      ? Icon(
                          Icons.thumb_up,
                        )
                      : Icon(Icons.thumb_up_outlined),
                  likeCount: likesCount,
                  countBuilder: (int? count, bool isLiked, String text) {
                    return Text(
                      text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
                LikeButton(
                  onTap: (isdisLiked) => _handledisLikeButtonPress(isdisLiked),
                  circleSize: 50,
                  likeBuilder: (isdisLiked) => isdisLiked
                      ? Icon(
                          Icons.thumb_down,
                        )
                      : Icon(Icons.thumb_down_outlined),
                  likeCount: likesCount,
                  countBuilder: (int? count, bool isdisLiked, String text) {
                    return Text(
                      text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Reply ...",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
