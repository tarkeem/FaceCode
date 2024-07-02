// ignore_for_file: must_be_immutable

import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/model/entities/post_model.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/commentsSheet.dart';
import 'package:facecode/view/screen/other_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatefulWidget {
  final PostModel? postC;
  PostWidget({super.key, required this.postC});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  List<Uint8List>? postImages;
  bool isExpanded = false;
  


  @override
  Widget build(BuildContext context) {
        var provider = Provider.of<MyProvider>(context);

    return FutureBuilder<UserModel?>(
      future: UserCtr.getUserById(widget.postC!.userId ?? ""),
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Center(child: CircularProgressIndicator(color: Colors.black));
        // }
        if (snapshot.hasError) {
          return Text("Error loading user data");
        }
        if (!snapshot.hasData) {
          return Text("User not found");
        }
        UserModel? user = snapshot.data;
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, OtherProfileScreen.routeName,
                      arguments: user.id);
                },
                child: ListTile(
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
                            Image.asset("images/avatardefault.png"),
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        user.firstName ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        user.lastName ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    user.jobTitle!,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () {
                          PostCtr.deletePost(widget.postC!.postId!);
                        },
                        child: Text(
                          "Delete Post",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      PopupMenuItem(
                        child: Text(
                          "Copy Post",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Column(
                  children: [
                    Text(
                      widget.postC!.textContent!.length > 50
                          ? isExpanded
                              ? widget.postC!.textContent!
                              : widget.postC!.textContent!.substring(0, 50)
                          : widget.postC!.textContent!,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    widget.postC!.textContent!.length > 50
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
                  ],
                ),
              ),
              postImages != null && postImages!.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: double.infinity,
                        color: Colors.black,
                        child: Image.memory(postImages![0]),
                      ),
                    )
                  : SizedBox(),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: LikeButton(
                        // onTap: _handleLikeButtonPress,
                        circleSize: 50,
                        likeBuilder: (isLiked) => isLiked
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(Icons.favorite),
                        likeCount: widget.postC!.likesNum,
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
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child:
                               Comments_sheet(
                                postId: widget.postC!.postId!,
                                postLikes: widget.postC!.likesNum,
                                mainUser: provider.userModel,
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
      },
    );
  }
}
