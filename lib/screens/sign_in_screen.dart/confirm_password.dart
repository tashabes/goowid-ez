import 'package:flutter/material.dart';
import 'package:goowid_auth/utils/routes.dart';

class ConfirmNewPassword extends StatefulWidget {
  const ConfirmNewPassword({super.key});

  @override
  State<ConfirmNewPassword> createState() => _ConfirmNewPasswordState();
}

class _ConfirmNewPasswordState extends State<ConfirmNewPassword> {
  bool _obscureText = true;
  String? _newPassword;
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;
  bool _hasCapitalLetter = false;
  bool _hasSpecialCharacter = false;

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                TextFormField(
                  onChanged: (password) => onPasswordChanged(password),
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                  //controller: _passwordController,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12)),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 15),
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
                MaterialButton(
                  height: 40,
                  minWidth: double.infinity,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, signIn);
                  },
                  color: Color(0xFFF77D8E),
                  child: Text(
                    'Confirm Password',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
