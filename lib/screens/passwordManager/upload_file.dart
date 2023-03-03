import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:goowid_auth/utils/routes.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api.dart';
import '../../utils/app_flushbar.dart';
import '../../widgets/app_bar.dart';

class UploadFile extends StatefulWidget {
  @override
  _UploadFileState createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;
  late String? title;
  bool isLoading = false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  bool _obscureText = true;
  FilePickerResult? result;
  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: ResusableBar(),
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
                        "Upload a file",
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
                              const Text(
                                "Selected file",
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: result?.files.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      result?.files[index].name ?? '',
                                    );
                                  }),
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        width: 5.0,
                                        color: Color(0xFFF77D8E),
                                      )),
                                  onPressed: () async {
                                    result =
                                        await FilePicker.platform.pickFiles();
                                    if (result == null) {
                                      print('No file selected');
                                    } else {
                                      setState(() {});
                                      result?.files.forEach((element) {
                                        print(element.name);
                                      });
                                    }
                                  },
                                  child: const Text(
                                    "Choose your file",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
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
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black12)),
                                  hintText: "File Name",
                                  hintStyle: TextStyle(
                                      color: Colors.black54, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  password = val!;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.black54,
                                ),
                                controller: _passwordController,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black12)),
                                  hintText: "Category (optional)",
                                  hintStyle: TextStyle(
                                      color: Colors.black54, fontSize: 15),
                                ),
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
                                      if (_emailController.text.isEmpty) {
                                        scaffoldMessenger.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "Please enter your user name")));
                                        return;
                                      }
                                      if (_passwordController.text.isEmpty) {
                                        scaffoldMessenger.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "Please enter your password")));
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
                                        "Upload",
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, docMgmt);
                        },
                        child: const Icon(
                          Icons.close_rounded,
                          size: 40,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
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
