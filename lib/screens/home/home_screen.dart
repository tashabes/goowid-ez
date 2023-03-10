import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/checklist.dart';
import 'components/checklist_card.dart';
import 'components/secondary_checklist_card.dart';

class HomePage extends StatefulWidget {
  static const String screenRoute = 'home_screen';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    /*User user = Provider.of<UserProvider>(context).user;*/
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Hello ${_name.replaceAll(RegExp(r'[^\w\s]+'), '')}',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: courses
                      .map(
                        (course) => Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: CourseCard(
                            title: course.title,
                            //iconSrc: .iconSrc,
                            color: course.color,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Authenticator",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              ...recentCourses
                  .map((course) => Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20),
                        child: SecondaryCourseCard(
                          title: course.title,
                          //iconsSrc: .iconSrc,
                          colorl: course.color,
                        ),
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  var _name;
  var _other;
  String? _email;
  var _phone;

  getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _name = preferences.getString('displayName')!;
      _other = preferences.getString('givenName')!;
      _email = preferences.getString('email') ?? '';
      _phone = preferences.getString('mobilePhone') ?? '';
    });
  }
}
