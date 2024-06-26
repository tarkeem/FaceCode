// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class EditDeleteWidget extends StatelessWidget {
  VoidCallback delete;
  VoidCallback edit;
  EditDeleteWidget({super.key, required this.delete, required this.edit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: edit,
          child: Row(
            children: [
              Text(
                'Edit',
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.edit,
                color: Colors.blue,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: delete,
          child: Row(
            children: [
              Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
