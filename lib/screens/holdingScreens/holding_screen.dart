import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goowid_auth/screens/entryPoint/entry_point.dart';

const double defaultPadding = 16;

class HoldingScreen extends StatelessWidget {
  const HoldingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FA),
      floatingActionButton: SizedBox(
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
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/illustrations/no_task_1.svg"),
              const SizedBox(height: defaultPadding * 2),
              const Text(
                "No updates",
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "You're all up to date",
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
