import 'package:flutter/material.dart';

class WorkCard extends StatelessWidget {
  const WorkCard({
    Key? key,
    required this.title,
    required this.company,
    required this.time,
    required this.skill,
    required this.skill2,
    required this.skill3,
    this.color = const Color(0xFF7553F6),
    //this.iconSrc = "assets/icons/ios.svg",
  }) : super(key: key);

  final String title; //iconSrc;
  final String company;
  final String time;
  final String skill;
  final String skill2;
  final String skill3;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      height: 250,
      width: 350,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 6, right: 8),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.work,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 8),
                        child: Text(
                          company,
                          style: const TextStyle(
                            color: Colors.white38,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.lock_clock,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 8),
                        child: Text(
                          time,
                          style: const TextStyle(
                            color: Colors.white38,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            skill,
                            style: const TextStyle(
                              color: Colors.white54,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            skill2,
                            style: const TextStyle(
                              color: Colors.white54,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            skill3,
                            style: const TextStyle(
                              color: Colors.white54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: List.generate(
                      3,
                      (index) => Transform.translate(
                        offset: Offset((-10 * index).toDouble(), 0),
                        // child: CircleAvatar(
                        //   radius: 20,
                        //   backgroundImage: AssetImage(
                        //"assets/avaters/Avatar ${index + 1}.jpg",
                        //   ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //SvgPicture.asset(iconSrc),
        ],
      ),
    );
  }
}
