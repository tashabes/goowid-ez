import 'package:flutter/material.dart';

class ResusableBar extends StatelessWidget implements PreferredSizeWidget {
  const ResusableBar({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.black,
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
