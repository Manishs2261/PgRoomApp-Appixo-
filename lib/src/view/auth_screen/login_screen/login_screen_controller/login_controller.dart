import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../repositiry/auth_apis/auth_apis.dart';
import '../../../../res/route_name/routes_name.dart';

class LoginScreenController extends GetxController{

  final emailControlerLogin = TextEditingController().obs;
  final passwordControlerLogin = TextEditingController().obs;
  Connectivity connectivity = Connectivity();

  RxBool worngpassword = false.obs;
  RxBool passView = true.obs;
  RxBool loading = false.obs;

onLoginButton(){

  loading.value = true;

  AuthApisClass.loginEmailAndPassword(
      emailControlerLogin.value.text,
      passwordControlerLogin.value.text)
      .then((value) {
    //if user use wrong password and email id thna
    // not to allow next page navigation
    worngpassword.value = value;

    loading.value = false;
    if (worngpassword.value)
      Get.offAllNamed(RoutesName.homeScreen);
  });
}


}