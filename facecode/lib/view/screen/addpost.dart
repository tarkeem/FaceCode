import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/controller/pickImageCtr.dart';
import 'package:facecode/model/entities/Post.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/view/screen/homepage.dart';
import 'package:facecode/view/widget/shared_signedin_app_bar.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:flutter/material.dart';

class Addpost extends StatefulWidget {
  static const String routeName = "AddPost";

  Addpost({
    super.key,
  });

  @override
  State<Addpost> createState() => _AddpostState();
}

class _AddpostState extends State<Addpost> {
  TextEditingController TC = TextEditingController();
  List<String?>? images;
  List<String> mediaState = [
    "NO media Uploaded",
    "Media Uploaded"
  ];

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: SharedSignedInAppBar(
        userId: user.id,
        showBackButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 15),
                decoration:
                    BoxDecoration(border: Border(bottom: BorderSide(width: 3))),
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: user.imageUrl ?? "",
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
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              user.firstName ?? "",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              user.lastName ?? "",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[400],
                          ),
                          padding: EdgeInsets.fromLTRB(6, 1, 5, 2),
                          child: Text(
                            "Public▼",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    TC.text.isEmpty
                        ? SizedBox()
                        : ElevatedButton(
                            onPressed: () async {
                              Post post = Post(
                                contents: images!=null ? images : [],
                                date: DateTime.now(),
                                likesNum: 0,
                                textContent: TC.text,
                                userId: user.id,
                              );

                              PostCtr.initializePost();
                              int result = await PostCtr.addPost(post: post);
                              if (result == 0) {
                                ShowDialog.showCustomDialog(
                                  context,
                                  "Post Rejected",
                                  Text(
                                    "Post Content Is Not Related to programming",
                                    textAlign: TextAlign.center,
                                  ),
                                  () {
                                    Navigator.pop(context);
                                  },
                                );
                              } else {
                                ShowDialog.showCustomDialog(
                                  context,
                                  "Post Accepted",
                                  SizedBox(),
                                  () {
                                    Navigator.pushNamed(
                                        context, HomePage.routeName,
                                        arguments: user);
                                  },
                                );
                              }
                            },
                            child: Text(
                              "Post",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(vertical: 5),
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: TC,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                minLines: 12,
                maxLines: 30,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "What's on your mind...",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  focusColor: Colors.black,
                ),
              ),
              Text(images == null ? mediaState[0] : mediaState[1]),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 3),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  var pickedImages = await PickImageCtr.pickimage();
                  setState(() {
                    images = pickedImages;
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo,
                      size: 40,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Upload Images or videos",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
