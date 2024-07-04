import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/auth/loginScreen.dart';
import 'package:facecode/view/screen/chat/globalChatBoard.dart';
import 'package:facecode/view/screen/homepage.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  static const String routeName = "settingsPage";
  const Menu({super.key});

  @override
  State<Menu> createState() => _SettingsState();
}

class _SettingsState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, HomePage.routeName);
              },
              child: Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        size: 30,
                        Icons.home,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text("Home Page",
                          style: Theme.of(context).textTheme.bodyLarge)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, globalChatBoard.routeName);
              },
              child: Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        size: 30,
                        Icons.group,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text("Groups",
                          style: Theme.of(context).textTheme.bodyLarge)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                ShowDialog.showCustomDialog(
                    context,
                    "Alert",
                    Text(
                      "Log out from your account?",
                      style: Theme.of(context).textTheme.bodySmall,
                    ), () {
                  provider.logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.routeName, (route) => false);
                });
              },
              child: Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        size: 30,
                        Icons.logout,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text("Logout",
                          style: Theme.of(context).textTheme.bodyLarge)
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
