import 'package:cached_network_image/cached_network_image.dart';
import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/controller/pickImageCtr.dart';
import 'package:facecode/model/entities/post_model.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/homepage.dart';
import 'package:facecode/view/widget/shared_signedin_app_bar.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Addpost extends StatefulWidget {
  static const String routeName = "AddPost";

  Addpost({super.key});

  @override
  State<Addpost> createState() => _AddpostState();
}

class _AddpostState extends State<Addpost> {
  TextEditingController TC = TextEditingController();
  List<String>? images;
  List<String> mediaState = ["No Media Uploaded..", "Media Uploaded"];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: SharedSignedInAppBar(
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
                            imageUrl: provider.userModel!.imageUrl ?? "",
                            placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                            errorWidget: (context, url, error) => Image(
                                image: AssetImage("images/avatardefault.png"))),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${provider.userModel!.firstName} ${provider.userModel!.lastName}",
                              style: Theme.of(context).textTheme.bodyMedium,
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
                            "Public ▼",
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
                              if (images != null && images!.isNotEmpty) {
                                var uploadedMediaUrls =
                                    await MediaController.uploadMedia(images!);
                                PostModel post = PostModel(
                                  contents: uploadedMediaUrls,
                                  date: DateTime.now(),
                                  disLikesNum: 0,
                                  likesNum: 0,
                                  textContent: TC.text,
                                  userId: provider.userModel!.id,
                                );
                                await PostCtr.addPost(postModel: post);
                                ShowDialog.showCustomDialog(
                                  context,
                                  "Post Accepted",
                                  SizedBox(),
                                  () {
                                    Navigator.pushNamed(
                                      context,
                                      HomePage.routeName,
                                      arguments: provider.userModel!,
                                    );
                                  },
                                );
                              } else {
                                // Handle the case where no media is selected
                                PostModel post = PostModel(
                                  contents: [],
                                  date: DateTime.now(),
                                  disLikesNum: 0,
                                  likesNum: 0,
                                  textContent: TC.text,
                                  userId: provider.userModel!.id,
                                );
                                await PostCtr.addPost(postModel: post);
                                ShowDialog.showCustomDialog(
                                  context,
                                  "Post Accepted",
                                  SizedBox(),
                                  () {
                                    Navigator.pushNamed(
                                      context,
                                      HomePage.routeName,
                                      arguments: provider.userModel!,
                                    );
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
                style: Theme.of(context).textTheme.bodyMedium,
                minLines: 12,
                maxLines: 30,
                cursorColor: provider.myTheme == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "What's on your mind...",
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Text(
                images == null ? mediaState[0] : mediaState[1],
                style: Theme.of(context).textTheme.bodySmall,
              ),
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
                  var pickedImages = await MediaController.pickMedia();
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
                      style: Theme.of(context).textTheme.bodyMedium,
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
