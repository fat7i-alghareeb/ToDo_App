import 'package:flutter/material.dart';
import 'widgets/floating_action_button_widget.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FloatingActionButtonWidget(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            const HomeAppBar(),
          ];
        },
        body: const HomeBody(),
      ),
    );
  }
}
