// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:goowid_auth/classes/language_constants.dart';
import 'package:goowid_auth/src/presentation/widgets/screens/Auth/chat_screen.dart';
import 'src/presentation/widgets/screens/Auth/registration_screen.dart';
import 'src/presentation/widgets/screens/Auth/signin_screen.dart';
import 'src/presentation/widgets/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => setLocale(locale));
    super.didChangeDependencies();
  }

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    RegistrationScreen;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Goowid Auth',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
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
