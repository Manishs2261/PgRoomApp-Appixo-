import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pgroom/src/features/profile_screen/profile_main_screen.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';

import 'features/old_goods/old_goods_screen.dart';
import 'features/room_rent_all_screen/home/home_screen.dart';
import 'features/tiffinServicesScreen/tiffinServicesScreen.dart';

class NavigationMenuScreen extends StatefulWidget {
  const NavigationMenuScreen({super.key});

  @override
  State<NavigationMenuScreen> createState() => _NavigationMenuScreenState();
}

class _NavigationMenuScreenState extends State<NavigationMenuScreen> {

  int selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    TiffineServicesScreen(),
    OldGoodsScreen(),
    ProfileDetailsScreen()
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
                      child: const Text("No", style: TextStyle(fontSize: 18),)),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text("Yes", style: TextStyle(fontSize: 18),)),
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
          activeColor: Colors.black,
          iconSize: 24,

          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: AppColors.primary.withOpacity(0.5),
          color: Colors.black,
          // navigation bar padding
          tabs: const [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),

            GButton(
              icon: Icons.emoji_food_beverage_rounded,
              text: 'foods',
            ),
            GButton(
              icon: Icons.shop,
              text: 'Goods',
            ),


            GButton(
              icon: LineIcons.user,
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

// class NavigationController extends GetxController {
//   final RxInt selectedIndex = 0.obs;
//   final screen = [ HomeScreen(), TiffineServicesScreen(), ProfileDetailsScreen()];
// }
