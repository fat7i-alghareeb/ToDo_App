import '../data/models/tasks.dart';

sealed class TasksState {}

final class TasksInitial extends TasksState {
  final List<Tasks> tasks;
  TasksInitial({required this.tasks});
}
