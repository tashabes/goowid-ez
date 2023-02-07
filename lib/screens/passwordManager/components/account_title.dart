import 'package:flutter/material.dart';

class AccountTitle extends StatelessWidget {
  const AccountTitle({
    Key? key,
    required this.title,
    this.isPadding = false,
  }) : super(key: key);
  final String title;
  final bool isPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
        ),
        if (isPadding == true) const SizedBox(height: 4.0),
      ],
    );
  }
}
