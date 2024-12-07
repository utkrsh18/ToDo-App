import 'package:flutter/material.dart';
import 'package:untitled1/utilities/mybuttons.dart';

class Dialogbox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  Dialogbox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.purple[200],
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Add a new task',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Mybuttons(text: "Save", onPressed: onSave),
            const SizedBox(width: 8),
            Mybuttons(text: "Cancel", onPressed: onCancel),
          ],
          ),

        ]),
      ),
    );
  }
}
