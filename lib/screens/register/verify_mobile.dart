import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:goowid_auth/api/api.dart';
import 'package:goowid_auth/screens/register/register_screen.dart';
import 'package:goowid_auth/utils/routes.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../core/client/http_client.dart';
import '../../core/failure/failure.dart';
import '../../utils/app_flushbar.dart';
import 'package:dio/dio.dart';

import '../../utils/app_logger.dart';
import '../../widgets/app_bar.dart';

class VerifyMobile extends StatefulWidget {
  const VerifyMobile({super.key});

  @override
  State<VerifyMobile> createState() => _VerifyMobileState();
}

class _VerifyMobileState extends State<VerifyMobile> {
  int start = 30;
  late Timer _timer;
  final _formKey = GlobalKey<FormState>();
  late ScaffoldMessengerState scaffoldMessenger;
  bool wait = false;
  String buttonName = "Resend new code";
  late String otp, username;
  bool isLoading = false;
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _otpController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _listenSmsCode();
    getUser();
    startTimer();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();

    super.dispose();
    _timer.cancel();
  }

  _listenSmsCode() async {
    await SmsAutoFill().listenForCode();
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: ResusableBar(),
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
                  'Verify your phone',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: RichText(
                  softWrap: true,
                  text: TextSpan(
                    text: 'A verification code has been sent to ',
                    style: Theme.of(context).textTheme.subtitle2,
                    children: <TextSpan>[
                      TextSpan(
                        text: '$_phone',
                        style: TextStyle(color: Color(0xFFF77D8E)),
                      )
                    ],
                  ),
                ),
              ),
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
              //otpPinField(),
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
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 60,
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFF77D8E),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (isLoading) {
                          return;
                        }
                        // if (_usernameController.text.isEmpty) {
                        //   scaffoldMessenger.showSnackBar(const SnackBar(
                        //       content: Text("Please Enter User Name")));
                        //   return;
                        // }
                        if (otp.isEmpty) {
                          scaffoldMessenger.showSnackBar(const SnackBar(
                              content: Text("Please enter your 6 digit code")));
                          return;
                        }

                        validateOtp(otp.toString(), _email);
                      },
                      child: const Text("Verify",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              letterSpacing: 1)),
                    ),
                  ),
                  Positioned(
                    child: (isLoading)
                        ? Center(
                            child: Container(
                                height: 26,
                                width: 26,
                                child: const CircularProgressIndicator(
                                  backgroundColor: Colors.green,
                                )))
                        : Container(),
                    right: 30,
                    bottom: 0,
                    top: 0,
                  )
                ],
              ),
              // GestureDetector(
              //   onTap: (() {
              //     //Navigator.pushReplacementNamed(context, confirmPassword);
              //     validateOtp(otp.toString(), _usernameController.text);
              //   }),
              //   child: Container(
              //     height: 60,
              //     width: MediaQuery.of(context).size.width - 60,
              //     decoration: BoxDecoration(
              //       color: Color(0xFFF77D8E),
              //       borderRadius: BorderRadius.circular(50),
              //     ),
              //     child: Center(
              //       child: Text(
              //         "Send",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 16,
              //             fontFamily: 'Poppins',
              //             letterSpacing: 1),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 15,
              ),
              Text("Didn't receive a code?",
                  style: Theme.of(context).textTheme.subtitle1),
              SizedBox(
                height: 5,
              ),
              textField(),
              SizedBox(
                height: 90,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    _timer = Timer.periodic(onsec, (timer) {
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
      onChanged: (val) {
        otp = val.toString();
      },
    );
  }

  Widget otpPinField() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: PinFieldAutoFill(
          codeLength: 6,
          autoFocus: true,
          decoration: UnderlineDecoration(
            lineHeight: 2,
            lineStrokeCap: StrokeCap.square,
            bgColorBuilder:
                PinListenColorBuilder(Color(0xFF7553F6), Colors.grey.shade200),
            colorBuilder: const FixedColorBuilder(Colors.transparent),
          ),
        ),
      ),
    );
  }

  Widget textField() {
    return InkWell(
      onTap: wait
          ? null
          : () {
              sendOtp(
                _email,
              );

              setState(() {
                wait = true;
                buttonName = "Resend new code";
                start = 30;
                startTimer();
              });
            },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
        child: Text(buttonName,
            style: TextStyle(
                color: wait ? Color(0xFFF77D8E) : Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  sendOtp(username) async {
    print("Calling");

    try {
      Map data = {
        'userName': username,
      };
      print(data.toString());
      HttpClient httpClient = HttpClient();
      Response? res = await httpClient.post(
        SENDPHONEOTP,
        data,
        headers: {
          "Ocp-Apim-Subscription-Key": "5d94951785ea4e3d9f414c5b2d3d6f80",
          "Content-Type": "application/json"
        },
      );

      AppLogger.log("This is the result: ======> ${res?.data}");

      if (res?.data == "Success") {
        GoodWidFlushBar.showSuccess(
            message: "Your 6 digit code has been sent", context: context);
      }
    } on Failure catch (e) {
      GoodWidFlushBar.showError(message: e.errorMessage, context: context);

      AppLogger.log("Error:  =====> ${e.errorMessage}");
    } catch (e) {
      AppLogger.log("Error:  =====> $e");
      AppLogger.log(e.toString());
      GoodWidFlushBar.showError(
          message: "Something went wrong, try again later", context: context);
    }
  }

  validateOtp(otp, username) async {
    print("Calling");

    setState(() {
      isLoading = false;
    });

    try {
      Map data = {'otp': otp, 'userName': username};
      print(data.toString());
      HttpClient httpClient = HttpClient();
      Response? res = await httpClient.post(
        VALIDATEPHONEOTP,
        data,
        headers: {
          "Ocp-Apim-Subscription-Key": "5d94951785ea4e3d9f414c5b2d3d6f80",
          "Content-Type": "application/json"
        },
      );

      //Map<String, dynamic> resposne = res?.data;

      AppLogger.log("This is the result: ======> ${res?.data}");
      //AppLogger.log("This is the result: ======> ${resposne}");

      if (res!.statusCode == 200) {
        GoodWidFlushBar.showSuccess(message: "OTP validated", context: context);
        Navigator.pushReplacementNamed(context, homePage);
        setState(() {
          isLoading = false;
        });
      }
    } on Failure catch (e) {
      GoodWidFlushBar.showError(message: e.errorMessage, context: context);
      setState(() {
        isLoading = false;
      });
      AppLogger.log("Error:  =====> ${e.errorMessage}");
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      AppLogger.log("Error:  =====> $e");
      AppLogger.log(e.toString());
      GoodWidFlushBar.showError(
          message: "Something went wrong, try again later", context: context);
    }
  }

  String? _email;
  String? _phone;

  getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _email = preferences.getString('email') ?? '';
      _phone = preferences.getString('mobilePhone') ?? '';
    });
  }
}
