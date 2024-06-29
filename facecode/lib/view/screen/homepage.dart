import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/chat/chatBoardScreen.dart';
import 'package:facecode/view/screen/chat/mainBoard.dart';
import 'package:facecode/view/screen/menu.dart';
import 'package:facecode/view/screen/profile/my_profile_page.dart';
import 'package:facecode/view/screen/timeline.dart';
import 'package:facecode/view/widget/shared_signedin_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addpost.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "HomePage";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    final UserModel? userModel = provider.userModel;

    if (userModel == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(child: Text("User data is not available.")),
      );
    }

    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: SharedSignedInAppBar(
            showBackButton: false,
            userId: userModel.id,
            bottom: TabBar(
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home,
                    color: provider.myTheme == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                    size: 35,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.person_sharp,
                    color: provider.myTheme == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                    size: 35,
                  ),
                ),
                 Tab(
                  icon: Icon(
                    Icons.chat,
                    color: provider.myTheme == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                    size: 35,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.menu_rounded,
                    color: provider.myTheme == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                    size: 35,
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, Addpost.routeName,
                  arguments: userModel);
            },
            backgroundColor: Colors.grey[300],
            child: Icon(
              Icons.add,
            ),
          ),
          body: TabBarView(
            children: [
              Timeline(
                mainUser: provider.userModel,
              ),
              MyProfilePage(
                model: provider.userModel!,
              ),
              mainChatScreen(),
              
              Menu()
            ],
          )),
    );
  }
}
