import 'package:flutter/material.dart';

class ShowDialog {
  static void showCustomDialog(BuildContext context, String title, Widget widget , Function function) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: widget,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                function();
              },
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        );
      },
    );
  }
}
