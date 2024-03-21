import 'package:get_it/get_it.dart';
import '../shared/data/repo/tasks_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<TasksRepoImpl>(TasksRepoImpl());
}
