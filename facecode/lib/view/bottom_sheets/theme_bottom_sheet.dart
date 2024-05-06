// ignore_for_file: must_be_immutable

import 'package:facecode/providers/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.light);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (provider.myTheme == ThemeMode.light) ...[
                  Text(
                    "Light",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black),
                  ),
                  Icon(Icons.done, size: 35, color: Colors.black)
                ] else
                  Text(
                    "Light",
                    style: TextStyle(fontSize: 25, color: Colors.grey),
                  ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.dark);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (provider.myTheme == ThemeMode.dark) ...[
                  Text(
                    "Dark",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black),
                  ),
                  Icon(Icons.done, size: 35, color: Colors.black)
                ] else
                  Text(
                    "Dark",
                    style: TextStyle(fontSize: 25, color: Colors.grey),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
