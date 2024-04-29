import 'package:facecode/view/screen/addpost.dart';
import 'package:facecode/view/screen/profile_page.dart';
import 'package:facecode/view/screen/setting.dart';
import 'package:facecode/view/screen/timeline.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
              )),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "FaceCode",
            ),
            actions: [
              Icon(
                Icons.notifications_rounded,
                color: Colors.black,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 35,
                ),
              )
            ],
          ),
          body: Column(
            children: [
              TabBar(
                indicatorColor: Colors.black,
                tabs: [
                  Padding(
                      padding: EdgeInsets.all(7),
                      child: Icon(
                        Icons.home,
                        color: Colors.black,
                        size: 35,
                      )),
                  Icon(
                    Icons.person_sharp,
                    color: Colors.black,
                    size: 35,
                  ),
                  Icon(
                    Icons.menu_rounded,
                    color: Colors.black,
                    size: 35,
                  )
                ],
              ),
              Expanded(
                  child: TabBarView(
                children: [Timeline(), ProfilePage(), Settings()],
              ))
            ],
          ),
        ));
  }
}
