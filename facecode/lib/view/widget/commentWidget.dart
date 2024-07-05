import 'package:cached_network_image/cached_network_image.dart';
import 'package:facecode/controller/commentCtr.dart';
import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/model/entities/comment_model.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class CommentWidget extends StatefulWidget {
  final CommentModel comment;

  const CommentWidget({
    super.key,
    required this.comment,
  });

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool isExpanded = false;
  bool isNotlikeddd = true;
  bool isNotdislikeddd = true;

  @override
  void initState() {
    var provider = Provider.of<MyProvider>(context, listen: false);
    isNotlikeddd =
        !widget.comment.likersList!.contains(provider.userModel!.id!);
    isNotdislikeddd =
        !widget.comment.dislikersList!.contains(provider.userModel!.id!);
    super.initState();
  }

  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return FutureBuilder(
      future: UserCtr.getUserById(widget.comment.userId!),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(30)),
                child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
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
                                child: user!.imageUrl != null
                                    ? CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: user.imageUrl ?? "",
                                        placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      )
                                    : Image.asset("images/avatardefault.png"),
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            user.fullNameLowerCase ?? "",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () {
                            CommentCtrl.deleteComment(widget.comment.commentId!,
                                widget.comment.postId!);
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
                        )
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Column(children: [
                        Text(
                          widget.comment.text!.length > 50
                              ? isExpanded
                                  ? widget.comment.text!
                                  : widget.comment.text!.substring(0, 50)
                              : widget.comment.text!,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        widget.comment.text!.length > 50
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: Text(
                                  isExpanded ? "Read Less" : "Read More",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 17),
                                ),
                              )
                            : SizedBox(),
                      ]),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: isNotdislikeddd
                          ? () async {
                              await CommentCtrl.likeComment(widget.comment,
                                  isNotlikeddd, provider.userModel!.id!);
                              setState(() {
                                isNotlikeddd = !isNotlikeddd;
                              });
                            }
                          : null,
                      icon: Icon(
                        isNotlikeddd
                            ? Icons.thumb_up_off_alt_outlined
                            : Icons.thumb_up_alt,
                      ),
                      label: Text(
                        widget.comment.likesNum.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.black),
                    ),
                    TextButton.icon(
                      onPressed: isNotlikeddd
                          ? () async {
                              await CommentCtrl.dislikeComment(widget.comment,
                                  isNotdislikeddd, provider.userModel!.id!);
                              setState(() {
                                isNotdislikeddd = !isNotdislikeddd;
                              });
                            }
                          : null,
                      icon: Icon(
                        isNotdislikeddd
                            ? Icons.thumb_down_off_alt_outlined
                            : Icons.thumb_down_alt,
                      ),
                      label: Text(
                        widget.comment.dislikesNum.toString(),
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
    );
  }
}
