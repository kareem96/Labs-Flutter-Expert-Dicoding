import 'package:flutter/material.dart';

import '../../constants.dart';

class HomeScreenAppBar extends StatelessWidget {
  final bool isScaled;
  final Function()? onNotScaled;
  final Function()? onScaled;
  const HomeScreenAppBar(
      {Key? key,
      required this.isScaled,
      required this.onNotScaled,
      required this.onScaled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _MenuBar(
            isScaled: isScaled,
            onNotScaled: onNotScaled,
            onScaled: onScaled,
          ),
          Column(
            children: [
              Text(
                'Location',
                style: Theme.of(context).textTheme.caption,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(
                    Icons.place_rounded,
                    size: 16,
                    color: AppColor.darkFontColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'New York,',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(width: 6),
                  const Text('USA'),
                ],
              ),
            ],
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/dp.jpg'),
          )
        ],
      ),
    );
  }
}

class _MenuBar extends StatelessWidget {
  final bool isScaled;
  final Function()? onNotScaled;
  final Function()? onScaled;
  const _MenuBar({
    Key? key,
    required this.isScaled,
    required this.onNotScaled,
    required this.onScaled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isScaled
        ? IconButton(
            onPressed: onScaled,
            icon: const Icon(Icons.arrow_back),
          )
        : IconButton(
            onPressed: onNotScaled,
            icon: const Icon(Icons.menu),
          );
  }
}
