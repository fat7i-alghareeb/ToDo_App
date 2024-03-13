import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String hint;
  final String buttonText;
  final void Function() onPressed;
  final TextEditingController controller;
  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.hint,
    required this.buttonText,
    required this.onPressed,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: Text(title),
      content: ToDoTextField(
        myController: controller,
        hintText: hint,
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
