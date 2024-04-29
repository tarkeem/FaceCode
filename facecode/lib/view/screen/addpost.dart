// import 'dart:js';
import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/model/entities/Post.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/view/screen/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        leading: BackButton(
            onPressed: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
            style: ButtonStyle(iconSize: MaterialStatePropertyAll(40))),
        centerTitle: true,
        title: Text(
          "Add Post",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              addpost(TC.text);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false);
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
          SizedBox(
            width: 10,
          ),
        ],
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
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 1)),
                      height: 60,
                      width: 60,
                      child: CircleAvatar(
                        radius: 70,
                        foregroundImage: AssetImage("images/test3.jpg"),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Arthur Morgan ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
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
                  ],
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: TC,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
                minLines: 10,
                maxLines: 20,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "What's on your mind...?",
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
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
  var apiUrl = 'http://192.168.1.12:8000/predict';
  var inputData = {'input': postDescription};

  var responseJSon = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(inputData),
  );

  var response = jsonDecode(responseJSon.body);

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
  Post post = Post(
      contents: [],
      date: DateTime.now(),
      likesNum: 0,
      textContent: postDescription,
      userId: "fRIPTr8beQOOhAyEuefN0eCCOzB3");
  PostCtr pc = new PostCtr();
  pc.initializePost();
  await pc.addPost(post: post);
  print("post Addeddddd");
}


//  home:Scaffold(
//         body: Center(
//           child: Row(
//             children: [
//               TextButton(child: Text('ds'),onPressed: () async{
//                 PostCtr ctr= PostCtr();
//                 ctr.initializePost();
//                 await ctr.post(post: Post(comments: ['99'],contents: ['url'],date: '8-6',likesNum: 34,textContent: 'hi',userId: '444'));
//               },),
//               TextButton(child: Text('get'),onPressed: () async{
//                 PostCtr ctr= PostCtr();
//                 ctr.initializePost();
//                 await ctr.getposts();
//               },),
//               TextButton(child: Text('get2'),onPressed: () async{
//                 PostCtr ctr= PostCtr();
//                 ctr.initializePost();
//                 await ctr.getpostsPagination(2);
//               },),
//               TextButton(child: Text('get3'),onPressed: () async{
//                 PostCtr ctr= PostCtr();
//                 ctr.initializePost();
//                 await ctr.likePost('3s7qHEYGwjXtO4wWDJl8');
//               },)
//             ],
//           ),
//         ),
//       )