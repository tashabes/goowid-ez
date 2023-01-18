import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goowid_auth/screens/register/register_form.dart';

import '../onboding/components/sign_in_form.dart';

class RegisterScreen extends StatefulWidget {
  static const String screenRoute = 'registration_screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Scaffold(
            body: Stack(
              clipBehavior: Clip.none,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          "Register for Goowid Authenticator",
                          style: TextStyle(
                            fontSize: 34,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Securely store and manage your passwords with Goowid Authenticator.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const RegisterForm(),
                      Row(
                        children: const [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "OR",
                              style: TextStyle(
                                color: Colors.black26,
                              ),
                            ),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RegisterScreen.screenRoute);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Text(
                            "Sign in with email",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegisterScreen.screenRoute);
                            },
                            icon: SvgPicture.asset(
                              "assets/icons/email_box.svg",
                              height: 64,
                              width: 64,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Positioned(
                  left: 0,
                  right: 0,
                  bottom: -48,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
