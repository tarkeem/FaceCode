// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    //var provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              //provider.changeTheme(ThemeMode.light);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Light",
                  // style: GoogleFonts.elMessiri(
                  //     fontSize: 30,
                  //     color: provider.themeMode == ThemeMode.light
                  //         ? MyThemeData.primaryColor
                  //         : Colors.white),
                ),
                //if (provider.themeMode == ThemeMode.light) ...[
                  Icon(Icons.done, size: 35, color: Colors.black),
                //]
              ],
            ),
          ),
          InkWell(
            onTap: () {
              //provider.changeTheme(ThemeMode.dark);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark",
                  
                ),
                //if (provider.themeMode == ThemeMode.dark) ...[
                  Icon(Icons.done, size: 35, color: Colors.black),
                //]
              ],
            ),
          )
        ],
      ),
    );
  }
}
