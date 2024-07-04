// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:facecode/controller/commentCtr.dart';
import 'package:facecode/model/entities/comment_model.dart';
import 'package:flutter/material.dart';

class Sa3donLikebutton extends StatefulWidget {
  bool isNotlikeddd;
  CommentModel comment;
  Sa3donLikebutton({
    Key? key,
    required this.isNotlikeddd,
    required this.comment,
  }) : super(key: key);

  @override
  State<Sa3donLikebutton> createState() => _Sa3donLikebuttonState();
}

class _Sa3donLikebuttonState extends State<Sa3donLikebutton> {
  @override
  Widget build(BuildContext context) {
    bool isnot = widget.isNotlikeddd;

    return Row(
      children: [
        IconButton(
          onPressed: () async {
            if (isnot) {
              await CommentCtrl.likeComment(widget.comment);
            } else {
              await CommentCtrl.removeLikeComment(widget.comment);
            }

            setState(() {
              isnot = !isnot;
            });
          },
          icon: Icon(
              isnot ? Icons.thumb_up_off_alt_outlined : Icons.thumb_up_alt),
          color: Colors.black,
        ),
        Text("${widget.comment.likesNum}"),
      ],
    );
  }
}
