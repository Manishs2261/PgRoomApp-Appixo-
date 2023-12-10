import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pgroom/src/res/route_name/routes_name.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../navigation_menu.dart';

String? finalUserUidGlobal = '';

class SplashController extends GetxController {
  static SplashController get find => Get.find();

  Future<void> startSplashScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    /// 'userUid' is refrence to pass a data ,
    /// like , google login data and email login
    finalUserUidGlobal = preferences.getString('userUid');

    if (finalUserUidGlobal == null) {
      print(finalUserUidGlobal);
      await Future.delayed(const Duration(milliseconds: 5000));
      Get.offNamed(RoutesName.onboradingScreen);
    } else {
      print(finalUserUidGlobal);
      await Future.delayed(Duration(milliseconds: 5000));
    // Get.offNamed(RoutesName.homeScreen);
      Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          NavigationMenuScreen()), (Route<dynamic> route) => false);

    }
  }
}
