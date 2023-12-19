import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/profile_screen/profile_main_screen.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

import 'features/room_rent_all_screen/home/home_screen.dart';
import 'features/tiffinServicesScreen/tiffinServicesScreen.dart';

class NavigationMenuScreen extends StatelessWidget {
  NavigationMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    //on back press open alert dilog box
    return WillPopScope(
      onWillPop: () async{
        final value = await showDialog<bool>(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Alert"),
                content: Text("Do you want to Exit ?."),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.of(context).pop(false);
                  }, child: Text("No")),
                  TextButton(onPressed: (){
                    Navigator.of(context).pop(true);
                  }, child: Text("Yes")),
                ],
              );
            });

        if(value != null){
          return Future.value(value);
        }else{
         return Future.value(false);
        }

      },
      child: Scaffold(
        bottomNavigationBar: Obx(
          () => NavigationBar(
            height: 60,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            indicatorColor: AppColors.primary,
            onDestinationSelected: (index) => controller.selectedIndex.value = index,
            destinations: [
              NavigationDestination(icon: Icon(Icons.home), label: "Home"),
              NavigationDestination(icon: Icon(Icons.food_bank_sharp), label: "Food"),
              NavigationDestination(icon: Icon(Icons.person_2_outlined), label: "Profile"),
            ],
          ),
        ),
        body: Obx(() => controller.screen[controller.selectedIndex.value]),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final screen = [HomeScreen(), TiffineServicesScreen(), ProfileDetailsScreen()];
}
