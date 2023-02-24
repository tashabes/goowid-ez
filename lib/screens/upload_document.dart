import 'package:flutter/material.dart';
import 'package:goowid_auth/utils/routes.dart';

class UploadDocument extends StatelessWidget {
  const UploadDocument({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 64,
            width: 64,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, homePage);
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: const Color(0xFFF77D8E),
              ),
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ),
      ),
    );
  }
}
