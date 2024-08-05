import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

import '../../../../../constants.dart';
import '../../../../../shared/cubit/tasks_cubit.dart';
import '../heat_map_page.dart';

class HeatMapWidget extends StatelessWidget {
  const HeatMapWidget({
    super.key,
    required this.datasets,
    required this.widget,
  });

  final Map<DateTime, int> datasets;
  final HeatMapPage widget;

  @override
  Widget build(BuildContext context) {
    return HeatMapCalendar(
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
    );
  }
}
