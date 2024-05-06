// ignore_for_file: must_be_immutable

import 'package:facecode/providers/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';


class TextFormPasswordWidget extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  bool obscureText;
  TextFormPasswordWidget(
      {super.key, required this.controller, required this.obscureText});

  @override
  State<TextFormPasswordWidget> createState() => _TextFormPasswordWidgetState();
}

class _TextFormPasswordWidgetState extends State<TextFormPasswordWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Column(
      children: [
        TextFormField(
          style: Theme.of(context).textTheme.bodySmall,
          controller: widget.controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.please_enter_password;
            }
            return null;
          },
          cursorColor:  provider.myTheme == ThemeMode.dark ? Colors.white : Colors.black,
          obscureText: widget.obscureText,
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
            focusColor:  provider.myTheme == ThemeMode.dark ? Colors.white : Colors.black,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  widget.obscureText = !widget.obscureText;
                });
              },
              icon: Icon(
                widget.obscureText ? Icons.visibility : Icons.visibility_off,
                color: provider.myTheme == ThemeMode.dark ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
