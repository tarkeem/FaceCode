// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/model/entities/Post.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/addpost.dart';
import 'package:facecode/view/screen/profile/edit_profile_screen.dart';
import 'package:facecode/view/widget/Postwidget.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:provider/provider.dart';

class MyProfilePage extends StatefulWidget {
  UserModel model;

  MyProfilePage({super.key, required this.model});

  @override
  State<MyProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<MyProfilePage> {
  Future<void> _loadPosts() async {
    await PostCtr.initializePost();
    //List<Post> loadedPosts = await PostCtr.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.27,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: widget.model.coverUrl != null && widget.model.coverUrl != ''
                      ? InstaImageViewer(
                          child: CachedNetworkImage(
                            fit: BoxFit.fitWidth,
                            imageUrl: widget.model.coverUrl!,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        )
                      : Image.asset(
                          "images/defaultCover.jpg",
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                  top: 60,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width * 0.40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 5),
                    ),
                    child: ClipOval(
                      child: widget.model.imageUrl != null
                          ? InstaImageViewer(
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: widget.model.imageUrl!,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Image.asset(
                                  "images/avatardefault.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Image.asset(
                              "images/avatardefault.png",
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Inner Column
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.model.firstName ?? "",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.model.lastName ?? "",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                Text(
                  widget.model.jobTitle ?? "",
                  style: TextStyle(fontSize: 17),
                ),
                Row(
                  children: [
                    Text(
                      "${widget.model.country ?? ""}, ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      "${widget.model.state ?? ""}, ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      widget.model.city ?? "",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "100",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          "Followers",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "100",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          "Following",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "100",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          "Posts",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                // Bio
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bio',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Center(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: widget.model.bio != null && widget.model.bio != ''
                            ? Center(
                                child: Text(
                                  widget.model.bio!,
                                  style: TextStyle(fontSize: 16, color: Colors.black87),
                                ),
                              )
                            : Center(
                                child: Text(
                                  'No bio',
                                  style: TextStyle(fontSize: 16, color: Colors.black87),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, Addpost.routeName, arguments: widget.model);
                        },
                        child: Text(
                          "Add Post+",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            EditProfile.routeName,
                            arguments: widget.model,
                          );
                        },
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                StreamBuilder(
                  stream: PostCtr.getMyProfilePosts(),
                  builder: (context, AsyncSnapshot<QuerySnapshot<Post>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Something went wrong"),
                          ElevatedButton(onPressed: () {}, child: Text("Try again"))
                        ],
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text("No posts yet"),
                      );
                    }

                    List<Post> posts = snapshot.data!.docs.map((e) => e.data()).toList();
                    return Column(
                      children: posts.map((post) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: PostWidget(
                            postC: post,
                            refreshTimeline: _loadPosts,
                            mainUser: provider.userModel,
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
