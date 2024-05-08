import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../service_locator.dart';

import '../../shared/cubit/tasks_cubit.dart';
import '../../constants.dart';
import '../../shared/data/repo/tasks_repo_impl.dart';
import '../../Features/navigator/presentation/view/pages_control.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case pageControlRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TasksCubit(getIt.get<TasksRepoImpl>()),
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
