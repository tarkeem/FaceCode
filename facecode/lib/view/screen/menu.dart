import 'package:facecode/view/screen/auth/loginScreen.dart';
import 'package:facecode/view/screen/homepage.dart';
import 'package:facecode/view/screen/settings.dart';
import 'package:flutter/material.dart';


class Menu extends StatefulWidget {
  static const String routeName = "settingsPage";
  const Menu({super.key});

  @override
  State<Menu> createState() => _SettingsState();
}

class _SettingsState extends State<Menu> {
  List dum = [
    [
      "Home Page",
      "Icons.home",
    ],
    ["Groups", "Icons.groups"],
    ["Settings", "icons.settings"],
    ["Log Out", "icons.power"]
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: dum.length,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: Icon(
              index == 0
                  ? Icons.home
                  : index == 1
                      ? Icons.groups
                      : index == 2
                          ? Icons.settings
                          : index == 3
                              ? Icons.logout
                              : Icons.send_time_extension,
              size: 40,
              color: Colors.white,
            ),
            title: Text(
              dum[index][0]!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            onTap: () {
              if (index == 0) {
                Navigator.pushNamed(context, HomePage.routeName);
              }
              else if(index == 2){
                Navigator.pushNamed(context, Settings.routeName);
              }
              else if (index == 3) {
                Navigator.pushNamed(context, LoginScreen.routeName);
              }
            },
          ),
        ),
      ),
    );
  }
}
