// ignore_for_file: must_be_immutable

import 'package:facecode/providers/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFormWidget extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String message;
  TextInputType type;
  TextFormWidget({super.key , required this.controller , required this.message ,required this.type });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Column(
      children: [
        TextFormField(
          style: Theme.of(context).textTheme.bodySmall,
          keyboardType: type,
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return message;
            }
            return null;
          },
          cursorColor:  provider.myTheme == ThemeMode.dark ? Colors.white : Colors.black,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color:  provider.myTheme == ThemeMode.dark ? Colors.white : Colors.black,),
            ),
            errorStyle: TextStyle( 
              color: Colors.red, 
              fontSize: 12, 
              fontWeight: FontWeight.w500
            ),
            focusColor: Colors.black,
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}
