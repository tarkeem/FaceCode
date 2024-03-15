import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  TextEditingController textEditingController;
  String text;
  Icon icon;
  CustomTextField(
      {super.key,
      required this.text,
      required this.icon,
      required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 3),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(7)),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          labelText: text,
          prefixIcon: icon,
        ),
      ),
    );
  }
}