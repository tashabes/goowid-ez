import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goowid_auth/utils/routes.dart';

import 'components/forgotton_password_dialog.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  int start = 30;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF77D8E),
        textStyle: const TextStyle(fontSize: 16, fontFamily: 'Poppins'));
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text('Verification code',
                          style: Theme.of(context).textTheme.headline2),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'We have sent the code verifcation to:',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.phoneNumber,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                String title = "Forgot Password";
                                String message =
                                    "Enter your phone number.  We'll send you a verification code to reset your password.";
                                showAlertDialog(context, title, message);
                              },
                              child: Text(
                                'Change phone number?',
                                style: TextStyle(color: Color(0xFFF77D8E)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 30,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.grey.shade300,
                                margin: EdgeInsets.symmetric(horizontal: 12.0),
                              ),
                            ),
                            Text(
                              'Enter your 6 digit code',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.grey.shade300,
                                margin: EdgeInsets.symmetric(horizontal: 12.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 55,
                                width: 51,
                                child: TextFormField(
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  onSaved: (pin1) {},
                                  decoration:
                                      const InputDecoration(hintText: "0"),
                                  style: Theme.of(context).textTheme.headline6,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 55,
                                width: 51,
                                child: TextFormField(
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  onSaved: (pin2) {},
                                  decoration:
                                      const InputDecoration(hintText: "0"),
                                  style: Theme.of(context).textTheme.headline6,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 55,
                                width: 51,
                                child: TextFormField(
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  onSaved: (pin3) {},
                                  decoration:
                                      const InputDecoration(hintText: "0"),
                                  style: Theme.of(context).textTheme.headline6,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 55,
                                width: 51,
                                child: TextFormField(
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  onSaved: (pin4) {},
                                  decoration:
                                      const InputDecoration(hintText: "0"),
                                  style: Theme.of(context).textTheme.headline6,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 55,
                                width: 51,
                                child: TextFormField(
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  onSaved: (pin5) {},
                                  decoration:
                                      const InputDecoration(hintText: "0"),
                                  style: Theme.of(context).textTheme.headline6,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 55,
                                width: 51,
                                child: TextFormField(
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  onSaved: (pin6) {},
                                  decoration:
                                      const InputDecoration(hintText: "0"),
                                  style: Theme.of(context).textTheme.headline6,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "Send code again in ",
                                style: Theme.of(context).textTheme.subtitle1),
                            TextSpan(
                                text: "00:$start ",
                                style: Theme.of(context).textTheme.subtitle1),
                            TextSpan(
                                text: "seconds",
                                style: Theme.of(context).textTheme.subtitle1),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 300,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                style: style,
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, signIn);
                                },
                                child: Text('Cancel')),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                style: style,
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, confirmPassword);
                                },
                                child: Text('Submit')),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            height: 64,
                            width: 64,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, signIn);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  backgroundColor: const Color(0xFFF77D8E),
                                ),
                                child: const Icon(Icons.arrow_back),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 1) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }
}
