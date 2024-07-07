import 'package:facecode/view/screen/auth/loginScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/controller/MediaController.dart';
import 'package:facecode/model/entities/post_model.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/homepage.dart';
import 'package:facecode/view/widget/shared_signedin_app_bar.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  String? video;
  List<String> mediaState = ["No Media Uploaded..", "Media Uploaded"];
  List<String>? uploadedMediaUrls = [];
  String? uploadedVideo = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    if (provider.userModel == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.routeName, (route) => false);
      });
      return SizedBox.shrink();
    }
    return Scaffold(
      appBar: SharedSignedInAppBar(
        showBackButton: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 3))),
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
                                    image: AssetImage(
                                        "images/avatardefault.png"))),
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
                                provider.userModel!.jobTitle!,
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
                                  if (images != null && images!.isNotEmpty ||
                                      video != null) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                  }
                                  if (images != null && images!.isNotEmpty) {
                                    uploadedMediaUrls =
                                        await MediaController.uploadimages(
                                            images!);
                                  }
                                  if (video != null) {
                                    uploadedVideo =
                                        await MediaController.uploadvideo(
                                            video!);
                                  }

                                  PostModel post = PostModel(
                                    images: uploadedMediaUrls,
                                    video: uploadedVideo,
                                    date: DateTime.now(),
                                    disLikesNum: 0,
                                    likesNum: 0,
                                    textContent: TC.text,
                                    userId: provider.userModel!.id,
                                  );
                                  int response = await PostCtr.analysePost(
                                      post.textContent!);

                                  if (response == 1) {
                                    ShowDialog.showCustomDialog(
                                        context, "Post Accepted", SizedBox(),
                                        () {
                                      Navigator.pushNamed(
                                        context,
                                        HomePage.routeName,
                                        arguments: provider.userModel!,
                                      );
                                    }, 1);

                                    await PostCtr.addPost(postModel: post);

                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                  ;
                                  if (response == 0) {
                                    ShowDialog.showCustomDialog(
                                        context, "Post Rejected", SizedBox(),
                                        () {
                                      Navigator.pushNamed(
                                        context,
                                        HomePage.routeName,
                                        arguments: provider.userModel!,
                                      );
                                    }, 1);
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: SingleChildScrollView(
                      child: TextField(
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
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    images == null || video == null
                        ? mediaState[0]
                        : mediaState[1],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 3),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () async {
                      var pickedImages = await MediaController.pickImages();
                      setState(() {
                        images = pickedImages;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo,
                          size: 40,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Upload Images",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
            ),
        ],
      ),
    );
  }
}
