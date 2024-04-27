import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/main.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import 'controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build- Splash screen");
    splashController.startSplashScreen();
    mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Image.asset(
        "assets/images/0.2.png",
        height: 300,
        width: 300,
      )),
    );
  }
}
