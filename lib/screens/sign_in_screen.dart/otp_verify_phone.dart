import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goowid_auth/constants.dart';
import 'package:goowid_auth/utils/routes.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class OTPVerifyPhone extends StatefulWidget {
  const OTPVerifyPhone({super.key});

  @override
  State<OTPVerifyPhone> createState() => _OTPVerifyPhoneState();
}

class _OTPVerifyPhoneState extends State<OTPVerifyPhone> {
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  'Verification Code',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              textField(),
              SizedBox(
                height: 30,
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
              SizedBox(
                height: 30,
              ),
              otpField(),
              SizedBox(
                height: 30,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Send code again in ",
                        style: Theme.of(context).textTheme.subtitle1),
                    TextSpan(
                        text: "00:$start ",
                        style: Theme.of(context).textTheme.subtitle2),
                    TextSpan(
                        text: "sec",
                        style: Theme.of(context).textTheme.subtitle1),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: (() {
                  Navigator.pushReplacementNamed(context, confirmPassword);
                }),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                    color: Color(0xFFF77D8E),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      "Send",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          letterSpacing: 1),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 64,
                    width: 64,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, signIn);
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
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 34,
      fieldWidth: 58,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Colors.white,
        borderColor: Color(0xFFF77D8E),
      ),
      style: TextStyle(fontSize: 17, color: Color(0xFFF77D8E)),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
      },
    );
  }

  Widget textField() {
    return Container(
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(15.0)),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter your phone Number",
            hintStyle: Theme.of(context).textTheme.subtitle1,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
              child: Text(
                " (+44) ",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            suffixIcon: InkWell(
              onTap: wait
                  ? null
                  : () {
                      startTimer();
                      setState(() {
                        wait = true;
                        buttonName = "Resend";
                      });
                    },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                child: Text(buttonName,
                    style: TextStyle(
                        color: wait ? Color(0xFFF77D8E) : Colors.grey,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ));
  }
}
