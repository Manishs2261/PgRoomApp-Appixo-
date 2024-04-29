import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/navigation_menu.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/repository/apis/apis.dart';
import '../../../../data/repository/auth_apis/auth_apis.dart';
import '../../../../res/route_name/routes_name.dart';
import '../../../splash/controller/splash_controller.dart';

class LoginScreenController extends GetxController {
  final emailControllerLogin = TextEditingController().obs;
  final passwordControllerLogin = TextEditingController().obs;
  Connectivity connectivity = Connectivity();

  RxBool wrongPassword = false.obs;
  RxBool passView = true.obs;
  RxBool loading = false.obs;

  onLoginButton(BuildContext context) async {
    await connectivity.checkConnectivity().then((value) {
      if (value == ConnectivityResult.none) {
        AppHelperFunction.showSnackBar("Please Check Your Internet Connection");
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            });

        loading.value = true;
        AuthApisClass.loginEmailAndPassword(emailControllerLogin.value.text, passwordControllerLogin.value.text)
            .then((value) async {
          //if user use wrong password and email id than
          // not to allow next page navigation
          wrongPassword.value = value;

          loading.value = false;
          Navigator.pop(Get.context!);
          if (wrongPassword.value) {
            // Login sharedPreference code +++++++++
            SharedPreferences preference = await SharedPreferences.getInstance();
            // store a data in sharedPreference
            preference.setString('userUid', ApisClass.user.uid);
            //initialize  a variable
            finalUserUidGlobal = preference.getString('userUid');
            //========================
            Get.offAllNamed(RoutesName.navigationScreen);
            //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            //       NavigationMenuScreen()), (Route<dynamic> route) => false);
          }
        }).onError((error, stackTrace) {
          loading.value = false;
          print(error);
          print(stackTrace);
        });
      }
    });
  }
}
