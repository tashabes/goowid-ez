import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_svg/svg.dart';

class SecondaryCourseCard extends StatelessWidget {
// Retrieving a value

  const SecondaryCourseCard({
    Key? key,
    required this.title,
    required this.colorl,
    //this.iconsSrc = "assets/icons/ios.svg",
  }) : super(key: key);

  final String title; //iconsSrc;
  final Color colorl;

  Future<String> getValue(preferences) async {
    final name = await SharedPreferences.getInstance();
    return preferences.getString.displayName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
          color: colorl,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
            child: VerticalDivider(
              thickness: 5,
              color: Colors.white70,
            ),
          ),
          const SizedBox(width: 8),
          //SvgPicture.asset(iconsSrc)
        ],
      ),
    );
  }
}
