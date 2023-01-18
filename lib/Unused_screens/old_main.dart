// ignore_for_file: prefer_const_constructors

/*import 'package:flutter/material.dart';

import 'package:goowid_auth/screens/onboarding/onboarding_screen.dart';
import 'package:goowid_auth/src/presentation/widgets/screens/Auth/chat_screen.dart';
import 'package:goowid_auth/entry_point.dart';
import 'classes/language_constants.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';

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
          : OnboardingScreen.screenRoute,
      routes: {
        OnboardingScreen.screenRoute: (context) => OnboardingScreen(),
        ChatScreen.screenRoute: (context) => ChatScreen(),
        EntryPoint.screenRoute: (context) => EntryPoint(),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('lib/src/assets/secure_splash_screen.json'),
      nextScreen: WelcomeScreen(),
      splashIconSize: 250,
      backgroundColor: Colors.orange.shade900,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 1),
    );
  }
}*/
