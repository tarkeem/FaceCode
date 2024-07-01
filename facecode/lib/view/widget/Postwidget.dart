// ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/controller/pickImageCtr.dart';
import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/model/entities/post_model.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/view/screen/commentsSheet.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class PostWidget extends StatefulWidget {
  PostModel? postC;
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
  String? userName;
  String? jobTitle;
  String? postID;
  String? postText;
  List<Uint8List>? postImages;
  DateTime? date;
  int likesCount = 0;
  bool isExpanded = false;

  @override
  void initState() {
    getPostData();
    getUserData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getPostData() async {
    postID = widget.postC!.postId!;
    postText = widget.postC!.textContent!;
    likesCount = widget.postC!.likesNum;
    date = widget.postC!.date;

    if (widget.postC!.contents != []) {
      postImages = await PickImageCtr.getImages(widget.postC!.contents!);
    }
  }

  void getUserData() async {
    UserModel? userr = await UserCtr.getUserById(widget.postC!.userId!);
    if (!mounted) return; // Check if the widget is still mounted
    setState(() {
      user = userr;
      if (user != null) {
        userName = user!.firstName! + " " + user!.lastName!;
        jobTitle = user!.jobTitle;
      }
    });
  }

  Future<bool?> _handleLikeButtonPress(bool isLiked) async {
    try {
      PostCtr.initializePost();

      if (!isLiked) {
        await PostCtr.likePost(postID!);
      } else {
        await PostCtr.DislikePost(postID!);
      }

      if (!mounted) return isLiked; // Check if the widget is still mounted
      setState(() {
        likesCount += isLiked ? -1 : 1;
      });

      return !isLiked;
    } catch (error) {
      if (!mounted) return isLiked; // Check if the widget is still mounted
      setState(() {
        likesCount += isLiked ? -1 : 1;
      });
      print('Error updating likes count: $error');
      return isLiked;
    }
  }

  @override
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
                          errorWidget: (context, url, error) => Image(
                              image: AssetImage("images/avatardefault.png")),
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
                // postImages != null || postImages != []
                //     ? Padding(
                //         padding:
                //             EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                //         child: Container(
                //           width: double.infinity,
                //           color: Colors.black,
                //           child: Image.memory(postImages![0]),
                //         ))
                //     :
                SizedBox(),
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
