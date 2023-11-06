import 'package:get/get.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/view/home/home_screen.dart';
import 'package:pgroom/src/view/on_boarding_screen/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? finalUserUid = '';

class SplashController extends GetxController{

  static SplashController get find => Get.find();


  Future<void> startSplashScreen() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    finalUserUid  = preferences.getString('userUid');

    if(finalUserUid == null)
      {
        await Future.delayed(Duration(milliseconds: 5000));
        Get.offNamed(RoutesName.onboradingScreen);

      }else{

      await Future.delayed(Duration(milliseconds: 5000));
      Get.offNamed(RoutesName.homeScreen);

    }



  }


}