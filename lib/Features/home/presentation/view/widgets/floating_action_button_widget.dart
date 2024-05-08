import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/cubit/tasks_cubit.dart';
import 'dialog_widget.dart';

class FloatingActionButtonWidget extends StatefulWidget {
  const FloatingActionButtonWidget({
    super.key,
  });

  @override
  State<FloatingActionButtonWidget> createState() =>
      _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState
    extends State<FloatingActionButtonWidget> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.add,
        size: 40,
        color: Colors.black,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialogWidget(
            onPressed: () {
              if (controller.text != '') {
                BlocProvider.of<TasksCubit>(context)
                    .saveTask(task: controller.text);
                Navigator.of(context).pop();
                controller.clear();
              } else {
                Navigator.of(context).pop();
              }
            },
            title: 'Add new task',
            hint: "New task",
            buttonText: "Add",
            controller: controller,
          ),
        );
      },
    );
  }
}
