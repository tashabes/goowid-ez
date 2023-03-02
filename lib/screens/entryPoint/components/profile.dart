import 'package:flutter/material.dart';
import 'package:goowid_auth/screens/onboarding/onboarding.dart';
import 'package:goowid_auth/screens/sign_in_screen.dart/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entry_point.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    getName();
  }

  signOut() async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignIn()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundColor: Color(0xFFF77D8E),
                backgroundImage: AssetImage('assets/icons/profile_img.png'),
                radius: 40,
              ),
            ),
            Divider(
              height: 60,
              color: Color(0xFFF77D8E),
            ),
            Text(
              'Name',
              style: TextStyle(color: Colors.grey, letterSpacing: 2),
            ),
            SizedBox(height: 10),
            Text(
              _name.replaceAll(new RegExp(r'[^\w\s]+'), ''),
              style: TextStyle(
                  color: Color(0xFFF77D8E),
                  letterSpacing: 2,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            SizedBox(height: 30),
            Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  _email!.replaceAll('"', ' '),
                  style: TextStyle(
                      color: Colors.grey[400], fontSize: 18, letterSpacing: 1),
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 40.0),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.pushReplacement(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => OnbodingScreen(),
            //           ));
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Color(0xFFF77D8E),
            //     ),
            //     child: Text(
            //       'Delete Account',
            //       style: TextStyle(fontFamily: 'Poppins'),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: SizedBox(
              height: 64,
              width: 64,
              child: ElevatedButton(
                onPressed: () {
                  signOut();
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: const Color(0xFFF77D8E),
                ),
                child: const Icon(Icons.logout_rounded),
              ),
            ),
          ),
          SizedBox(
            height: 64,
            width: 64,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EntryPoint(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: const Color(0xFFF77D8E),
              ),
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
    );
  }

  var _name;
  var _other;
  String? _email;
  var _phone;

  getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _name = preferences.getString('displayName')!;
      _other = preferences.getString('givenName')!;
      _email = preferences.getString('email') ?? '';
      _phone = preferences.getString('mobilePhone') ?? '';
    });
  }
}
