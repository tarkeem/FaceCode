// ignore_for_file: must_be_immutable
import 'package:facecode/model/entities/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TimeLine extends StatelessWidget {
  UserModel model;
  TimeLine({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200,
          width: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset("images/emptyFeed.png"),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Your feed is empty !",
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}
