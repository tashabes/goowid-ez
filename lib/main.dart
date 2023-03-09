import 'package:flutter/material.dart';
import 'package:goowid_auth/screens/chat/providers/chats_provider.dart';
import 'package:goowid_auth/screens/chat/providers/models_provider.dart';
import 'package:goowid_auth/screens/chat/screens/chat_screen.dart';
import 'package:goowid_auth/screens/entryPoint/components/profile.dart';
import 'package:goowid_auth/screens/entryPoint/components/profile_new.dart';
import 'package:goowid_auth/screens/entryPoint/entry_point.dart';
import 'package:goowid_auth/screens/home/home_test.dart';
import 'package:goowid_auth/screens/passwordManager/add_account.dart';
import 'package:goowid_auth/screens/passwordManager/document_mgmt.dart';
import 'package:goowid_auth/screens/register/register_screen.dart';
import 'package:goowid_auth/screens/register/verify_mobile.dart';
import 'package:goowid_auth/screens/sign_in_screen.dart/confirm_password.dart';
import 'package:goowid_auth/screens/sign_in_screen.dart/otp_verify_phone.dart';
import 'package:goowid_auth/screens/sign_in_screen.dart/signin.dart';
import 'package:goowid_auth/screens/document_manager.dart';
import 'package:goowid_auth/screens/toDo/to_do_list.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Goowid',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFEEF1F8),
          primarySwatch: Colors.blue,
          fontFamily: "Intel",
          textTheme: TextTheme(
            headline1: const TextStyle(
                color: Colors.black,
                letterSpacing: 1,
                fontSize: 34,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins'),
            headline2: const TextStyle(
                fontFamily: 'Poppins', fontSize: 30, color: Colors.black),
            subtitle1: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.grey[600]!,
            ),
            subtitle2: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.black,
            ),
          ),
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
          '/add_account': (BuildContext context) => new AddAccountScreen(),
          '/confirm_password': (BuildContext context) =>
              new ConfirmNewPassword(),
          '/OTP_verify_phone': (BuildContext context) => new OTPVerifyPhone(),
          '/OTP_verify_mobile': (BuildContext context) => new VerifyMobile(),
          '/upload_doc': (BuildContext context) => new DocumentManager(),
          '/document_mgmt': (BuildContext context) => new DocumentMgmt(),
          '/to_do_list': (BuildContext context) => new ToDoListPage(),
          '/chat_screen': (BuildContext context) => new ChatScreen(),
          '/user_profile': (BuildContext context) => new UserProfilePage(),
        },
        home: const OnbodingScreen(),
      ),
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
