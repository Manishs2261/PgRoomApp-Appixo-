import 'package:get/get.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/view/home/home_screen.dart';
import 'package:pgroom/src/view/on_boarding_screen/on_boarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? finalUserUidGloble = '';

class SplashController extends GetxController{

  static SplashController get find => Get.find();


  Future<void> startSplashScreen() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    /// 'userUid' is refrence to pass a data ,
    /// like , google login data and email login
    finalUserUidGloble  = preferences.getString('userUid');

    if(finalUserUidGloble == null)
      {
        print(finalUserUidGloble);
        await Future.delayed(Duration(milliseconds: 5000));
        Get.offNamed(RoutesName.onboradingScreen);

      }else{
      print(finalUserUidGloble);
      await Future.delayed(Duration(milliseconds: 5000));
      Get.offNamed(RoutesName.homeScreen);

    }



  }


}