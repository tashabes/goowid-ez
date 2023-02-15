import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:goowid_auth/screens/sign_in_screen.dart/components/forgotton_password_dialog.dart';
import 'package:goowid_auth/utils/routes.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api.dart';
import '../../utils/app_flushbar.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;
  late String? title;
  bool isLoading = false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 180,
                        child: const Text(
                          "Goowid Authenticator",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black54,
                              letterSpacing: 0.6,
                              fontFamily: 'Poppins',
                              fontSize: 11),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Log in",
                        //textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 45),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.black54,
                                ),
                                controller: _emailController,
                                enableSuggestions: false,
                                autocorrect: false,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black12)),
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      color: Colors.black54, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  email = val!;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.black54,
                                ),
                                controller: _passwordController,
                                enableSuggestions: false,
                                autocorrect: false,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12)),
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        color: Colors.black54, fontSize: 15),
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
                                  password = val!;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (isLoading) {
                                        return;
                                      }
                                      if (_emailController.text.isEmpty ||
                                          _passwordController.text.isEmpty) {
                                        scaffoldMessenger.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "Please fill all fields")));
                                        return;
                                      }
                                      login(_emailController.text,
                                          _passwordController.text);
                                      setState(() {
                                        isLoading = true;
                                      });
                                      //Navigator.pushReplacementNamed(
                                      //context, "/entrypoint");
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 0),
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF77D8E),
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Text(
                                        "Log in",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            letterSpacing: 1),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    child: (isLoading)
                                        ? Center(
                                            child: Container(
                                                height: 26,
                                                width: 26,
                                                child:
                                                    const CircularProgressIndicator(
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
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "OR",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, signUp);
                        },
                        child: const Text(
                          "Don't have an account?",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                              decoration: TextDecoration.underline,
                              letterSpacing: 0.5),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, otpVerifyPhone);
                          // String title = "Forgot Password";
                          // String message =
                          //     "Enter your phone number.  We'll send you a verification code to reset your password.";
                          // showAlertDialog(context, title, message);
                        },
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                              decoration: TextDecoration.underline,
                              letterSpacing: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  login(email, password) async {
    Map data = {'userName': email, 'password': password};
    print(data.toString());
    final response = await http.post(
      Uri.parse(LOGIN),
      headers: {
        "Ocp-Apim-Subscription-Key": "5d94951785ea4e3d9f414c5b2d3d6f80",
        "Content-Type": "application/json"
      },
      body: jsonEncode(data),
    );
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      if (resposne['displayName'] != null) {
        savePref(
            1,
            resposne['displayName'],
            resposne['givenName'],
            resposne['surname'],
            resposne['userPrincipalName'],
            resposne['mobilePhone'],
            resposne['userPrincipalName'],
            resposne['id']);

        Navigator.pushReplacementNamed(context, homePage);
        GoodWidFlushBar.showSuccess(
            message: "Welcome ${resposne['displayName']}", context: context);
      }
    } else {
      GoodWidFlushBar.showError(
          message: "Your email or password are incorrect", context: context);
    }
  }

  savePref(
      int value,
      String displayName,
      String givenName,
      String surname,
      String userPrincipalName,
      String mobileNumber,
      String email,
      String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setInt("value", value);
    preferences.setString("displayName", json.encode(displayName));
    preferences.setString("givenName", json.encode(givenName));
    preferences.setString("surname", json.encode(surname));
    preferences.setString("userPrincipalName", json.encode(userPrincipalName));
    preferences.setString("mobileNumber", json.encode(mobileNumber));
    preferences.setString("email", json.encode(email));
    preferences.setString("id", id.toString());
  }
}

class SharedPref {
  static write(String key, value) async {
    final preferences = await SharedPreferences.getInstance();
    return await preferences.setString(key, json.encode(value));
  }

  static remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
