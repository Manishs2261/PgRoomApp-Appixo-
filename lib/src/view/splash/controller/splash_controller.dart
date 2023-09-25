import 'package:get/get.dart';
import 'package:pgroom/src/view/home/home_screen.dart';
import 'package:pgroom/src/view/on_boarding_screen/on_boarding_screen.dart';

class SplashController extends GetxController{

  static SplashController get find => Get.find();

  Future<void> startSplashScreen() async {

    await Future.delayed(Duration(milliseconds: 5000));
    Get.off(()=> OnBoardingOneScreen());


  }


}