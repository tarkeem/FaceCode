import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/chat/chatBoardScreen.dart';
import 'package:facecode/view/screen/chat/globalChatBoard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class mainChatScreen extends StatefulWidget {
  @override
  _mainChatScreenState createState() => _mainChatScreenState();
}

class _mainChatScreenState extends State<mainChatScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    List<Widget> _widgetOptions = <Widget>[
      chatBoard(userid: provider.userModel!.id!),
      globalChatBoard(),
    ];
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: AppLocalizations.of(context)!.chats,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: AppLocalizations.of(context)!.communities,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
