import 'package:cached_network_image/cached_network_image.dart';
import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/model/entities/comment.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/view/widget/commentWidget.dart';
import 'package:flutter/material.dart';

class Comments_sheet extends StatefulWidget {
  UserModel? mainUser;
  String? postId;
  int? postLikes;
  Comments_sheet({
    super.key,
    required this.postId,
    required this.postLikes,
    required this.mainUser,
  });

  @override
  State<Comments_sheet> createState() => _Comments_sheetState();
}

class _Comments_sheetState extends State<Comments_sheet> {
  TextEditingController commentFeild = TextEditingController();
  List<Comment>? comments;
  UserModel? mainUser;

  @override
  void initState() {
    super.initState();

    getCommentsByPostID();
  }

  Future<void> getCommentsByPostID() async {
    PostCtr.initializePost();
    List<Comment> commentsRef =
        await PostCtr.getCommentsForPost(widget.postId!);
    mainUser = await widget.mainUser;

    setState(() {
      comments = [];
      comments = commentsRef;
    });
  }

  void refreshTimeLine() async {
    await getCommentsByPostID();
  }

  @override
  Widget build(BuildContext context) {
    return mainUser == null
        ? SizedBox()
        : Container(
            padding: EdgeInsets.fromLTRB(10, 40, 10, 5),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 2))),
                  child: TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                    icon: Icon(Icons.favorite),
                    label: Text(
                      widget.postLikes.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: comments == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: comments!.length,
                          itemBuilder: (context, index) {
                            return CommentWidget(
                              refreshTimeline: refreshTimeLine,
                              comment: comments![index],
                            );
                          },
                        ),
                ),
                Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.10,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: mainUser!.imageUrl ?? "",
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Expanded(
                      child: TextField(
                        controller: commentFeild,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                        ),
                      ),
                    ),
                    SizedBox(),
                    IconButton(
                        onPressed: () async {
                          addComment(
                            commentFeild.text,
                            widget.postId!,
                            mainUser!.id!,
                          );
                          setState(() {
                            getCommentsByPostID();
                          });
                          commentFeild.clear();
                        },
                        icon: Icon(Icons.send))
                  ],
                )
              ],
            ));
  }
}

void addComment(String commentText, String postId, String userId) async {
  Comment comment = Comment(
    userId: userId,
    postId: postId,
    text: commentText,
    date: DateTime.now(),
    likesNum: 0,
    dislikesNum: 0,
  );
  PostCtr.initializePost();
  await PostCtr.addCommentToPost(comment);
  print("Comment added successfully");
}
