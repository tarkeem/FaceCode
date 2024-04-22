// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class msgBabble extends StatelessWidget {
  msgBabble(
      {required this.msg,
      required this.is_me,
      required this.userImageUrl,
      required this.userName});
  String msg;
  bool is_me;
  String userImageUrl;
  String userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          is_me ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
      if(is_me) CircleAvatar(),
            Flexible(
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: is_me ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomRight: !is_me ? Radius.zero : Radius.circular(12),
                      bottomLeft: !is_me ? Radius.circular(12) : Radius.zero,
                    )),
                child: Text(
                  msg,
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            ),
            if(!is_me) CircleAvatar(),
          ],
        
    );
  }
}