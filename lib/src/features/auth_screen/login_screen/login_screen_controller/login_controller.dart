import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/user_collection.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

import '../../../../data/repository/auth_apis/auth_apis.dart';
import '../../../../res/route_name/routes_name.dart';

class LoginScreenController extends GetxController {
  final emailControllerLogin = TextEditingController().obs;
  final passwordControllerLogin = TextEditingController().obs;
  Connectivity connectivity = Connectivity();

  RxBool wrongPassword = false.obs;
  RxBool passView = true.obs;
  RxBool loading = false.obs;
  List<String> userList = [];

  onLoginButton(BuildContext context) async {
    await connectivity.checkConnectivity().then((value) async {
      if (value == ConnectivityResult.none) {
        AppHelperFunction.showSnackBar("Please Check Your Internet Connection");
      } else {
        AppHelperFunction.showCenterCircularIndicator(true);
        var verify = await AuthApisClass.loginEmailAndPassword(
            emailControllerLogin.value.text,
            passwordControllerLogin.value.text);

        if (verify) {
          if (await UserApis.checkUserUidExit(UserApis.user.uid)) {
            UserApis.setSharedPreferences(uid:UserApis.user.uid);

            Get.offAllNamed(RoutesName.homeNew);
          } else {
            Get.offAllNamed(RoutesName.signProfileScreen,
                arguments: {'email': emailControllerLogin.value.text});
          }
        } else {
          wrongPassword.value = false;
        }
      }
    });
  }
}
