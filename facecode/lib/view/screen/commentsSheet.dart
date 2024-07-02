// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/controller/commentCtr.dart';
import 'package:facecode/model/entities/comment_model.dart';
import 'package:facecode/model/entities/post_model.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/widget/commentWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return Container(
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
              child: StreamBuilder(
                stream: CommentCtrl.getCommentsForPost(widget.postId!),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<CommentModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Something went wrong"),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: Text("Try again"),
                        )
                      ],
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text("Start The Discussion"),
                    );
                  }

                  List<CommentModel> Comments =
                      snapshot.data!.docs.map((e) => e.data()).toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: Comments.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CommentWidget(
                          comment: Comments[index],
                        ),
                      );
                    },
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
                      imageUrl: provider.userModel!.imageUrl ?? "",
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
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
                      CommentModel comment = CommentModel(
                        userId: provider.userModel!.id,
                        postId: widget.postId,
                        text: commentFeild.text,
                        date: DateTime.now(),
                        likesNum: 0,
                        dislikesNum: 0,
                      );
                      await CommentCtrl.addCommentToPost(comment);
                      commentFeild.clear();
                    },
                    icon: Icon(Icons.send))
              ],
            )
          ],
        ));
  }
}


