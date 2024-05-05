import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import '../../../../data/repository/auth_apis/auth_apis.dart';
import '../../../../res/route_name/routes_name.dart';

class SingScreenController extends GetxController {
  final emailController = TextEditingController().obs;

  final otpController = TextEditingController().obs;

  Connectivity connectivity = Connectivity();

  RxBool isOtp = false.obs;
  RxBool isSend = false.obs;
  RxBool isVerify = false.obs;
  RxBool alreadyExistUser = false.obs;
  RxBool loading = false.obs;
  RxBool otpSendLoading = false.obs;
  RxBool otpReSendLoading = false.obs;
  RxBool emailReading = false.obs;

  RxInt counter = 90.obs;
  late Timer timer;

  onOtpSubmitVerifyButton() async {
    //check the internet connection
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        if (otpController.value.text == "") {
          AppHelperFunction.showFlashbar("OTP can't be empty");
          return null;
        } else {
          if (otpController.value.text.isNotEmpty && otpController.value.text.length == 6) {
            AuthApisClass.otpSubmitVerification(otpController.value.text).then((value) {
              if (value) {
                isOtp.value = value;
                isVerify.value = value;
                isSend.value = false;
                Get.offAndToNamed(
                  RoutesName.signProfileScreen,
                  arguments: {
                    'email': emailController.value.text
                  },
                );
                timer.cancel();
              }
            }).onError((error, stackTrace) {});
          } else {
            Get.snackbar("Wrong OTP", " Please try again.");
          }
        }
      }
    });
  }

  /// send otp button
  onSendOtpButton() async {
    //check a internet connection
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        if (emailController.value.text == "") {
          AppHelperFunction.showFlashbar("Email can't be empty");
          return null;
        } else {
          //loading indicator
          otpSendLoading.value = true;

          AuthApisClass.sendEmailOtpVerification(emailController.value.text).then((value) {
            if (AuthApisClass.otpSend) {
              counter.value = 90;
              // isSend is true than ReSend Button Visible
              isSend.value = value;
              //count down timer
              startOtpTimer();
              emailReading.value = true;
              otpSendLoading.value = false;

              FocusScope.of(Get.context!).unfocus();
              Get.snackbar('Send OTP', 'Successfully ', snackPosition: SnackPosition.TOP);
            } else {
              Get.snackbar('Failed', 'wrong Email id ', snackPosition: SnackPosition.TOP);
              otpSendLoading.value = false;

              timer.cancel();
            }
          }).onError((error, stackTrace) {
            print(error);
            print(stackTrace);
          });
        }
      }
    });
  }

  /// Re send otp button
  onReSendOtpButton(BuildContext context) async {
    //check a internet connection

    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        if (emailController.value.text == "") {
          AppHelperFunction.showFlashbar("Email can't be empty");
          return null;
        } else {
          counter.value = 90;
          isSend.value = true;
          startOtpTimer();
          otpReSendLoading.value = true;
          AuthApisClass.sendEmailOtpVerification(emailController.value.text).then((value) {
            otpReSendLoading.value = false;
          }).onError((error, stackTrace) {
            otpReSendLoading.value = false;
            print(error);
            print(stackTrace);
          });
        }
      }
    });
  }

  startOtpTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      otpSendLoading.value = false;
      if (kDebugMode) {
        print(timer.tick);
      }
      counter--;
      if (counter.value == 0) {
        timer.cancel();
      }
    });
  }
}
