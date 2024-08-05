import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dialog_widget.dart';
import '../../../../../shared/cubit/tasks_cubit.dart';

class TaskStyle extends StatelessWidget {
  const TaskStyle({
    super.key,
    required this.isChecked,
    required this.task,
    required this.whenCheck,
    required this.index,
  });
  final bool? isChecked;
  final String task;
  final Function(bool) whenCheck;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: EdgeInsets.zero,
      shadowColor: Theme.of(context).colorScheme.tertiary,
      elevation: 2,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: isChecked!
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: ListTile(
            trailing: EditTaskWidget(
              index: index,
            ),
            title: Text(
              task,
              style: TextStyle(
                decoration: isChecked! ? TextDecoration.lineThrough : null,
                decorationThickness: 2.5,
                decorationColor: Theme.of(context).colorScheme.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            leading: Checkbox(
              side: const BorderSide(
                width: 2,
              ),
              value: isChecked!,
              shape: const CircleBorder(),
              onChanged: (value) {
                whenCheck(value!);
                HapticFeedback.heavyImpact();
              },
              activeColor: Colors.black,
              checkColor: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
      ),
    );
  }
}

class EditTaskWidget extends StatelessWidget {
  const EditTaskWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialogWidget(
            onPressed: () {
              if (controller.text != '') {
                BlocProvider.of<TasksCubit>(context)
                    .changeTasks(index, controller.text);
                Navigator.of(context).pop();
                controller.clear();
              } else {
                Navigator.of(context).pop();
              }
            },
            title: 'Edit your tasks',
            hint: "Edit task",
            buttonText: "Edit",
            controller: controller,
          ),
        );
      },
      icon: const Icon(Icons.settings),
    );
  }
}
