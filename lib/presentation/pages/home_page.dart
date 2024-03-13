import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/tasks_cubit.dart';

import '../../business_logic/cubit/tasks_state.dart';
import '../widgets/dialog_widget.dart';
import '../widgets/tasks.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    TextEditingController controller = TextEditingController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
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
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              flexibleSpace: BlocBuilder<TasksCubit, TasksState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () =>
                                  BlocProvider.of<TasksCubit>(context)
                                      .changeFetchDay(false),
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 40,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                BlocProvider.of<TasksCubit>(context)
                                    .getDateFormatted(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  BlocProvider.of<TasksCubit>(context)
                                      .changeFetchDay(true),
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 40,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              toolbarHeight: (hight * 9) / 100,
              elevation: 0,
              expandedHeight: (hight * 10) / 100,
              titleSpacing: 10,
            )
          ];
        },
        body: const Tasks(),
      ),
    );
  }
}
