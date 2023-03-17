import 'package:flutter/material.dart';
import 'package:goowid_auth/api/api.dart';
import 'package:goowid_auth/constants.dart';
import 'package:goowid_auth/utils/routes.dart';
import 'package:goowid_auth/widgets/app_bar.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../core/client/http_client.dart';
import '../../core/failure/failure.dart';
import '../../utils/app_flushbar.dart';
import 'package:dio/dio.dart';
import '../../utils/app_logger.dart';

class OTPVerifyPhone extends StatefulWidget {
  const OTPVerifyPhone({super.key});

  @override
  State<OTPVerifyPhone> createState() => _OTPVerifyPhoneState();
}

class _OTPVerifyPhoneState extends State<OTPVerifyPhone> {
  int start = 30;
  final _formKey = GlobalKey<FormState>();
  late ScaffoldMessengerState scaffoldMessenger;
  bool wait = false;
  String buttonName = "Send";
  late String otp, username;
  bool isLoading = false;
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _otpController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _listenSmsCode();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();

    super.dispose();
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
      appBar: const ResusableBar(
        title: '',
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  'Verification Code',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              textField(),
              const SizedBox(
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
                        margin: const EdgeInsets.symmetric(horizontal: 12.0),
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
                        margin: const EdgeInsets.symmetric(horizontal: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              otpPinField(),
              const SizedBox(
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
                      color: const Color(0xFFF77D8E),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (isLoading) {
                          return;
                        }
                        if (_usernameController.text.isEmpty) {
                          scaffoldMessenger.showSnackBar(const SnackBar(
                              content: Text("Please Enter User Name")));
                          return;
                        }
                        if (otp.isEmpty) {
                          scaffoldMessenger.showSnackBar(const SnackBar(
                              content: Text("Please enter your 6 digit code")));
                          return;
                        }

                        validateOtp(otp.toString(), _usernameController.text);
                      },
                      child: Text(
                        "Verify",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.button,
                      ),
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
              const SizedBox(
                height: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 34,
      fieldWidth: 58,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Colors.white,
        borderColor: const Color(0xFFF77D8E),
      ),
      style: const TextStyle(fontSize: 17, color: Color(0xFFF77D8E)),
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
          controller: _otpController,
          onCodeChanged: (val) {
            otp = val.toString();
          },
          codeLength: 6,
          autoFocus: true,
          decoration: UnderlineDecoration(
            lineHeight: 2,
            lineStrokeCap: StrokeCap.square,
            bgColorBuilder: PinListenColorBuilder(blue, Colors.grey.shade200),
            colorBuilder: const FixedColorBuilder(Colors.transparent),
          ),
        ),
      ),
    );
  }

  Widget textField() {
    return Form(
      key: _formKey,
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(15.0)),
        child: TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter your user name",
            hintStyle: Theme.of(context).textTheme.subtitle1,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            suffixIcon: InkWell(
              onTap: wait
                  ? null
                  : () {
                      AppLogger.log(_usernameController.text);
                      sendOtp(
                        _usernameController.text,
                      );
                    },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                child: Text(buttonName,
                    style: TextStyle(
                        color: wait ? brightCoral : Colors.grey,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          onSaved: (val) {
            username = val!;
            AppLogger.log(_usernameController.text);
          },
        ),
      ),
    );
  }

  sendOtp(username) async {
    AppLogger.log("Calling");

    try {
      Map data = {
        'userName': username,
      };
      AppLogger.log(data.toString());
      HttpClient httpClient = HttpClient();
      Response? res = await httpClient.post(
        SENDOTP,
        data,
        headers: {
          "Ocp-Apim-Subscription-Key": "5d94951785ea4e3d9f414c5b2d3d6f80",
          "Content-Type": "application/json"
        },
      );

      AppLogger.log("This is the result: ======> ${res?.data}");

      if ((res?.data).contains("Success")) {
        GoodWidFlushBar.showSuccess(
            message: "Your 6 digit code has been sent", context: context);
      } else if (res?.statusCode == 400) {
        GoodWidFlushBar.showError(
            message: "Your 6 digit code is incorrect", context: context);
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
    AppLogger.log("Calling");

    setState(() {
      isLoading = false;
    });

    try {
      Map data = {'otp': otp, 'userName': username};
      AppLogger.log(data.toString());
      HttpClient httpClient = HttpClient();
      Response? res = await httpClient.post(
        VALIDATEOTP,
        data,
        headers: {
          "Ocp-Apim-Subscription-Key": "5d94951785ea4e3d9f414c5b2d3d6f80",
          "Content-Type": "application/json"
        },
      );

      AppLogger.log("This is the result: ======> ${res?.data}");

      if (res!.statusCode == 200) {
        GoodWidFlushBar.showSuccess(message: "OTP validated", context: context);
        Navigator.pushReplacementNamed(context, confirmPassword);
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
}
