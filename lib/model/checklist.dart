import 'package:flutter/material.dart' show Color;

class Course {
  final String title, description; //iconSrc;
  final Color color;

  Course({
    required this.title,
    this.description = 'Sync your autofill data',
    //this.iconSrc = "assets/icons/.svg",
    this.color = const Color(0xFF7553F6),
  });
}

final List<Course> courses = [
  Course(
    title: "Document Manager",
  ),
  Course(
    title: "Digital Wallet Set Up.",
    //iconSrc: "assets/icons/.svg",
    color: const Color(0xFF80A4FF),
  ),
];

final List<Course> recentCourses = [
  Course(title: "ETZ AD"),
  Course(
    title: "Facebook",
    color: const Color(0xFF9CC5FF),
    //iconSrc: "assets/icons/.svg",
  ),
  Course(title: "Goowid"),
  Course(
    title: "Caspian",
    color: const Color(0xFF9CC5FF),
    //iconSrc: "assets/icons/.svg",
  ),
];
