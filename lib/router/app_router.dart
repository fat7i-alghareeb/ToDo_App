import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business_logic/cubit/tasks_cubit.dart';
import '../constants.dart';
import '../data/repo/tasks_repo.dart';
import '../presentation/pages/pages_control.dart';

class AppRouter {
  late SavedTasksRepo savedTasksRepo;
  late TasksCubit tasksCubit;
  AppRouter() {
    savedTasksRepo = SavedTasksRepo();
    tasksCubit = TasksCubit(savedTasksRepo);
  }
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case pageControlRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => tasksCubit,
            child: const PagesController(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
