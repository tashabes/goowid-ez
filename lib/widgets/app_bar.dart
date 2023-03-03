import 'package:flutter/material.dart';

class ResusableBar extends StatelessWidget implements PreferredSizeWidget {
  const ResusableBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.black,
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
