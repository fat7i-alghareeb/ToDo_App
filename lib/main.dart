import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
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
