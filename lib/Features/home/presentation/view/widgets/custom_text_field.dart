import 'package:flutter/material.dart';

class ToDoTextField extends StatefulWidget {
  final String hintText;
  const ToDoTextField({
    super.key,
    required this.myController,
    required this.hintText,
  });

  final TextEditingController myController;

  @override
  State<ToDoTextField> createState() => _ToDoTextFieldState();
}

class _ToDoTextFieldState extends State<ToDoTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Theme.of(context).colorScheme.tertiary,
      controller: widget.myController,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      onChanged: (text) {
        setState(() {});
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            widget.myController.clear();
            setState(() {});
          },
          icon: Icon(
            Icons.clear_rounded,
            color: widget.myController.text == ""
                ? Theme.of(context).colorScheme.tertiary
                : Colors.black,
          ),
        ),
        filled: true,
        fillColor: Colors.transparent,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 13,
          color: Color.fromARGB(38, 0, 0, 0),
          fontWeight: FontWeight.w100,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(11)),
          borderSide: BorderSide(
            color: Colors.black,
            width: 3,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
            width: 2,
          ),
        ),
      ),
    );
  }
}
