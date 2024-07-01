// ignore_for_file: must_be_immutable

import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/model/entities/post_model.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/view/widget/Postwidget.dart';

import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {
  UserModel? mainUser;
  Timeline({super.key, required this.mainUser});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<PostModel>? posts;
  @override
  void initState() {
    _loadPosts();
    super.initState();
  }

  void refreshTimeline() {
    setState(() {
      _loadPosts();
    });
  }

  Future<void> _loadPosts() async {
    await PostCtr.initializePost();
    List<PostModel> loadedPosts = await PostCtr.getPosts();
    setState(() {
      posts = loadedPosts;
    });
  }

  Widget build(BuildContext context) {
    return posts == null || posts?.length == 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset("images/emptyFeed.png"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Your feed is empty !",
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          )
        : Container(
            color: Colors.grey,
            child: ListView.builder(
              itemCount: posts!.length,
              itemBuilder: (context, index) {
                return PostWidget(
                    postC: posts![index],
                    refreshTimeline: refreshTimeline,
                    mainUser: widget.mainUser);
              },
            ),
          );
  }
}
