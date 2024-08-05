import 'package:flutter/material.dart';

import 'nav_icon.dart';

class CustomBottomBar extends StatelessWidget {
  final void Function(int) onItemTapped;
  final int selectedIndex;
  const CustomBottomBar(
      {super.key, required this.onItemTapped, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsets.only(bottom: 20, top: 10, left: 10, right: 10),
      height: 50,
      child: Row(
        children: [
          NavigatorIcon(
            icon: Icons.home,
            setChange: () {
              onItemTapped(0);
            },
            changing: selectedIndex == 0 ? true : false,
          ),
          NavigatorIcon(
            icon: Icons.calendar_month_rounded,
            setChange: () {
              onItemTapped(1);
            },
            changing: selectedIndex == 1 ? true : false,
          ),
          NavigatorIcon(
            icon: Icons.person,
            setChange: () {
              onItemTapped(2);
            },
            changing: selectedIndex == 2 ? true : false,
          ),
        ],
      ),
    );
  }
}
