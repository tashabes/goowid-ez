// ignore_for_file: library_private_types_in_public_api, sized_box_for_whitespace, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:goowid_auth/UnusedScreens/src/presentation/app_bar.dart';
import 'package:goowid_auth/UnusedScreens/src/presentation/widgets/screens/Auth/registration_screen.dart';
import 'package:goowid_auth/UnusedScreens/src/presentation/widgets/screens/Auth/signin_screen.dart';
import 'package:goowid_auth/UnusedScreens/src/presentation/widgets/screens/Auth/my_button.dart';

import '../../../../../classes/language_constants.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  child: Image.asset('images/Goowid.png'),
                ),
                // ignore: prefer_const_constructors
                Text(
                  translation(context).yourDataYourChoice,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff2e386b),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            MyButton(
              color: Colors.orange[900]!,
              title: (translation(context).signIn),
              onPressed: () {
                Navigator.pushNamed(context, SignInScreen.screenRoute);
              },
            ),
            MyButton(
              color: Colors.indigo[800]!,
              title: (translation(context).register),
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.screenRoute);
              },
            )
          ],
        ),
      ),
    );
  }
}
