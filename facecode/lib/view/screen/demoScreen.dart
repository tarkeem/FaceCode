import 'package:facecode/controller/demoCtr.dart';
import 'package:flutter/material.dart';

class demoScreen extends StatelessWidget {
demoScreen({super.key});
TextEditingController _editingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Row(
        children: [
          Expanded(child: TextField(controller: _editingController,)),ElevatedButton(onPressed: () {
            demoCtr().sendDp(_editingController.text);
            _editingController.clear();
          }, child: Text('send'))
        ],
      ),),
    );
  }
}