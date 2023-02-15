import 'package:flutter/material.dart';
import 'package:goowid_auth/screens/sign_in_screen.dart/otp_verification.dart';

showAlertDialog(BuildContext context, String title, String message) {
  TextEditingController _phoneNumberController = new TextEditingController();
  String? _phoneNumberVerify;
  int start = 30;
  //Set Button
  Widget okbtn = ElevatedButton(
    child: const Text(
      "Next",
      style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFF77D8E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              OtpVerificationScreen(phoneNumber: _phoneNumberController.text),
        ),
      );
    },
  );
//Set Button
  Widget emailTextField = TextFormField(
    style: const TextStyle(
      color: Colors.black54,
    ),
    controller: _phoneNumberController,
    enableSuggestions: false,
    autocorrect: false,
    keyboardType: TextInputType.emailAddress,
    decoration: const InputDecoration(
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
      hintText: "Phone Number",
      hintStyle: TextStyle(color: Colors.black54, fontSize: 15),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15.0),
        child: Text(
          " (+44) ",
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
      ),
    ),
    onSaved: (val) {
      _phoneNumberVerify = val!;
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text(
      title,
      style: Theme.of(context).textTheme.headline2,
    ),
    content: Text(
      message,
      style: Theme.of(context).textTheme.subtitle1,
    ),
    actions: [
      emailTextField,
      okbtn,
    ],
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
