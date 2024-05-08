import 'package:hive_flutter/hive_flutter.dart';
import 'tasks_repo.dart';
import '../models/dated_tasks.dart';

class TasksRepoImpl implements TasksRepo {
  var tasksBox = Hive.box<DatedTasks>("dated_tasks_box");
  @override
  List<DatedTasks> fetchSavedTasks({required String date}) {
    if (tasksBox.values.isEmpty || getDayIndex(date: date) == -1) {
      tasksBox.add(DatedTasks(date: date, tasks: []));
    }
    return tasksBox.values.toList();
  }

  @override
  void saveTask(DatedTasks task) async {
    final index = tasksBox.values
        .toList()
        .indexWhere((datedTasks) => datedTasks.date == task.date);

    if (index != -1) {
      await tasksBox.putAt(
          index,
          DatedTasks(
            date: task.date,
            tasks: task.tasks,
          ));
    } else {
      await tasksBox.add(task);
    }
  }

  @override
  getDayIndex({required String date}) {
    return tasksBox.values
        .toList()
        .indexWhere((datedTasks) => datedTasks.date == date);
  }

  @override
  void clearTasks() async {
    tasksBox.clear();
  }
}
