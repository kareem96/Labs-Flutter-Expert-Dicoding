import 'package:flutter/material.dart';
import 'package:ui_drawer_translation/models/category.dart';

import '../../constants.dart';

class CategoryIcon extends StatelessWidget {
  final bool isSelected;
  final Function(String value) onSelect;
  const CategoryIcon({
    Key? key,
    required this.category,
    required this.onSelect,
    this.isSelected = false,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    var margin = const EdgeInsets.only(left: 25);
    var padding = const EdgeInsets.symmetric(horizontal: 5);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColor.backgroundColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: margin,
          padding: padding,
          child: IconButton(
            onPressed: () => onSelect(category.title),
            icon: Image.asset(
              category.icon,
              color: isSelected ? Colors.white : AppColor.disableFontColor,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          margin: margin,
          child: Text(category.title),
        ),
      ],
    );
  }
}
