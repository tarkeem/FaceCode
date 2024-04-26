// ignore_for_file: must_be_immutable

import 'package:facecode/view/screen/commentsSheet.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class Postt extends StatelessWidget {
  Postt({super.key});
  List<List<String?>> dummy = [
    [
      ''' Hey everyone,
          
I wanted to take a moment to talk about the big changes happening at Facebook. As you may have heard, we recently announced that we are rebranding the company to Meta.
          
This decision wasn't made lightly. We believe that the future of our company lies in the metaverse, a virtual reality space where people can connect, create, and explore in new and exciting ways. This is a big shift for us, but we believe it's the right move as we look towards the next chapter of our company.
          
The metaverse is a concept that has been around for a while, but we believe that now is the time to bring it to life. We want to create a world where people can interact with each other in a more immersive and meaningful way. Imagine being able to attend a concert with friends from around the world, or explore a virtual museum with your family. These are just a few examples of the possibilities that the metaverse holds.''',
      "images/mark.jpg",
      "CEO of Facebook",
      "Mark Zuckerburg",
      null
    ],
    [
      '''Hey everyone,
iam thrilled to share with you my new game made with C.''',
      "images/dev.jpg",
      "C++ Developer",
      " Lydia Hallie",
      "https://th.bing.com/th/id/OIP.x5jNdmpoihtBEU9WxHCPTgAAAA?rs=1&pid=ImgDetMain"
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        // itemCount: dummy.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.all(5),
          // padding: EdgeInsets.all(5),
          child: Column(
            children: [
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)),
                  height: 45,
                  width: 45,
                  child: CircleAvatar(
                    radius: 70,
                    foregroundImage:
                        AssetImage(dummy[index % 2 == 0 ? 1 : 0][1]!),
                  ),
                ),
                title: Text(
                  dummy[index % 2 == 0 ? 1 : 0][3]!,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
                subtitle: Text(
                  dummy[index % 2 == 0 ? 1 : 0][2]!,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                trailing: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(dummy[index % 2 == 0 ? 1 : 0][0]!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 17),
                    overflow: TextOverflow.fade),
              ),
              dummy[index % 2 == 0 ? 1 : 0][4] != null
                  ? Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                      child: Container(
                          width: double.infinity,
                          color: Colors.black,
                          child: Image.network(
                            dummy[index % 2 == 0 ? 1 : 0][4]!,
                            fit: BoxFit.fill,
                          )),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: LikeButton(
                        circleSize: 50,
                        likeBuilder: (isLiked) => isLiked
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(Icons.favorite),
                            likeCount: 5254,
                      ),
                    ),
                    Expanded(
                        child: IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {
                        final double screenHeight =
                            MediaQuery.of(context).size.height;

                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return Comments_sheet();
                          },
                        );
                      },
                    )),
                    Expanded(child: Icon(Icons.share))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
