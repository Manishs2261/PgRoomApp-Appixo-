import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../repositiry/apis/apis.dart';
import '../../../../repositiry/auth_apis/auth_apis.dart';
import '../../../../res/route_name/routes_name.dart';
import '../../../splash/controller/splash_controller.dart';

class SingScreenController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final otpController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final cityNameController = TextEditingController().obs;

  Connectivity connectivity = Connectivity();

  RxBool isOtp = false.obs;
  RxBool isSend = false.obs;
  RxBool isVerify = false.obs;
  RxBool alreadyExistUser = false.obs;
  RxBool loading = false.obs;
  RxBool otpLoading = false.obs;

  RxInt counter = 120.obs;
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
              isOtp.value = value;
              isVerify.value = value;
              timer.cancel();
            }).onError((error, stackTrace) {});
          } else {
            Get.snackbar("Wrong OTP", " Please try again.");
          }
        }
      }
    });
  }

  onSubmitButton() {
    //check the internet connection
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        loading.value = true;
        AuthApisClass.singEmailIdAndPassword(emailController.value.text, passwordController.value.text)
            .then((value) async {
          //in this condition
          //if email is already exist not sing

          ApisClass.saveUserData(nameController.value.text, cityNameController.value.text, emailController.value.text)
              .then((value) {
            Get.snackbar("Save", "successfully");
          }).onError((error, stackTrace) {
            AppLoggerHelper.error("Email save Error");
            AppLoggerHelper.error(error.toString());
            AppLoggerHelper.error(stackTrace.toString());
          });

          // Login sharedPreference code +++++++++
          SharedPreferences preference = await SharedPreferences.getInstance();
          // store a data in   SharedPreferences
          preference.setString('userUid', ApisClass.user.uid);
          //initialize  a variable
          finalUserUidGloble = preference.getString('userUid');
          //========================
          alreadyExistUser.value = value;
          loading.value = false;

          if (alreadyExistUser.value) Get.offAllNamed(RoutesName.homeScreen);
        });
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
          otpLoading.value = true;
          AuthApisClass.sendEmailOtpVerification(emailController.value.text).then((value) {
            if (AuthApisClass.otpSend) {
              // isSend is true than ReSend Button Visible
              isSend.value = value;
              //count down timer
              startOtpTimer();
              Get.snackbar('Send OTP', 'Successfully ', snackPosition: SnackPosition.TOP);
            } else {
              Get.snackbar('Failed', 'wrong Email id ', snackPosition: SnackPosition.TOP);
              otpLoading.value = false;
            }
          }).onError((error, stackTrace) {});
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
          otpLoading.value = true;
          counter.value = 120;
          isSend.value = true;
          startOtpTimer();
          AuthApisClass.sendEmailOtpVerification(emailController.value.text)
              .then((value) {})
              .onError((error, stackTrace) {});
        }
      }
    });
  }

  startOtpTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      otpLoading.value = false;
      if (kDebugMode) {
        print(timer.tick);
      }
      counter--;
      if (counter == 0) {
        timer.cancel();
      }
    });
  }
}
