import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/cubit/tasks_cubit.dart';
import '../../../../../shared/cubit/tasks_state.dart';
import 'slidable.dart';
import 'tasks_style.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    super.key,
  });

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    BlocProvider.of<TasksCubit>(context).fetchSavedTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state is TasksInitial) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ReorderableListView.builder(
              onReorder: (oldIndex, newIndex) {
                if (oldIndex < newIndex) {
                  newIndex--;
                }
                BlocProvider.of<TasksCubit>(context)
                    .changeOrder(oldIndex: oldIndex, newIndex: newIndex);
              },
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: state.tasks.length,
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                key: ValueKey(state.tasks[index]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SlidableWidget(
                    onPressed: (context) {
                      BlocProvider.of<TasksCubit>(context)
                          .unSaveTask(index: index);
                      HapticFeedback.vibrate();
                    },
                    child: TaskStyle(
                      isChecked: state.tasks[index].isChecked,
                      task: state.tasks[index].task,
                      whenCheck: (x) {
                        BlocProvider.of<TasksCubit>(context)
                            .checked(index: index);
                      },
                      index: index,
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
