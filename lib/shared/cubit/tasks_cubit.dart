import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../data/models/dated_tasks.dart';
import '../data/models/tasks.dart';
import '../data/repo/tasks_repo_impl.dart';
import 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final TasksRepoImpl savedTasksRepo;
  List<DatedTasks> datedTasks = [];
  List<Tasks> tasks = [];
  TasksCubit(this.savedTasksRepo) : super(TasksInitial(tasks: []));
  String fetchDate = stringDateNow;
  void fetchSavedTasks() {
    datedTasks = savedTasksRepo.fetchSavedTasks(date: fetchDate);
    int dayIndex = getDayIndex(date: fetchDate);
    tasks = datedTasks[dayIndex].tasks;

    emit(TasksInitial(tasks: tasks));
  }

  List<int> numberOfTasksAndCheckedTasks() {
    List<int> x = [];
    var tasksLength = tasks.length;
    var checkedTasks = 0;
    for (var task in tasks) {
      task.isChecked ? checkedTasks++ : null;
    }
    x.add(tasksLength);
    x.add(checkedTasks);
    return x;
  }

  void changeTasks(int index, String newTasks) {
    tasks[index].task = newTasks;
    savedTasksRepo.saveTask(DatedTasks(date: fetchDate, tasks: tasks));
    fetchSavedTasks();
  }

  Map<DateTime, int> getPercentage() {
    datedTasks = savedTasksRepo.fetchSavedTasks(date: stringDateNow);
    Map<DateTime, int> datasets = {};
    for (var day in datedTasks) {
      int numberOfTasks = day.tasks.length;
      numberOfTasks == 0 ? numberOfTasks++ : null;
      int numberOfCheckedTasks = 0;
      for (var tasks in day.tasks) {
        if (tasks.isChecked) {
          numberOfCheckedTasks++;
        }
      }
      int percentage = (numberOfCheckedTasks * 10 / numberOfTasks).round();
      DateTime dateTime = stringToDate(day.date);
      datasets.addAll({dateTime: percentage});
    }
    return datasets;
  }

  void changeFetchDay(bool forward) {
    DateTime dateTime = stringToDate(fetchDate);
    forward
        ? fetchDate = dateToString(dateTime.add(const Duration(days: 1)))
        : fetchDate = dateToString(dateTime.subtract(const Duration(days: 1)));
    fetchSavedTasks();
  }

  getDateFormatted() {
    DateTime dateTime = stringToDate(fetchDate);
    String formattedDate = DateFormat('MMM d').format(dateTime);
    formattedDate += getDaySuffix(dateTime.day);
    return formattedDate;
  }

  void checked({required int index}) async {
    int dayIndex = getDayIndex(date: fetchDate);
    var tasksOfTheDay = datedTasks[dayIndex].tasks;
    tasksOfTheDay[index].isChecked = !tasksOfTheDay[index].isChecked;
    DatedTasks newDatedTasks =
        DatedTasks(date: datedTasks[dayIndex].date, tasks: tasksOfTheDay);
    savedTasksRepo.saveTask(newDatedTasks);
    fetchDate = fetchDate;
    fetchSavedTasks();
  }

  getDayIndex({required String date}) {
    return savedTasksRepo.getDayIndex(date: date);
  }

  void saveTask({required String task, bool isChecked = false}) {
    var tasksOfTheDay = datedTasks[getDayIndex(date: fetchDate)].tasks;
    tasksOfTheDay.add(Tasks(task: task, isChecked: isChecked));
    savedTasksRepo.saveTask(DatedTasks(date: fetchDate, tasks: tasksOfTheDay));

    fetchSavedTasks();
  }

  void unSaveTask({required int index}) {
    var tasksOfTheDay = datedTasks[getDayIndex(date: fetchDate)].tasks;
    tasksOfTheDay.removeAt(index);
    savedTasksRepo.saveTask(DatedTasks(
        date: datedTasks[getDayIndex(date: fetchDate)].date,
        tasks: tasksOfTheDay));

    fetchSavedTasks();
  }

  void changeOrder({required int oldIndex, required int newIndex}) {
    int x = getDayIndex(date: fetchDate);
    var tempTask = datedTasks[x].tasks[oldIndex];
    datedTasks[x].tasks.removeAt(oldIndex);
    datedTasks[x].tasks.insert(newIndex, tempTask);
    savedTasksRepo.saveTask(
        DatedTasks(date: datedTasks[x].date, tasks: datedTasks[x].tasks));
    fetchSavedTasks();
  }
}
