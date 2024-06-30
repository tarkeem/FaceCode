import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/controller/GlobalChatCtr.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/chat/globalChatRoom.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class globalChatBoard extends StatefulWidget {
  static const String routeName = "globalChatBoardScreen";
  const globalChatBoard({super.key});

  @override
  State<globalChatBoard> createState() => _globalChatBoardState();
}

class _globalChatBoardState extends State<globalChatBoard> {
  String _userInput = '';
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
                    future: GlobalChatCtr().getGlobalChat(),
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
                          return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                  return GlobalChatRoom(
                                    roomId: chats[index]['chatid'],
                                    FromUser: Provider.of<MyProvider>(context)
                                        .userModel!
                                        .id!,
                                  );
                                }));
                              },
                              child: chatRowElement(
                                  chatName: chats[index]['name']));
                        },
                      );
                    }))
          ],
        ));
  }

  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Community'),
          content: TextField(
            onChanged: (value) {
              _userInput = value;
            },
            decoration: InputDecoration(hintText: "Name of comunnity"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                Navigator.of(context).pop();
                _handleSubmittedInput(_userInput);
              },
            ),
          ],
        );
      },
    );
  }

  Future _handleSubmittedInput(String input) async {
    await GlobalChatCtr().createRoom(input, "test");
    setState(() {});
  }

  Container _myAppBar(Size deviceSize) {
    TextTheme mytheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 214, 209, 209),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
      ),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            title: GestureDetector(
              onTap: () {
                _showInputDialog();
              },
              child: Text(
                'Communities',
                style: mytheme.bodyLarge,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          )
        ],
      ),
    );
  }
}

class chatRowElement extends StatelessWidget {
  const chatRowElement({
    super.key,
    required this.chatName,
  });

  final String chatName;

  @override
  Widget build(BuildContext context) {
     TextTheme mytheme = Theme.of(context).textTheme;
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(""),
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(chatName,style: mytheme.bodyMedium,),
            Text(
              'createdBy',
              style: TextStyle(
                  color: Color.fromARGB(255, 105, 103, 103), fontSize: 15),
            ),
          ],
        )
      ],
    );
  }
}
