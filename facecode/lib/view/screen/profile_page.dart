import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/model/entities/Post.dart';
import 'package:facecode/view/screen/addpost.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      "Lydia Hallie",
    ]
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1)),
              height: 140,
              width: 140,
              child: CircleAvatar(
                radius: 70,
                foregroundImage: AssetImage("images/test3.jpg"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Atrhur Morgan",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        {Navigator.pushNamed(context, Addpost.routeName)},
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      padding: EdgeInsets.fromLTRB(30, 7, 20, 7),
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          border: Border.all(
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        " + Add Post ",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    padding: EdgeInsets.fromLTRB(30, 7, 20, 7),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () async {
                      
                      },
                      child: Text(
                        "  Edit Profile",
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 30),
                child: Text(
                  "Details :",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          "Studied at Harford Univesity ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          "Web Developer",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Text(
                          "+10 years experience in Web-Development",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          "Groups : ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 40, top: 10),
                        child: Text(
                          "C++ For All",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 40, top: 10),
                        child: Text(
                          "Ai Discusiions",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
