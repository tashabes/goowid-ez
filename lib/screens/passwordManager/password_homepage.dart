import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class PasswordHomePage extends StatefulWidget {
  const PasswordHomePage({super.key});

  @override
  State<PasswordHomePage> createState() => _PasswordHomePageState();
}

class _PasswordHomePageState extends State<PasswordHomePage> {
  //int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    //AccountsTab(),
    //SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBody: true,
      //backgroundColor: BrandColor.background,
      body: Center(
          // child: _widgetOptions.elementAt(_selectedIndex),
          ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFFF77D8E),
                Color(0xFFF77D8E),
              ]),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.blue,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.white,
              tabs: const [
                GButton(
                  icon: Icons.manage_accounts,
                  text: 'Accounts',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
              ],
              //selectedIndex: _selectedIndex,
              //onTabChange: (index) {
              // setState(() {
              //_selectedIndex = index;
              // });
              // },
            ),
          ),
        ),
      ),
    );
  }
}
