import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:goowid_auth/core/client/http_client.dart';
import 'package:goowid_auth/utils/routes.dart';

import '../../api/api.dart';
import '../../core/failure/failure.dart';
import '../../utils/app_flushbar.dart';
import '../../utils/app_logger.dart';
import '../../widgets/app_bar.dart';

class ConfirmNewPassword extends StatefulWidget {
  const ConfirmNewPassword({super.key});

  @override
  State<ConfirmNewPassword> createState() => _ConfirmNewPasswordState();
}

class _ConfirmNewPasswordState extends State<ConfirmNewPassword> {
  bool _obscureText = true;
  String? _newPassword;
  String? _username;
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;
  bool _hasCapitalLetter = false;
  bool _hasSpecialCharacter = false;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  late ScaffoldMessengerState scaffoldMessenger;
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _userNameController = new TextEditingController();

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
    final upperRegex = RegExp(r'[A-Z]');
    final specialRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    setState(() {
      _isPasswordEightCharacters = false;
      if (password.length >= 8) _isPasswordEightCharacters = true;

      _hasPasswordOneNumber = false;
      if (numericRegex.hasMatch(password)) _hasPasswordOneNumber = true;

      _hasCapitalLetter = false;
      if (upperRegex.hasMatch(password)) _hasCapitalLetter = true;

      _hasSpecialCharacter = false;
      if (specialRegex.hasMatch(password)) _hasSpecialCharacter = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: ResusableBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Enter your new password',
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'Enter a secure password including the following criteria below.',
                    style: Theme.of(context).textTheme.subtitle1),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        //onChanged: (password) => onPasswordChanged(password),
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                        controller: _userNameController,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12)),
                          hintText: "Username",
                          hintStyle:
                              TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                        onSaved: (val) {
                          _username = val!;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        onChanged: (password) => onPasswordChanged(password),
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                        controller: _passwordController,
                        enableSuggestions: false,
                        autocorrect: false,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12)),
                            hintText: "Password",
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                            suffixIcon: IconButton(
                                onPressed: () => setState(() {
                                      _obscureText = !_obscureText;
                                    }),
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Color(0xFFF77D8E),
                                ))),
                        onSaved: (val) {
                          _newPassword = val!;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _isPasswordEightCharacters
                            ? Colors.green
                            : Colors.transparent,
                        border: _isPasswordEightCharacters
                            ? Border.all(color: Colors.transparent)
                            : Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Contains at least 8 characters',
                        style: Theme.of(context).textTheme.subtitle2),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _hasPasswordOneNumber
                            ? Colors.green
                            : Colors.transparent,
                        border: _hasPasswordOneNumber
                            ? Border.all(color: Colors.transparent)
                            : Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Contains at least 1 number',
                        style: Theme.of(context).textTheme.subtitle2),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _hasCapitalLetter
                            ? Colors.green
                            : Colors.transparent,
                        border: _hasCapitalLetter
                            ? Border.all(color: Colors.transparent)
                            : Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Contains a capital letter',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _hasSpecialCharacter
                            ? Colors.green
                            : Colors.transparent,
                        border: _hasSpecialCharacter
                            ? Border.all(color: Colors.transparent)
                            : Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Contains a special character',
                        style: Theme.of(context).textTheme.subtitle2),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
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
                          if (_userNameController.text.isEmpty) {
                            scaffoldMessenger.showSnackBar(const SnackBar(
                                content: Text("Please Enter User Name")));
                            return;
                          }
                          if (_passwordController.text.isEmpty) {
                            scaffoldMessenger.showSnackBar(const SnackBar(
                                content: Text("Please Enter new Password")));
                            return;
                          }

                          resetPassword(_userNameController.text,
                              _passwordController.text);
                        },
                        child: const Text("Confirm Password",
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  resetPassword(username, newPassword) async {
    print("Calling");

    setState(() {
      isLoading = true;
    });

    try {
      Map data = {'userName': username, 'newPassword': newPassword};
      print(data.toString());
      HttpClient httpClient = HttpClient();
      Response? res = await httpClient.post(
        RESETPASSWORD,
        data,
        headers: {
          "Ocp-Apim-Subscription-Key": "5d94951785ea4e3d9f414c5b2d3d6f80",
          "Content-Type": "application/json"
        },
      );
      setState(() {
        isLoading = false;
      });

      AppLogger.log("This is the result: ======> ${res!.statusCode}");

      if (res.statusCode == 200) {
        Navigator.pushReplacementNamed(context, signIn);
        GoodWidFlushBar.showSuccess(
            message: "Your password has successfully been reset",
            context: context);
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
