import 'package:flutter/material.dart';
import 'package:ui_drawer_translation/models/category.dart';
import 'package:ui_drawer_translation/provider/category_provider.dart';

import 'category_details.dart';
import 'category_icon.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late final List<Category> categoryList;
  String selectedCategoryString = 'Cats';

  @override
  void initState() {
    var categoryProvider = CategoryProvider()..fetchData();
    categoryList = categoryProvider.getCategories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Category selectedCategory = categoryList
        .firstWhere((element) => element.title == selectedCategoryString);

    return Column(
      children: [
        SizedBox(
          height: 75,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var category = categoryList[index];
              return CategoryIcon(
                  category: category,
                  isSelected: category.title == selectedCategoryString,
                  onSelect: (value) {
                    setState(() {
                      selectedCategoryString = value;
                    });
                  });
            },
            itemCount: categoryList.length,
          ),
        ),
        Expanded(
          child: CategoryDetails(selectedCategory: selectedCategory),
        ),
      ],
    );
  }
}
