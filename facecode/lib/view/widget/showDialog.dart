import 'package:facecode/providers/my_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShowDialog {
  static void showCustomDialog(BuildContext context, String title,
      Widget widget, Function function, [int addpost = 0]) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        var provider = Provider.of<MyProvider>(context);
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: AlertDialog(
            backgroundColor: provider.myTheme == ThemeMode.dark
                ? Colors.black
                : Colors.white,
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            contentTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            content: widget,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  addpost != 1
                      ? Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 0),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                      ),
                      onPressed: () {
                        function();
                      },
                      child: Text(
                        "Ok",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
