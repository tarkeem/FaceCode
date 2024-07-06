// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/controller/commentCtr.dart';
import 'package:facecode/controller/MediaController.dart';
import 'package:facecode/model/entities/comment_model.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/widget/commentWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Comments_sheet extends StatefulWidget {
  UserModel? mainUser;
  String? postId;
  int? postLikes;
  int? postdisLikes;
  bool isNotlikeddd;
  bool isNotdislikeddd;

  Comments_sheet({
    Key? key,
    required this.mainUser,
    required this.postId,
    required this.postLikes,
    required this.postdisLikes,
    required this.isNotlikeddd,
    required this.isNotdislikeddd,
  }) : super(key: key);

  @override
  State<Comments_sheet> createState() => _Comments_sheetState();
}

class _Comments_sheetState extends State<Comments_sheet> {
  TextEditingController commentFeild = TextEditingController();
  int commentsLenght = 0;
  List<String>? images;
  List<CommentModel> Comments = [];
  List<String> uploadedMediaUrls = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getCommentsLength();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return Stack(children: [
      Container(
          padding: EdgeInsets.fromLTRB(10, 40, 10, 5),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 2))),
                      child: TextButton.icon(
                        onPressed: null,
                        icon: Icon(
                          widget.isNotlikeddd
                              ? Icons.thumb_up_off_alt_outlined
                              : Icons.thumb_up_alt,
                          color: provider.myTheme == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                        label: Text(
                          widget.postLikes.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: provider.myTheme == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 2))),
                        child: TextButton.icon(
                          onPressed: null,
                          icon: Icon(
                            Icons.comment,
                            color: provider.myTheme == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                          ),
                          label: Text(
                            commentsLenght.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: provider.myTheme == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 2))),
                      child: TextButton.icon(
                        onPressed: null,
                        icon: Icon(
                          widget.isNotdislikeddd
                              ? Icons.thumb_down_off_alt_outlined
                              : Icons.thumb_down_alt,
                          color: provider.myTheme == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                        label: Text(
                          widget.postdisLikes.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: provider.myTheme == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
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

                    Comments =
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
                      style: Theme.of(context).textTheme.bodyMedium,
                      controller: commentFeild,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        var pickedImages = await MediaController.pickImages();
                        setState(() {
                          images = pickedImages;
                        });
                      },
                      icon: Icon(
                        Icons.perm_media,
                        color: Colors.black,
                      )),
                  commentFeild.text.isEmpty
                      ? SizedBox()
                      : IconButton(
                          onPressed: () async {
                            if (images != null && images!.isNotEmpty) {
                              setState(() {
                                isLoading = true;
                              });
                            }
                            uploadedMediaUrls =
                                await MediaController.uploadimages(images!);

                            CommentModel comment = CommentModel(
                              contents: images != null && images!.isNotEmpty
                                  ? uploadedMediaUrls
                                  : [],
                              userId: provider.userModel!.id,
                              postId: widget.postId,
                              text: commentFeild.text,
                              date: DateTime.now(),
                              likesNum: 0,
                              dislikesNum: 0,
                            );
                            await CommentCtrl.addCommentToPost(comment);

                            commentFeild.clear();
                            setState(() {
                              isLoading = false;
                              commentsLenght = Comments.length;
                            });
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.black,
                          ))
                ],
              )
            ],
          )),
      if (isLoading)
        Center(
          child: Container(
            width: 300,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Uploading Media",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    ]);
  }

  Future<void> getCommentsLength() async {
    final commentsSnapshot =
        await CommentCtrl.getCommentsForPost(widget.postId!).first;
    setState(() {
      commentsLenght = commentsSnapshot.docs.length;
    });
    print("==============================$commentsLenght================");
  }
}
