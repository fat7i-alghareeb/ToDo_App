import '../models/dated_tasks.dart';

abstract class TasksRepo {
  List<DatedTasks> fetchSavedTasks({required String date});
  void saveTask(DatedTasks task);
  getDayIndex({required String date});
  void clearTasks();
}
