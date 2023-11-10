import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../repositiry/apis/apis.dart';
import '../../../../repositiry/auth_apis/auth_apis.dart';
import '../../../../res/route_name/routes_name.dart';

class SingScsreenController extends GetxController {
  final emailControllersing = TextEditingController().obs;
  final passwordControllersing = TextEditingController().obs;
  final otpControllersing = TextEditingController().obs;
  final nameControllersing = TextEditingController().obs;
  final citynameontrollersing = TextEditingController().obs;

  Connectivity connectivity = Connectivity();

  RxBool isOtp = false.obs;
  RxBool isSend = false.obs;
  RxBool isVerify = false.obs;
  RxBool alredyExitUser = false.obs;
  RxBool loading = false.obs;

  onOtpSubmitController() {
    if (otpControllersing.value.text.isNotEmpty &&
        otpControllersing.value.text.length == 6) {
      AuthApisClass.otpSubmitVerification(otpControllersing.value.text)
          .then((value) {
        isOtp.value = value;
        isVerify.value = value;

      }).onError((error, stackTrace) {});
    } else {
      Get.snackbar(
          "wrong OTP",
          "Enter six "
              "digit otp");
    }
  }

  onSubmitButton() {
    loading.value = true;

    AuthApisClass.singEmailIdAndPassword(
            emailControllersing.value.text, passwordControllersing.value.text)
        .then((value) async {
      //in this condition
      //if email is alredy exist not sing

      ApisClass.saveUserData(nameControllersing.value.text,
              citynameontrollersing.value.text, emailControllersing.value.text)
          .then((value) {
        Get.snackbar("Save", "Sussefully");
      }).onError((error, stackTrace) {
        Get.snackbar("Error", "user data error");
        print(error);
        print(stackTrace);
      });

      // LOgin sharedPrefrence code +++++++++
      SharedPreferences prefrence = await SharedPreferences.getInstance();
      // store a data in sharedPrefrence
      prefrence.setString('userUid', ApisClass.user.uid);
      //========================
      alredyExitUser.value = value;
      loading.value = false;

      if (alredyExitUser.value) Get.offAllNamed(RoutesName.homeScreen);
    });
  }



}
