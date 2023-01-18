/*import 'package:flutter/material.dart';
import 'package:goowid_auth/utils/rive_utils.dart';
import 'package:rive/rive.dart';

import '../../models/rive_assets.dart';
import '../../src/presentation/widgets/components/animated_bar.dart';

class BottomNavBar extends StatefulWidget {
  static const String screenRoute = 'entry_point';
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  RiveAsset selectedBottomNav = bottomNavs.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        12.0,
      ),
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(
          0.8,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        ...List.generate(
          bottomNavs.length,
          (index) => GestureDetector(
            onTap: () {
              bottomNavs[index].input!.change(true);
              if (bottomNavs[index] != selectedBottomNav) {
                setState(() {
                  selectedBottomNav = bottomNavs[index];
                });
              }
              Future.delayed(const Duration(seconds: 1), () {
                bottomNavs[index].input!.change(false);
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBar(isActive: bottomNavs[index] == selectedBottomNav),
                SizedBox(
                  height: 36,
                  width: 36,
                  child: Opacity(
                    opacity: bottomNavs[index] == selectedBottomNav ? 1 : 0.5,
                    child: RiveAnimation.asset(
                      bottomNavs.first.src,
                      artboard: bottomNavs[index].artboard,
                      onInit: (artboard) {
                        StateMachineController controller =
                            RiveUtils.getRiveController(artboard,
                                stateMachineName:
                                    bottomNavs[index].stateMachineName);

                        bottomNavs[index].input =
                            controller.findSMI("active") as SMIBool;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}*/
