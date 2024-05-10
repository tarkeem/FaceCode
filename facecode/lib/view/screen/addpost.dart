// import 'dart:js';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/view/screen/homepage.dart';
import 'package:facecode/view/widget/shared_app_bar.dart';
import 'package:flutter/material.dart';

class Addpost extends StatefulWidget {
  static const String routeName = "settingsPage";
  const Addpost({super.key});
  @override
  State<Addpost> createState() => _AddpostState();
}

class _AddpostState extends State<Addpost> {
  TextEditingController TC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //var provider = Provider.of<MyProvider>(context);
    var user = ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: SharedAppBar(showBackButton: true),
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
                    ElevatedButton(
                      onPressed: () {
                        addpost(TC.text);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                            (route) => false);
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
                minLines: 10,
                maxLines: 20,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "What's on your mind...?",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  focusColor: Colors.black,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 55),
                padding: EdgeInsets.only(bottom: 15, top: 15),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 3),
                        top: BorderSide(width: 3))),
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_album_outlined,
                      size: 40,
                      color: Colors.green[700],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Upload Images",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.video_call,
                      size: 40,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Upload Videos",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void showRejec(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Post Rejected",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        contentPadding: EdgeInsets.only(top: 30, bottom: 10),
        contentTextStyle: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        content: Container(
            height: 200,
            // width: 600,
            child: Column(
              children: [
                Text(
                  "Post Content Is Not Related to programming",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Back",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        // fontWeight: FontWeight.bold,
                      ),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Learn More",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        // fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            )),
      );
    },
  );
}

void showAcc(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Post Accepted",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    },
  );
}

void analysePost(String postDescription, BuildContext context) async {
  // var apiUrl = 'http://192.168.1.12:8000/predict';
  // var inputData = {'input': postDescription};

  // var responseJSon = await http.post(
  //   Uri.parse(apiUrl),
  //   headers: {'Content-Type': 'application/json'},
  //   body: jsonEncode(inputData),
  // );

  // var response = jsonDecode(responseJSon.body);

  // var prediction = response['prediction'];
  int prediction = 1;
  print(prediction);

  if (prediction == 1) {
    showAcc(context);
    addpost(postDescription);
  } else {
    showRejec(context);
  }
}

void addpost(String postDescription) async {
  // Post post = Post(
  //     contents: [],
  //     date: DateTime.now(),
  //     likesNum: 0,
  //     textContent: postDescription,
  //     userId: "fRIPTr8beQOOhAyEuefN0eCCOzB3");
  // PostCtr pc = new PostCtr();
  // pc.initializePost();
  // await pc.addPost(post: post);
  print("post Addeddddd");
}
