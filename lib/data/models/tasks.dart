import 'package:hive_flutter/hive_flutter.dart';

part 'tasks.g.dart';

@HiveType(typeId: 0)
class Tasks extends HiveObject {
  @HiveType(typeId: 0)
  String task;
  @HiveType(typeId: 1)
  bool isChecked;

  Tasks({required this.task, required this.isChecked});
}
