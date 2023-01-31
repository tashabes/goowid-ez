import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTest extends StatefulWidget {
  const HomeTest({super.key});

  @override
  State<HomeTest> createState() => _HomeTestState();
}

late String name;

class _HomeTestState extends State<HomeTest> {
  final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();
  late Future<String> _name;

  Future<void> _getName() async {
    final SharedPreferences preferences = await _preferences;
    final int counter = (preferences.getInt('counter') ?? 0) + 1;

    @override
    void initState() {
      super.initState();
      _name = _preferences.then((SharedPreferences prefs) {
        return prefs.getString('displayName') ?? '';
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: FutureBuilder<String?>(
          future: _name,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!);
            }
            return Text('Hello');
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
