import 'package:flutter/material.dart';
import 'package:goowid_auth/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../model/menu.dart';
import '../../../../utils/rive_utils.dart';
import 'info_card.dart';
import 'side_menu.dart';
import 'package:lottie/lottie.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    super.key,
    this.userName,
  });

  final String? userName;

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Menu selectedSideMenu = sidebarMenus.first;

  void initState() {
    super.initState();
    getName();
  }

  String? name;

  getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('displayName') ?? '';
      name = name?.replaceAll(RegExp(r'[^\w\s]+'), '');
    });
  }

  @override
  Widget build(BuildContext context) {
    /*Future<String> getName(preferences) async {
      final userName = await SharedPreferences.getInstance();
      return preferences.getString.displayName;
    }*/

    return SafeArea(
      child: Container(
        width: 288,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF17203A),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoCard(
                name: "",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                    child: Text(
                      "Hello $name 👋",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white70),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, signIn);
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 32, bottom: 16, right: 24),
                      child: Lottie.asset(
                        'assets/icons/lf20_nlqdizzy.json',
                        animate: true,
                        width: 50,
                      ),
                    ),
                  ),
                ],
              ),
              ...sidebarMenus
                  .map((menu) => SideMenu(
                        menu: menu,
                        selectedMenu: selectedSideMenu,
                        press: () {
                          RiveUtils.chnageSMIBoolState(menu.rive.status!);
                          setState(() {
                            selectedSideMenu = menu;
                          });
                          Future.delayed(const Duration(milliseconds: 300))
                              .then((value) => navigate(menu));
                        },
                        riveOnInit: (artboard) {
                          menu.rive.status = RiveUtils.getRiveInput(artboard,
                              stateMachineName: menu.rive.stateMachineName);
                        },
                      ))
                  .toList(),
              // Padding(
              //   padding: const EdgeInsets.only(left: 24, top: 40, bottom: 16),
              //   child: Text(
              //     "Other".toUpperCase(),
              //     style: Theme.of(context)
              //         .textTheme
              //         .titleMedium!
              //         .copyWith(color: Colors.white70),
              //   ),
              // ),
              ...sidebarMenus2
                  .map((menu) => SideMenu(
                        menu: menu,
                        selectedMenu: selectedSideMenu,
                        press: () {
                          RiveUtils.chnageSMIBoolState(menu.rive.status!);
                          setState(() {
                            selectedSideMenu = menu;
                          });
                          Future.delayed(const Duration(milliseconds: 300))
                              .then((value) => navigate(menu));
                        },
                        riveOnInit: (artboard) {
                          menu.rive.status = RiveUtils.getRiveInput(artboard,
                              stateMachineName: menu.rive.stateMachineName);
                        },
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  void navigate(menu) {
    if (menu.title == "Profile") {
      Navigator.pushNamed(context, profile);
    } else if (menu.title == "Chat") {
      Navigator.pushNamed(context, chatScreen);
    } else if (menu.title == "Logout") {
      Navigator.pushNamed(context, signIn);
    } else if (menu.title == "Settings") {
      Navigator.pushNamed(context, settings);
    }
  }
}
