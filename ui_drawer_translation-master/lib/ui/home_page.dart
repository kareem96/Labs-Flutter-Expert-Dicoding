import 'package:flutter/material.dart';
import 'package:ui_drawer_translation/widgets/app_drawer.dart';
import 'package:ui_drawer_translation/ui/home_screen/home_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          AppDrawer(),
          HomeScreen(),
        ],
      ),
    );
  }
}
