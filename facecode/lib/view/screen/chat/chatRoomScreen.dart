// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/controller/ChatCtr.dart';
import 'package:facecode/model/entities/chatModel.dart';
import 'package:facecode/view/widget/ChatBubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatRoom extends StatefulWidget {
  String roomId;
  String FromUser;
  String toUser;
  ChatRoom(
      {super.key,
      required this.roomId,
      required this.FromUser,
      required this.toUser});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late CollectionReference<Map<String, dynamic>> _roomInstant;
  late TextEditingController _textCtr;
  ChatCtr _chatCtr = ChatCtr();
  @override
  void initState() {
    _roomInstant = _chatCtr.initializeChat(widget.roomId);
    _textCtr = TextEditingController();

    super.initState();
  }

  List<Chat> ChatMeassage = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream:
                    _roomInstant.orderBy('date', descending: true).snapshots(),
                builder: (context, snapshot) {
                  ChatMeassage = [];
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    ChatMeassage = snapshot.data!.docs
                        .map((e) => Chat.fromFirestore(e))
                        .toList();
                    print(ChatMeassage.length);
                    return ListView.builder(
                      reverse: true,
                      itemCount: ChatMeassage.length,
                      itemBuilder: (context, index) {
                        Chat chat = ChatMeassage[index];
                        return msgBabble(
                            msg: chat.content!,
                            is_me: chat.from == widget.FromUser,
                            userImageUrl:
                                'https://www.bing.com/ck/a?!&&p=ff6a146b9752cedcJmltdHM9MTcxMDM3NDQwMCZpZ3VpZD0zYjA1OWUxNS00ZTNlLTY1ZGQtMjY3Yy04YTA3NGYyMTY0NDMmaW5zaWQ9NTY3Mg&ptn=3&ver=2&hsh=3&fclid=3b059e15-4e3e-65dd-267c-8a074f216443&u=a1L2ltYWdlcy9zZWFyY2g_cT1kZWZ1bHQlMjBwcm9maWxlJTIwcGljdHVyZXMmRk9STT1JUUZSQkEmaWQ9MkRGRTQzMjc1MTE0QThDOTcyRkZCRTQzRjk4QjgxNDAwMENFMjlBOA&ntb=1',
                            userName: widget.FromUser);
                      },
                    );
                  }
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.type_a_message),
                  controller: _textCtr,
                )),
                IconButton(
                  onPressed: () {
                    ChatMeassage = []
                      ..add(Chat(
                          content: '',
                          from: widget.FromUser,
                          to: widget.toUser))
                      ..addAll(ChatMeassage);
                    _chatCtr.sendMessage(
                        from: widget.FromUser,
                        to: widget.toUser,
                        content: _textCtr.text);
                    _textCtr.clear();
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
