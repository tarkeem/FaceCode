import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/menu.dart';
import 'package:facecode/view/screen/profile/profile_page.dart';
import 'package:facecode/view/screen/settings.dart';
import 'package:facecode/view/screen/timeline.dart';
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
    final UserModel userModel =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "FaceCode",
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppSettings.routeName);
                  },
                  child: Padding(
                    padding: provider.languageCode == "en"
                        ? EdgeInsets.only(right: 12)
                        : EdgeInsets.only(left: 12),
                    child: Icon(Icons.settings,
                        color: provider.myTheme == ThemeMode.dark
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              )
            ],
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
          body: TabBarView(
            children: [
              Timeline
              (
                model: userModel,
              ),
              ProfilePage(
                model: userModel,
              ),
              Menu()
            ],
          )),
    );
  }
}
