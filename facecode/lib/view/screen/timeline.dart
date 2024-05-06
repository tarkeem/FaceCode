// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../model/entities/user_model.dart';

class TimeLine extends StatelessWidget {
  UserModel model;
  TimeLine({super.key , required this.model});

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(child: Text(model.firstName ?? "lol"),));
  }
}
