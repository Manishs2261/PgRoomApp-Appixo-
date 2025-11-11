import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

import '../../../common_main.dart';
import '../../utils/logger/logger.dart';
import '../Home/data/repository/repository.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashController = Get.put(SplashController());

  final updater = ShorebirdUpdater();

  @override
  void initState() {
    // TODO: implement initState

    HomeRepository.getUser();

    // Print current patch number
    updater.readCurrentPatch().then((currentPatch) {
      print('The current patch number is: ${currentPatch?.number}');
    });

    // Automatically check for and apply updates
    _checkForUpdates();
    super.initState();
  }

  Future<void> _checkForUpdates() async {
    final status = await updater.checkForUpdate();

    if (status == UpdateStatus.outdated) {
      try {
        await updater.update();
        print('Update applied successfully');
      } on UpdateException catch (error) {
        print('Update failed: $error');
      }
    } else {
      print('No update available');
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build- Splash screen");
    splashController.startSplashScreen();
    mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/images/0.2.png", height: 300, width: 300),
      ),
    );
  }
}
