import 'package:hive_flutter/hive_flutter.dart';

import 'tasks.dart';

part 'dated_tasks.g.dart';

@HiveType(typeId: 1)
class DatedTasks extends HiveObject {
  @HiveType(typeId: 0)
  final String date;
  @HiveType(typeId: 1)
  final List<Tasks> tasks;

  DatedTasks({required this.date, required this.tasks});
}
