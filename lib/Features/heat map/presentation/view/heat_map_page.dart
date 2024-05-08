import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/cubit/tasks_cubit.dart';
import '../../../../shared/cubit/tasks_state.dart';
import '../../../../constants.dart';
import 'package:flutter/services.dart';
import 'widgets/heat_map_widget.dart';

class HeatMapPage extends StatefulWidget {
  final PageController pageController;
  const HeatMapPage({super.key, required this.pageController});

  @override
  State<HeatMapPage> createState() => _HeatMapPageState();
}

class _HeatMapPageState extends State<HeatMapPage> {
  Map<DateTime, int> datasets = {};
  List<int> tasksInfo = [];
  int numberOfTasks = 0;
  int checkedTasks = 0;
  String formattedDate = '';
  @override
  void initState() {
    datasets = BlocProvider.of<TasksCubit>(context).getPercentage();
    formattedDate = BlocProvider.of<TasksCubit>(context).getDateFormatted();
    tasksInfo =
        BlocProvider.of<TasksCubit>(context).numberOfTasksAndCheckedTasks();
    numberOfTasks = tasksInfo[0];
    checkedTasks = tasksInfo[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.restore,
          size: 40,
          color: Colors.black,
        ),
        onPressed: () {
          widget.pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
          );
          BlocProvider.of<TasksCubit>(context).fetchDate = dateToString(now);
          BlocProvider.of<TasksCubit>(context).fetchSavedTasks();
          HapticFeedback.heavyImpact();
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            HeatMapWidget(datasets: datasets, widget: widget),
            BlocBuilder<TasksCubit, TasksState>(
              builder: (context, state) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                        Text(
                          "$checkedTasks Accomplished tasks of $numberOfTasks",
                          style: const TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
