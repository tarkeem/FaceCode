import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/controller/GlobalChatCtr.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/chat/globalChatRoom.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:
              Text("Communities", style: Theme.of(context).textTheme.bodyLarge),
        ),
        body: Column(
          children: [
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
                      return ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          endIndent: 10,
                          indent: 10,
                          color: Colors.black,
                          thickness: 3,
                        ),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("images/groupAvatar.png"),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chatName,
                style: mytheme.bodyMedium,
              ),
              Text(
                'createdBy',
                style: TextStyle(
                    color: Color.fromARGB(255, 105, 103, 103), fontSize: 15),
              ),
            ],
          )
        ],
      ),
    );
  }
}
