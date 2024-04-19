import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/model/entities/Post.dart';
import 'package:facecode/view/screen/chatBoardScreen.dart';
import 'package:facecode/view/screen/chatRoomScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './firebase_options.dart';

void main() async{
  WidgetsFlutterBinding();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home:Scaffold(
      //   body: Center(
      //     child: Row(
      //       children: [
      //         TextButton(child: Text('ds'),onPressed: () async{
      //           PostCtr ctr= PostCtr();
      //           ctr.initializePost();
      //           await ctr.post(post: Post(comments: ['99'],contents: ['url'],date: '8-6',likesNum: 34,textContent: 'hi',userId: '444'));
      //         },),
      //         TextButton(child: Text('get'),onPressed: () async{
      //           PostCtr ctr= PostCtr();
      //           ctr.initializePost();
      //           await ctr.getposts();
      //         },),
      //         TextButton(child: Text('get2'),onPressed: () async{
      //           PostCtr ctr= PostCtr();
      //           ctr.initializePost();
      //           await ctr.getpostsPagination(2);
      //         },),
      //         TextButton(child: Text('get3'),onPressed: () async{
      //           PostCtr ctr= PostCtr();
      //           ctr.initializePost();
      //           await ctr.likePost('3s7qHEYGwjXtO4wWDJl8');
      //         },)
      //       ],
      //     ),
      //   ),
      // )
      home:chatBoard(),
    );
  }
}



