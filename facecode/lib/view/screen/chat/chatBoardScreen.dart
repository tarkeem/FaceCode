import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/controller/ChatCtr.dart';
import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/view/screen/chat/chatRoomScreen.dart';
import 'package:flutter/material.dart';

class chatBoard extends StatelessWidget {
  static const String routeName = "chatBoardScreen";
  final String userid;
  const chatBoard({required this.userid, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Chats", style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: ChatCtr().getMyChat(userid),
              builder: (context, snapshot) {
                List<QueryDocumentSnapshot<Object?>>? chats = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.black,
                    thickness: 3,
                  ),
                  itemCount: chats!.length,
                  itemBuilder: (context, index) {
                    String myid, friendid;
                    if (userid == chats[index]['user1']) {
                      myid = chats[index]['user1'];
                      friendid = chats[index]['user2'];
                    } else {
                      myid = chats[index]['user2'];
                      friendid = chats[index]['user1'];
                    }
                    return Padding(
                      padding: EdgeInsets.all(16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return ChatRoom(
                                    roomId: chats[index]['chatid'],
                                    FromUser: myid,
                                    toUser: friendid);
                              },
                            ),
                          );
                        },
                        child: chatRowElement(
                          firiendid: friendid,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class chatRowElement extends StatelessWidget {
  const chatRowElement({
    super.key,
    required this.firiendid,
  });

  final String firiendid;

  @override
  Widget build(BuildContext context) {
    TextTheme mytheme = Theme.of(context).textTheme;
    return FutureBuilder(
      future: UserCtr.getUserById(firiendid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Row(
          children: [
            snapshot.data!.imageUrl == null
                ? CircleAvatar(child: Image.asset('images/avatardefault.png'))
                : CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data!.imageUrl!),
                  ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${snapshot.data!.firstName!} ${snapshot.data!.lastName!}",
                  style: mytheme.bodyMedium,
                ),
                Text(
                  "${snapshot.data!.jobTitle!}",
                  style: mytheme.bodySmall,
                )
              ],
            )
          ],
        );
      },
    );
  }
}
