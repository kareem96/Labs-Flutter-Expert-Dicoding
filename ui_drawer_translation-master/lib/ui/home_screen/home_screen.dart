import 'package:flutter/material.dart';
import 'package:ui_drawer_translation/constants.dart';

import 'category_list.dart';
import 'home_screen_app_bar.dart';
import 'search_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double xOffset;
  late double yOffset;
  late double scaleFactor;
  bool isScaled = false;

  @override
  void initState() {
    _resetValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: !isScaled
            ? null
            : () {
                setState(() {
                  _resetValues();
                  isScaled = false;
                });
              },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: !isScaled ? null : BorderRadius.circular(30),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              HomeScreenAppBar(
                isScaled: isScaled,
                onNotScaled: _onNotScaled,
                onScaled: _onScaled,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColor.pageBackground,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: const [
                      SearchBox(),
                      Expanded(
                        child: CategoryList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onScaled() {
    setState(() {
      _resetValues();
      isScaled = false;
    });
  }

  _onNotScaled() {
    setState(() {
      _setValues();
      isScaled = true;
    });
  }

  _resetValues() {
    xOffset = 0;
    yOffset = 0;
    scaleFactor = 1;
  }

  _setValues() {
    xOffset = 0.35 * MediaQuery.of(context).size.height;
    yOffset = 0.2 * MediaQuery.of(context).size.width;
    scaleFactor = 0.7;
  }
}
