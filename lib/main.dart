// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:goowid_auth/src/presentation/widgets/screens/Auth/chat_screen.dart';
import 'src/presentation/widgets/screens/Auth/registration_screen.dart';
import 'src/presentation/widgets/screens/Auth/signin_screen.dart';
import 'src/presentation/widgets/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    RegistrationScreen;
    return MaterialApp(
      title: 'Goowid Auth',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: _auth.currentUser != null
          ? ChatScreen.screenRoute
          : WelcomeScreen.screenRoute,
      routes: {
        WelcomeScreen.screenRoute: (context) => WelcomeScreen(),
        SignInScreen.screenRoute: (context) => SignInScreen(),
        RegistrationScreen.screenRoute: (context) => RegistrationScreen(),
        ChatScreen.screenRoute: (context) => ChatScreen(),
      },
    );
  }
}
