import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'utils/service_locator.dart';
import 'shared/data/models/tasks.dart';
import 'theme.dart';
import 'shared/data/models/dated_tasks.dart';
import 'utils/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(DatedTasksAdapter());
  Hive.registerAdapter(TasksAdapter());
  await Hive.openBox<DatedTasks>("dated_tasks_box");
  await Hive.openBox<Tasks>("tasks_box");
  setupServiceLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo2',
      onGenerateRoute: _appRouter.generateRoute,
      theme: lightMode,
      //darkTheme: darkMode,
    );
  }
}
