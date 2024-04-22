// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String message;
  TextInputType type;
  TextFormWidget({super.key , required this.controller , required this.message ,required this.type });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          keyboardType: type,
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return message;
            }
            return null;
          },
          cursorColor: Colors.black,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusColor: Colors.black,
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}
