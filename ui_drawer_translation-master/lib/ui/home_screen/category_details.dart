import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ui_drawer_translation/models/category.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({
    Key? key,
    required this.selectedCategory,
  }) : super(key: key);

  final Category selectedCategory;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) {
        var details = selectedCategory.details[index];
        return SizedBox(
          height: 200,
          child: Row(
            children: [
              Expanded(
                  child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 35),
                    decoration: BoxDecoration(
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)]
                          .withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Image.asset(details.image),
                ],
              )),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 55, bottom: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              details.name,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Icon(details.isMale
                                ? Icons.male_rounded
                                : Icons.female_rounded),
                          ],
                        ),
                        Text(
                          details.description,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          details.age,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.place_rounded, size: 14),
                            const SizedBox(width: 5),
                            Text(
                              details.distance,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: selectedCategory.details.length,
    );
  }
}
