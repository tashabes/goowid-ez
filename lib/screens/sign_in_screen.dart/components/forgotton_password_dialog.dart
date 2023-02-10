import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String title, String message) {
  //Set Button
  Widget okbtn = ElevatedButton(
    child: Text(
      "Reset Password",
      style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFF77D8E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
    onPressed: () {
      Navigator.pushReplacementNamed(context, "/signin");
    },
  );
//Set Button
  Widget emailTextField = TextFormField();
  AlertDialog alert = AlertDialog(
    title: Text(
      title,
      style: TextStyle(
          color: Colors.black,
          letterSpacing: 1,
          fontSize: 34,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins'),
    ),
    content: Text(message),
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
