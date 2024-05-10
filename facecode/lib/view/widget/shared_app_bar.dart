import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  SharedAppBar({super.key , required this.showBackButton});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return AppBar(
      leading: showBackButton
          ? IconButton(
              // Check if showBackButton is true
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null, // Show back button only if showBackButton is true
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
      automaticallyImplyLeading: false,
      title: Text("FaceCode"),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
