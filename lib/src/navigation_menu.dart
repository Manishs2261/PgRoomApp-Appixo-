import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pgroom/src/features/advertisement_page/advertisement_page.dart';
import 'package:pgroom/src/features/profile_screen/profile_main_screen.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';

import 'features/room_rent_all_screen/home/home_screen.dart';
import 'features/tiffinServicesScreen/tiffinServicesScreen.dart';

class NavigationMenuScreen extends StatefulWidget {
  const NavigationMenuScreen({super.key});

  @override
  State<NavigationMenuScreen> createState() => _NavigationMenuScreenState();
}

class _NavigationMenuScreenState extends State<NavigationMenuScreen> {

  int selectedIndex = 0;

  static  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    TiffineServicesScreen(),
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
                title: const Text("Alert"),
                content: const Text("Do you want to Exit ?."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text("No",style: TextStyle(fontSize: 18),)),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text("Yes",style: TextStyle(fontSize: 18),)),
                ],
              );
            });

        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      // child: Scaffold(
      //   bottomNavigationBar: Obx(
      //     () => NavigationBar(
      //       height: 60,
      //       elevation: 0,
      //
      //       selectedIndex: controller.selectedIndex.value,
      //       indicatorColor: AppColors.primary,
      //       onDestinationSelected: (index) => controller.selectedIndex.value = index,
      //       destinations: [
      //         //const NavigationDestination(icon: Icon(Icons.home), label: "Home"),
      //         const NavigationDestination(icon: Icon(Icons.home), label: "Room"),
      //         const NavigationDestination(icon: Icon(Icons.food_bank_sharp), label: "Food"),
      //         const NavigationDestination(icon: Icon(Icons.person_2_outlined), label: "Profile"),
      //       ],
      //     ),
      //   ),
      //   body: Obx(() => controller.screen[controller.selectedIndex.value]),
      // ),
      child: Scaffold(

        bottomNavigationBar:  GNav(

          rippleColor: Colors.green[300]!,
          hoverColor: Colors.green[100]!,
          gap: 8,
          activeColor: Colors.green,
          iconSize: 24,

          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: Duration(milliseconds: 400),
          tabBackgroundColor: Colors.green[50]!,
          color: Colors.black, // navigation bar padding
          tabs: [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),

            GButton(
              icon: Icons.dinner_dining_outlined,
              text: 'foods',
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
