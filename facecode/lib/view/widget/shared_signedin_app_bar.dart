import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/search_screen.dart';
import 'package:facecode/view/screen/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SharedSignedInAppBar extends StatelessWidget implements PreferredSizeWidget{
  final TabBar? bottom;
  final String? userId;
  final bool showBackButton;
  const SharedSignedInAppBar({super.key,this.bottom, this.userId,required this.showBackButton});

  @override
  Size get preferredSize => Size.fromHeight(bottom != null ? kToolbarHeight + bottom!.preferredSize.height : kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return AppBar(
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      automaticallyImplyLeading: false,
      title: Text("FaceCode"),
      actions: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, SearchScreen.routeName, arguments: userId);
          },
          child: Padding(
            padding: provider.languageCode == "en"
                ? EdgeInsets.only(right: 12)
                : EdgeInsets.only(left: 12),
            child: Icon(
              Icons.search_sharp,
              color: provider.myTheme == ThemeMode.dark ? Colors.white : Colors.black,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppSettings.routeName);
          },
          child: Padding(
            padding: provider.languageCode == "en"
                ? EdgeInsets.only(right: 12)
                : EdgeInsets.only(left: 12),
            child: Icon(
              Icons.settings,
              color: provider.myTheme == ThemeMode.dark ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
      bottom: bottom,
    );
  }

}