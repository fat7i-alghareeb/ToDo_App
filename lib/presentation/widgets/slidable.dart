import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableWidget extends StatelessWidget {
  final Function(BuildContext) onPressed;
  final Widget? child;
  const SlidableWidget({
    required this.child,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.3,
        children: [
          SlidableAction(
            onPressed: onPressed,
            icon: Icons.delete,
            backgroundColor: Colors.red.shade300,
            borderRadius: BorderRadius.circular(20),
            label: 'Delete',
          ),
        ],
      ),
      child: child!,
    );
  }
}
