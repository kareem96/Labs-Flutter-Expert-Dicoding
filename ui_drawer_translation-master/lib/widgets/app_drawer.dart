import 'package:flutter/material.dart';

import '../constants.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.backgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _TopBar(),
              _MiddleContent(),
              _BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiddleContent extends StatelessWidget {
  const _MiddleContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _IconText(
          iconData: Icons.pets_rounded,
          text: 'Adoption',
          isSelected: true,
        ),
        _IconText(
          iconData: Icons.volunteer_activism_rounded,
          text: 'Donation',
        ),
        _IconText(
          iconData: Icons.add_rounded,
          text: 'Add pet',
        ),
        _IconText(
          iconData: Icons.favorite_rounded,
          text: 'Favorites',
        ),
        _IconText(

          iconData: Icons.email_rounded,
          text: 'Messages',
        ),
        _IconText(
          iconData: Icons.person_rounded,
          text: 'Profile',
        ),
      ],
    ));
  }
}

class _IconText extends StatelessWidget {
  final IconData iconData;
  final String text;
  final bool isSelected;
  const _IconText({
    Key? key,
    required this.iconData,
    required this.text,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      iconColor: AppColor.disableFontColor,
      selectedColor: AppColor.lightFontColor,
      textColor: AppColor.disableFontColor,
      child: ListTile(
        selected: isSelected,
        leading: Icon(iconData),
        title: Text(text),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double spacing = 20;
    return Row(
      children: const [
        Icon(Icons.settings),
        SizedBox(width: spacing),
        Text('Settings'),
        SizedBox(width: spacing),
        Text('|'),
        SizedBox(width: spacing),
        Text('Log out'),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/dp.jpg'),
        ),
        const SizedBox(width: 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kazimacka Anatolia',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: 8),
            Text(
              'Active',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        )
      ],
    );
  }
}
