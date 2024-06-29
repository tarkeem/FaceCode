// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/model/entities/Post.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/view/screen/commentsSheet.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class PostWidget extends StatefulWidget {
  Post? postC;
  UserModel? mainUser;
  VoidCallback? refreshTimeline;
  PostWidget({
    super.key,
    required this.postC,
    required this.mainUser,
    required this.refreshTimeline,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  String? selectedOption;
  UserModel? user;
  String? userName = null;
  String? jobTitle = null;
  String? postID = null;
  String? postText = null;
  DateTime? date = null;
  int likesCount = 0;
  bool isExpanded = false;

  @override
  void initState() {
    getPostData();
    getUserData();
    super.initState();
  }

  getPostData() {
    postID = widget.postC!.postId!;
    postText = widget.postC!.textContent!;
    likesCount = widget.postC!.likesNum;
    date = widget.postC!.date;
  }

  void getUserData() async {
    UserModel? userr = await UserCtr.getUserById(widget.postC!.userId!);
    setState(() {
      user = userr;
    });
    if (user != null) {
      userName = user!.firstName! + " " + user!.lastName!;
      jobTitle = user!.jobTitle;
    }
  }

  Future<bool?> _handleLikeButtonPress(bool isLiked) async {
    try {
      PostCtr.initializePost();

      !isLiked
          ? await PostCtr.likePost(postID!)
          : await PostCtr.DislikePost(postID!);

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

  Widget build(BuildContext context) {
    return user == null
        ? SizedBox()
        : Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                ListTile(
                    leading: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: user!.imageUrl ?? "",
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
                    title: Text(
                      userName ?? "",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                    ),
                    subtitle: Text(
                      jobTitle!,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () {
                            PostCtr.initializePost();
                            PostCtr.deletePost(postID!);
                            widget.refreshTimeline!();
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
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Column(children: [
                    Text(
                      postText!.length > 50
                          ? isExpanded
                              ? postText!
                              : postText!.substring(0, 50)
                          : postText!,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    postText!.length > 50
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Text(
                              isExpanded ? "Read Less" : "Read More",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 17),
                            ),
                          )
                        : SizedBox(),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  child: Container(
                      width: double.infinity,
                      color: Colors.black,
                      child: Image.network(
                        "https://th.bing.com/th/id/OIP.x5jNdmpoihtBEU9WxHCPTgAAAA?rs=1&pid=ImgDetMain",
                        fit: BoxFit.fill,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: LikeButton(
                          onTap: (isLiked) => _handleLikeButtonPress(isLiked),
                          circleSize: 50,
                          likeBuilder: (isLiked) => isLiked
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(Icons.favorite),
                          likeCount: likesCount,
                          countBuilder:
                              (int? count, bool isLiked, String text) {
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
                      ),
                      Expanded(
                          child: IconButton(
                        icon: Icon(Icons.comment),
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Comments_sheet(
                                  postId: postID!,
                                  postLikes: likesCount,
                                  mainUser: widget.mainUser!,
                                ),
                              );
                            },
                          );
                        },
                      )),
                      Expanded(child: Icon(Icons.share))
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
