import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/model/entities/comment.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/view/widget/commentWidget.dart';
import 'package:flutter/material.dart';

class Comments_sheet extends StatefulWidget 
{
  final String postId;
  final int postLikes;
  const Comments_sheet({
    super.key,
    required this.postId,
    required this.postLikes,
  });

  @override
  State<Comments_sheet> createState() => _Comments_sheetState();
}

class _Comments_sheetState extends State<Comments_sheet> {
  TextEditingController commentFeild = TextEditingController();
  List<Comment>? comments;

  @override
  void initState() {
    super.initState();

    getCommentsByPostID();
  }

  Future<void> getCommentsByPostID() async {
    PostCtr.initializePost();
    List<Comment> commentsRef = await PostCtr.getCommentsForPost(widget.postId);
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
    UserModel user = ModalRoute.of(context)!.settings.arguments as UserModel;

    return  Container(
        padding: EdgeInsets.fromLTRB(10, 40, 10, 5),
        child: Column(
          children: [
            Container(
              decoration:
                  BoxDecoration(border: Border(bottom: BorderSide(width: 2))),
              child: TextButton.icon(
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                icon: Icon(Icons.favorite),
                label: Text(
                  widget.postLikes.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                        widget.postId,
                        user.id,
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

void addComment(String commentText, String postId ,String? userID) async {
  Comment comment = Comment(
    userId: userID,
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
