// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/model/entities/post_model.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/addpost.dart';
import 'package:facecode/view/screen/profile/edit_profile_screen.dart';
import 'package:facecode/view/widget/Postwidget.dart';
import 'package:facecode/view/widget/following_or_followers_bottomsheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:provider/provider.dart';

class MyProfilePage extends StatefulWidget {
  MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var userModel = provider.userModel;
    floatingActionButton:
    FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, Addpost.routeName, arguments: userModel);
      },
      backgroundColor: Colors.grey[300],
      child: Icon(
        Icons.add,
      ),
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.27,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.23,
                  child: userModel!.coverUrl != null && userModel.coverUrl != ''
                      ? InstaImageViewer(
                          child: CachedNetworkImage(
                            fit: BoxFit.fitWidth,
                            imageUrl: userModel.coverUrl!,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
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
                      child: userModel.imageUrl != null
                          ? InstaImageViewer(
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: userModel.imageUrl!,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
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
                      userModel.firstName ?? "",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      userModel.lastName ?? "",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                Text(
                  userModel.jobTitle ?? "",
                  style: TextStyle(fontSize: 17),
                ),
                Row(
                  children: [
                    Text(
                      "${userModel.country ?? ""}, ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      "${userModel.state ?? ""}, ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      userModel.city ?? "",
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
                    InkWell(
                      onTap: () {
                        showUserListBottomSheet(
                            context, userModel.followers!, "Followers");
                      },
                      child: Column(
                        children: [
                          Text(
                            "${userModel.followers?.length}",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            "Followers",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showUserListBottomSheet(
                            context, userModel.following!, "Following");
                      },
                      child: Column(
                        children: [
                          Text(
                            "${userModel.following?.length}",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            "Following",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
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
                        child: userModel.bio != null && userModel.bio != ''
                            ? Center(
                                child: Text(
                                  userModel.bio!,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87),
                                ),
                              )
                            : Center(
                                child: Text(
                                  'No bio',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, Addpost.routeName,
                              arguments: provider.userModel);
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            EditProfile.routeName,
                            arguments: userModel,
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
                  stream: PostCtr.getProfilePosts(
                      FirebaseAuth.instance.currentUser!.uid),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<PostModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      print("Error: ${snapshot.error}");
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Something went wrong"),
                          ElevatedButton(
                              onPressed: () {}, child: Text("Try again"))
                        ],
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Column(
                        children: [
                          SizedBox(height: 50),
                          Center(
                            child: Text("No posts yet"),
                          ),
                        ],
                      );
                    }
                    List<PostModel> posts =
                        snapshot.data!.docs.map((e) => e.data()).toList();
                    print("Found ${posts.length} posts");
                    return Column(
                      children: posts.map((post) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: PostWidget(
                            postC: post,
                          ),
                        );
                      }).toList(),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
