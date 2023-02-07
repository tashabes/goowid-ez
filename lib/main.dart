import 'package:flutter/material.dart';
import 'package:goowid_auth/screens/entryPoint/components/profile.dart';
import 'package:goowid_auth/screens/entryPoint/entry_point.dart';
import 'package:goowid_auth/screens/home/home_test.dart';
import 'package:goowid_auth/screens/register/register_screen.dart';
import 'package:goowid_auth/screens/sign_in_screen.dart/signin.dart';
import 'package:goowid_auth/screens/toDo/to_do_list.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/onboarding/onboarding.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();

  var box = await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Goowid',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEEF1F8),
        primarySwatch: Colors.blue,
        fontFamily: "Intel",
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(height: 0),
          border: defaultInputBorder,
          enabledBorder: defaultInputBorder,
          focusedBorder: defaultInputBorder,
          errorBorder: defaultInputBorder,
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/onboarding': (BuildContext context) => new OnbodingScreen(),
        '/entrypoint': (BuildContext context) => new EntryPoint(),
        '/register': (BuildContext context) => new RegisterScreen(),
        '/signin': (BuildContext context) => new SignIn(),
        '/homeTest': (BuildContext context) => new HomeTest(),
        '/profile': (BuildContext context) => new Profile(),
      },
      home: const OnbodingScreen(),
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);
