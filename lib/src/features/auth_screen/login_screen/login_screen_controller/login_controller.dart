import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/user_apis.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

import '../../../../data/repository/auth_apis/auth_apis.dart';
import '../../../../navigation_menu.dart';
import '../../../../res/route_name/routes_name.dart';

class LoginScreenController extends GetxController {
  final emailControllerLogin = TextEditingController().obs;
  final passwordControllerLogin = TextEditingController().obs;
  Connectivity connectivity = Connectivity();

  RxBool wrongPassword = false.obs;
  RxBool passView = true.obs;
  RxBool loading = false.obs;

  onLoginButton(BuildContext context) async {
    await connectivity.checkConnectivity().then((value) {
      // ignore: unrelated_type_equality_checks
      if (value == ConnectivityResult.none) {
        AppHelperFunction.showSnackBar("Please Check Your Internet Connection");
      } else {
        AppHelperFunction.showCenterCircularIndicator(true);
        loading.value = true;
        AuthApisClass.loginEmailAndPassword(emailControllerLogin.value.text,
                passwordControllerLogin.value.text)
            .then((value) async {
          //if user use wrong password and email id than
          // not to allow next page navigation
          wrongPassword.value = value;
          loading.value = false;

          Navigator.pop(Get.context!);
          if (wrongPassword.value) {
            // Login sharedPreference code +++++++++
            // SharedPreferences preference = await SharedPreferences.getInstance();
            // // store a data in sharedPreference
            // preference.setString('userUid', ApisClass.user.uid);
            // //initialize  a variable
            // finalUserUidGlobal = preference.getString('userUid');
            //========================

            if (UserApis.userName != '') {
              Navigator.of(Get.context!).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const NavigationMenuScreen()),
                  (Route<dynamic> route) => false);
            } else {
              Get.offAllNamed(RoutesName.signProfileScreen,
                  arguments: {'email': emailControllerLogin.value.text});
            }

            //Get.toNamed(RoutesName.signProfileScreen,arguments: {'email':emailControllerLogin.value.text});
            //  Get.offAllNamed(RoutesName.navigationScreen);
            //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            //       NavigationMenuScreen()), (Route<dynamic> route) => false);
          }
        }).onError((error, stackTrace) {
          loading.value = false;
          if (kDebugMode) {
            print(error);
            print(stackTrace);
          }
        });
      }
    });
  }
}
