import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  SharedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: 15,
          ),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, Settings.routeName);
            },
            child: Padding(
              padding: provider.languageCode == "en" ? EdgeInsets.only(right: 12) : EdgeInsets.only(left: 12),
              child: Icon(
                Icons.settings,
                color: Colors.black,
              ),
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
