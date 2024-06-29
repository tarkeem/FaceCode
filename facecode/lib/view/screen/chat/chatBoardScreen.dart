import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/controller/ChatCtr.dart';
import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/view/screen/chat/chatRoomScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class chatBoard extends StatelessWidget {
  static const String routeName = "chatBoardScreen";
  final String userid;
  const chatBoard({required this.userid,super.key});

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            _myAppBar(deviceSize),
            Expanded(
                child: FutureBuilder(
                    future: ChatCtr().getMyChat(userid),
                    builder: (context, snapshot) {
                      List<QueryDocumentSnapshot<Object?>>? chats =
                          snapshot.data;
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        itemCount: chats!.length,
                        itemBuilder: (context, index) {
                          String myid,friendid;
                           if (userid == chats[index]['user1'])
                           {
                            myid=chats[index]['user1'];
                            friendid=chats[index]['user2'];
                           }
                           else
                           {
                             myid=chats[index]['user2'];
                            friendid=chats[index]['user1'];
                           }
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                            
                                    return ChatRoom(
                                        roomId: chats[index]['chatid'],
                                        FromUser: myid,
                                        toUser: friendid);
                                  
                                }));
                              },
                              child: chatRowElement(firiendid: friendid,),
                            ),
                          );
                        },
                      );
                    }))
          ],
        ));
  }

  Container _myAppBar(Size deviceSize) {
    return Container(
      height: deviceSize.height * 0.2,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 214, 209, 209),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
      ),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            title: const Text(
              'Messages',
              style: TextStyle(color: Colors.pink),
            ),
            actions: [
              DropdownButton(
                underline: Container(),
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.pink,
                  size: 40,
                ),
                items: const [
                  DropdownMenuItem(
                    value: "a",
                    child: Text("Exit"),
                  ),
                  DropdownMenuItem(
                    value: 'b',
                    child: Text("a"),
                  )
                ],
                onChanged: (value) {},
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            // child: CustomTextField(
            //     text: 'Search',
            //     icon: Icon(Icons.search),
            //     textEditingController: TextEditingController()),
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
    return FutureBuilder(
      future: UserCtr.getUserById(firiendid),
      builder: (context, snapshot) {

        if(snapshot.connectionState==ConnectionState.waiting)
        {
          return Center(child: CircularProgressIndicator(),);
        }
        return Row(
          children: [
            if(!(snapshot.data!.imageUrl==null)) CircleAvatar(backgroundImage: NetworkImage(snapshot.data!.imageUrl!),),
            SizedBox(
              width: 5,
            ),
            Column(
              children: [
                Text(snapshot.data!.firstName!),
                Text(
                  snapshot.data!.email!,
                  style: TextStyle(
                      color: Color.fromARGB(255, 105, 103, 103),
                      fontSize: 15),
                )
              ],
            )
          ],
        );
      }
    );
  }
}
