import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Home_fitter_new/new_search_home/new_home_screen.dart';

String? finalUserUidGlobal = '';

class SplashController extends GetxController {
  static SplashController get find => Get.find();

  Future<void> startSplashScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    /// 'userUid' is reference to pass a data ,
    /// like , google login data and email login
    finalUserUidGlobal = preferences.getString('userUid');

    if (finalUserUidGlobal == null) {
      AppLoggerHelper.info(finalUserUidGlobal.toString());
      await Future.delayed(const Duration(seconds: 2));

      Get.offNamed(RoutesName.onboradingScreen);
    } else {
      AppLoggerHelper.info(finalUserUidGlobal.toString());
      await Future.delayed(const Duration(seconds: 2));

      // Get.offNamed(RoutesName.homeScreen);
      Navigator.of(Get.context!).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeNew()),
          (Route<dynamic> route) => false);
    }
  }
}
