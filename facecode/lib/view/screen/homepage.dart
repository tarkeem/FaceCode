import 'package:facecode/view/screen/menu.dart';
import 'package:facecode/view/screen/profile_page.dart';
import 'package:facecode/view/screen/timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../model/entities/user_model.dart';
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
    final UserModel userModel =
    ModalRoute.of(context)!.settings.arguments as UserModel;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, Addpost.routeName);
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

            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.person_sharp,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.menu_rounded,
                    color: Colors.black,
                    size: 35,
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              TimeLine(
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
