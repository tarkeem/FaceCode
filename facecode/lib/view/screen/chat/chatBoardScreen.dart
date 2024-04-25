import 'package:facecode/view/screen/chat/chatRoomScreen.dart';
import 'package:facecode/view/widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class chatBoard extends StatelessWidget {
  const chatBoard({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            _myAppBar(deviceSize),
            Expanded(
                child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ChatRoom(
                                roomId: 'room1',
                                FromUser: 'user1',
                                toUser: 'user2'),
                      ));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Text("Name"),
                            Text(
                              'Email',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 207, 206, 206),
                                  fontSize: 15),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ))
          ],
        ));
  }

  Container _myAppBar(Size deviceSize) {
    return Container(
      height: deviceSize.height * 0.3,
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
              child: CustomTextField(
                  text: 'Search',
                  icon: Icon(Icons.search),
                  textEditingController: TextEditingController()))
        ],
      ),
    );
  }
}



/*


Row(children: [
        TextButton(onPressed: () {
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) =>ChatRoom(roomId: 'room1',FromUser: 'user1',toUser: 'user2') ,));
      }, child: Text('user 1')),
       TextButton(onPressed: () {
        Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) =>ChatRoom(roomId: 'room1',FromUser: 'user2',toUser: 'user1') ,));
      }, child: Text('user 2'))
      ],),
 */