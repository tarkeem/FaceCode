import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/model/entities/Post.dart';
import 'package:facecode/view/widget/Postwidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {
  const Timeline({super.key});

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
    PostCtr pc = PostCtr();
    await pc.initializePost();
    List<Post> loadedPosts = await pc.getPosts();
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
