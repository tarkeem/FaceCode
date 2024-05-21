import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/model/entities/Post.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/view/widget/Postwidget.dart';

import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {
  UserModel? model;
  Timeline({super.key, required this.model});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<Post>? posts;
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
    var user = widget.model;
    await PostCtr.initializePost();
    List<Post> loadedPosts = await PostCtr.getPosts();
    setState(() {
      posts = loadedPosts;
    });
  }

  Widget build(BuildContext context) {
    return posts == null
        ? Center(child: CircularProgressIndicator())
        : Container(
            color: Colors.grey,
            child: Expanded(
                child: ListView.builder(
              itemCount: posts!.length,
              itemBuilder: (context, index) {
                return PostWidget(
                  postC: posts![index],
                  refreshTimeline: refreshTimeline,
                );
              },
            )),
          );
  }
}
