// ignore_for_file: must_be_immutable
import 'package:facecode/model/entities/user_model.dart';
import 'package:flutter/material.dart';

class TimeLine extends StatelessWidget {
  UserModel model;
  TimeLine({super.key , required this.model});

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(child: Text(model.firstName ?? "lol"),));
  }
}
