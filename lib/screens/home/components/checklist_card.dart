import 'package:flutter/material.dart';
import 'package:goowid_auth/screens/passwordManager/document_mgmt.dart';

//import 'package:flutter_svg/flutter_svg.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
    required this.title,
    this.color = const Color(0xFF7553F6),
    //this.iconSrc = "assets/icons/ios.svg",
  }) : super(key: key);

  final String title; //iconSrc;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      height: 280,
      width: 260,
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
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 8),
                    child: Text(
                      "NI number, ID, bank accounts... keep all your personal data safe and easy to find.",
                      style: TextStyle(
                        color: Colors.white38,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DocumentMgmt()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Get Started >",
                          style: TextStyle(
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    ),
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
