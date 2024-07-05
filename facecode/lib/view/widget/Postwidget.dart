import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/controller/commentCtr.dart';
import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/model/entities/post_model.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/commentsSheet.dart';
import 'package:facecode/view/screen/other_profile_screen.dart';
import 'package:facecode/view/widget/mediaGridWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatefulWidget {
  final PostModel? postC;
  PostWidget({super.key, required this.postC});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  List<Uint8List>? postImages;
  bool isExpanded = false;
  bool isNotlikeddd = true;
  bool isNotdislikeddd = true;
  int commentsLength = 0;

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<MyProvider>(context, listen: false);
    isNotlikeddd = !widget.postC!.likersList!.contains(provider.userModel!.id!);
    isNotdislikeddd =
        !widget.postC!.dislikersList!.contains(provider.userModel!.id!);
    getCommentsLength();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: FutureBuilder<UserModel?>(
        future: UserCtr.getUserById(widget.postC!.userId ?? ""),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: SizedBox());
          }
          if (snapshot.hasError) {
            return Text("Error loading user data");
          }
          if (!snapshot.hasData) {
            return Text("User not found");
          }
          UserModel? user = snapshot.data;
          return Container(
            decoration: BoxDecoration(
              color: provider.myTheme == ThemeMode.light
                  ? Colors.white
                  : Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: [
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      OtherProfileScreen.routeName,
                      arguments: user!.id,
                    );
                  },
                  child: ListTile(
                    leading: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: user!.imageUrl ?? "",
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset("images/avatardefault.png"),
                        ),
                      ),
                    ),
                    title: Text(
                      "${user.firstName} ${user.lastName}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      user.jobTitle!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () {
                            PostCtr.deletePost(widget.postC!.postId!);
                          },
                          child: Text(
                            "Delete Post",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        PopupMenuItem(
                          child: Text(
                            "Copy Post",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      widget.postC!.textContent!.length > 50
                          ? isExpanded
                              ? widget.postC!.textContent!
                              : widget.postC!.textContent!.substring(0, 50)
                          : widget.postC!.textContent!,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    widget.postC!.textContent!.length > 50
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Text(
                              isExpanded ? "Read Less" : "Read More",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 17),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
                widget.postC!.contents != null &&
                        widget.postC!.contents!.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Mediagridwidget(
                                  images: widget!.postC!.contents!,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      widget.postC!.contents!.length > 1
                                          ? 2
                                          : 1,
                                  crossAxisSpacing: 5.0,
                                  mainAxisSpacing: 5.0,
                                ),
                                itemCount: widget.postC!.contents!.length > 2
                                    ? 2
                                    : widget.postC!.contents!.length,
                                itemBuilder: (context, index) {
                                  return CachedNetworkImage(
                                    imageUrl: widget.postC!.contents![index],
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                              if (widget.postC!.contents!.length > 2)
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "See More",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: isNotdislikeddd
                            ? () async {
                                await PostCtr.likePost(
                                  widget.postC!.postId!,
                                  provider.userModel!.id!,
                                  isNotlikeddd,
                                );

                                if (mounted) {
                                  setState(() {
                                    isNotlikeddd = !isNotlikeddd;
                                  });
                                }
                              }
                            : null,
                        icon: Icon(
                          isNotlikeddd
                              ? Icons.thumb_up_off_alt_outlined
                              : Icons.thumb_up_alt,
                        ),
                        label: Text(
                          widget.postC!.likesNum.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.black),
                      ),
                      Expanded(
                        child: TextButton.icon(
                          label: Text(
                            commentsLength.toString(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          icon: Icon(
                            Icons.comment,
                            color: provider.myTheme == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: Comments_sheet(
                                    postId: widget.postC!.postId!,
                                    postLikes: widget.postC!.likesNum,
                                    mainUser: provider.userModel,
                                    isNotdislikeddd: isNotdislikeddd,
                                    isNotlikeddd: isNotlikeddd,
                                    postdisLikes: widget.postC!.disLikesNum,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      TextButton.icon(
                        onPressed: isNotlikeddd
                            ? () async {
                                await PostCtr.dislikePost(
                                  widget.postC!.postId!,
                                  provider.userModel!.id!,
                                  isNotdislikeddd,
                                );
                                if (mounted) {
                                  setState(() {
                                    isNotdislikeddd = !isNotdislikeddd;
                                  });
                                }
                              }
                            : null,
                        icon: Icon(
                          isNotdislikeddd
                              ? Icons.thumb_down_off_alt_outlined
                              : Icons.thumb_down_alt,
                        ),
                        label: Text(
                          widget.postC!.disLikesNum.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> getCommentsLength() async {
    final commentsSnapshot =
        await CommentCtrl.getCommentsForPost(widget.postC!.postId!).first;
    if (mounted) {
      setState(() {
        commentsLength = commentsSnapshot.docs.length;
      });
    }
    print("==============================$commentsLength================");
  }
}
