import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/cubit/tasks_cubit.dart';
import '../../../../../shared/cubit/tasks_state.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;

    return SliverAppBar(
      flexibleSpace: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => BlocProvider.of<TasksCubit>(context)
                          .changeFetchDay(false),
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 40,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        BlocProvider.of<TasksCubit>(context).getDateFormatted(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => BlocProvider.of<TasksCubit>(context)
                          .changeFetchDay(true),
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 40,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      toolbarHeight: (hight * 9) / 100,
      elevation: 0,
      expandedHeight: (hight * 10) / 100,
      titleSpacing: 10,
    );
  }
}
