import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pgroom/src/features/profile_screen/profile_main_screen.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';

class NavigationMenuScreen extends StatefulWidget {
  const NavigationMenuScreen({super.key});

  @override
  State<NavigationMenuScreen> createState() => _NavigationMenuScreenState();
}

class _NavigationMenuScreenState extends State<NavigationMenuScreen> {
  int selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[

    const ProfileDetailsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(NavigationController());

    //on back press open alert dialog box
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Close App"),
                content: const Text("Do you want to Close App?."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text(
                        "No",
                        style: TextStyle(fontSize: 18),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(fontSize: 18),
                      )),
                ],
              );
            });

        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        bottomNavigationBar: GNav(
          rippleColor: AppColors.primary.withOpacity(0.2),
          hoverColor: AppColors.primary.withOpacity(0.2),
          gap: 8,
          activeColor: Colors.white,
          iconSize: 28,
          haptic: false,
          curve: Curves.bounceIn,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: AppColors.primary.withOpacity(.8),
          color: AppColors.primary,
          tabMargin: const EdgeInsets.all(3),
          // navigation bar padding
          tabs: const [
            GButton(
              icon: LineIcons.home,
              text: 'Room',
            ),
            GButton(
              icon: Icons.food_bank_outlined,
              text: 'food',
            ),
            GButton(
              icon: Icons.handshake_outlined,
              text: 'Deal',
            ),
            GButton(
              icon: Icons.perm_identity_sharp,
              text: 'Profile',
            )
          ],
          selectedIndex: selectedIndex,
          onTabChange: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        body: _widgetOptions.elementAt(selectedIndex),
      ),
    );
  }
}
