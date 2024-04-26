import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class Comments_sheet extends StatefulWidget {
  const Comments_sheet({Key? key});

  @override
  State<Comments_sheet> createState() => _Comments_sheetState();
}

class _Comments_sheetState extends State<Comments_sheet> {
  String longText =
      "this is test comment this is test comment this is test comment this is test commentttt";
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 40, 10, 5),
        child: Column(
          children: [
            Container(
              decoration:
                  BoxDecoration(border: Border(bottom: BorderSide(width: 2))),
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                    icon: Icon(Icons.favorite),
                    label: Text(
                      "54",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 10),
                  Spacer(),
                  LikeButton(
                    circleSize: 50,
                    likeBuilder: (isLiked) => isLiked
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(Icons.favorite_outline),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (context, index) {
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
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          AssetImage("images/mark.jpg"),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "User Name",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.more_vert))
                                  ],
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Column(children: [
                                  Text(
                                    longText.length > 50
                                        ? isExpanded
                                            ? longText
                                            : longText.substring(0, 50)
                                        : longText,
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  longText.length > 50
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isExpanded = !isExpanded;
                                            });
                                          },
                                          child: Text(
                                            isExpanded
                                                ? "Read Less"
                                                : "Read More",
                                            style:
                                                TextStyle(color: Colors.blue),
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
                              LikeButton(
                                likeCount: 33,
                                countBuilder:
                                    (int? count, bool isLiked, String text) {
                                  return Text(
                                    text,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                },
                                likeCountPadding: EdgeInsets.only(right: 10),
                                likeBuilder: (isLiked) => isLiked
                                    ? Icon(
                                        Icons.thumb_up,
                                      )
                                    : Icon(Icons.thumb_up_off_alt),
                              ),
                              LikeButton(
                                likeCount: 24,
                                countBuilder:
                                    (int? count, bool isLiked, String text) {
                                  return Text(
                                    text,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                },
                                likeBuilder: (isLiked) => isLiked
                                    ? Icon(
                                        Icons.thumb_down,
                                      )
                                    : Icon(Icons.thumb_down_off_alt_outlined),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Reply ...",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                SizedBox(),
                IconButton(onPressed: () {}, icon: Icon(Icons.send))
              ],
            )
          ],
        ));
  }
}
