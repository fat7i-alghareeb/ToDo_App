import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import '../../business_logic/cubit/tasks_cubit.dart';
import '../../business_logic/cubit/tasks_state.dart';
import '../../constants.dart';
import 'package:flutter/services.dart';

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
            HeatMapCalendar(
              initDate: DateTime.now(),
              margin: const EdgeInsets.all(3),
              weekTextColor: Theme.of(context).colorScheme.tertiary,
              showColorTip: false,
              colorTipSize: 12,
              monthFontSize: 20,
              defaultColor: Theme.of(context).colorScheme.secondary,
              flexible: true,
              colorMode: ColorMode.color,
              datasets: datasets,
              colorsets: {
                0: Colors.transparent,
                1: Colors.grey[200]!,
                2: Colors.grey[300]!,
                3: Colors.grey[300]!,
                4: Colors.grey[400]!,
                5: Colors.grey,
                6: Colors.grey,
                7: Colors.grey[700]!,
                8: Colors.grey[800]!,
                9: Colors.grey[800]!,
                10: Colors.grey[900]!,
              },
              onClick: (value) {
                String stringDate = dateToString(value);
                BlocProvider.of<TasksCubit>(context).fetchDate = stringDate;
                BlocProvider.of<TasksCubit>(context).fetchSavedTasks();
                widget.pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear,
                );
                HapticFeedback.heavyImpact();
              },
            ),
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
