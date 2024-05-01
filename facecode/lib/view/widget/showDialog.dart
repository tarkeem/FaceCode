import 'package:facecode/providers/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowDialog {
  static void showCustomDialog(BuildContext context, String title, Widget widget , Function function) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        var provider = Provider.of<MyProvider>(context);
        return AlertDialog(
          backgroundColor: provider.myTheme == ThemeMode.dark ? Colors.black : Colors.white,
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          content: widget,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: provider.myTheme == ThemeMode.dark ? Colors.white : Colors.black,
              ),
              onPressed: () {
                function();
              },
              child: Text(
                "Ok",
                style: TextStyle(color: provider.myTheme == ThemeMode.dark ? Colors.black : Colors.white,fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      },
    );
  }
}
