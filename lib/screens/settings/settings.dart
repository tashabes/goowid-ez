import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goowid_auth/constants.dart';
import 'package:goowid_auth/utils/routes.dart';
import 'package:goowid_auth/widgets/app_bar.dart';
import 'package:lottie/lottie.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController animationController2;
  late AnimationController animationController3;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animationController2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animationController3 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ResusableBar(title: 'Settings'),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                const Icon(
                  Icons.person,
                  color: brightCoral,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Account",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "Change password"),
            buildAccountOptionRow(context, "Content settings"),
            //buildAccountOptionRow(context, "Social"),
            buildAccountOptionRow(context, "Language"),
            buildAccountOptionRow(context, "Privacy and security"),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                const Icon(
                  Icons.volume_up_outlined,
                  color: brightCoral,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Notifications",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            buildNotificationOptionRow("New message", animationController),
            buildNotificationOptionRow("Profile viewed", animationController2),
            buildNotificationOptionRow("Opportunity", animationController3),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, signIn),
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 4,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFF77D8E),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Text(
                  "Sign out",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      letterSpacing: 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(
      String title, AnimationController animationController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),

        GestureDetector(
          onTap: () {
            if (animationController.value == 1) {
              animationController.reverse();
            } else {
              animationController.forward();
            }
          },
          child: SizedBox(
            height: 40,
            width: 70,
            child: Lottie.asset('assets/LottieAssets/toggle_switch.json',
                repeat: false, controller: animationController),
          ),
        ),
        // Transform.scale(
        //   scale: 0.7,
        //   child: CupertinoSwitch(
        //     activeColor: brightCoral,
        //     value: isActive,
        //     onChanged: (bool val) {},
        //   ),
        // ),
      ],
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("Option 1"),
                    Text("Option 2"),
                    Text("Option 3"),
                  ],
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
