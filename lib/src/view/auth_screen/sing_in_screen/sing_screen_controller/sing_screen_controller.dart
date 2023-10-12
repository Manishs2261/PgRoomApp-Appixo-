import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../repositiry/auth_apis/auth_apis.dart';

class SingScsreenController extends GetxController{

  final  emailControllersing = TextEditingController().obs;
  final  passwordControllersing = TextEditingController().obs;
  final  otpControllersing = TextEditingController().obs;
  final  nameControllersing = TextEditingController().obs;
  final  citynameontrollersing = TextEditingController().obs;

  RxBool isOtp = false.obs;
  RxBool isSend = false.obs;
  RxBool isVerify = false.obs;
  RxBool alredyExitUser = false.obs;
  RxBool loading = false.obs;



  onOtpSubmitController(){
    if (otpControllersing.value
        .text.isNotEmpty &&
        otpControllersing
            .value.text
            .length ==
            6) {
      AuthApisClass.otpSubmitVerification(
          otpControllersing.value
              .text)
          .then((value) {

        isOtp.value = value;
        isVerify.value = value;

        print(value);
      }).onError((error, stackTrace) {});
    } else {
      Get.snackbar(
          "wrong OTP",
          "Enter six "
              "digit otp");
    }
  }




}