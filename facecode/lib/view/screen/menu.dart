import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/favourite_posts_screen.dart';
import 'package:facecode/view/screen/auth/loginScreen.dart';
import 'package:facecode/view/screen/chat/globalChatBoard.dart';
import 'package:facecode/view/screen/homepage.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                      Text(AppLocalizations.of(context)!.home_page,
                          style: TextStyle(color: Colors.white))
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
                      Text(AppLocalizations.of(context)!.groups,
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, FavouritePostsScreen.routeName);
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
                        Icons.star,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(AppLocalizations.of(context)!.favourite_posts,
                          style: TextStyle(color: Colors.white))
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
                    AppLocalizations.of(context)!.alert,
                    Text(
                      AppLocalizations.of(context)!.logout_from_your_account,
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
                      Text(AppLocalizations.of(context)!.logout,
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
