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
  PostCtr pc = PostCtr();

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
            child: StreamBuilder(
              stream: pc.getPostssss(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  Text("Erorr");
                }
                List<Post> postss =
                    snapshot.data!.docs.map((e) => e.data()).toList();
                if (postss.isEmpty) {
                  return Column(
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
                  );
                }

                return ListView.separated(
                    itemBuilder: (context, index) => PostWidget(
                        postC: postss[index], ),
                    separatorBuilder: (context, index) => SizedBox(),
                    itemCount: posts!.length);
              },
            ),
          );
  }
}
