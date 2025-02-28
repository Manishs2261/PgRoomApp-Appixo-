import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repository/auth_apis/auth_apis.dart';
import '../../../../utils/helpers/helper_function.dart';


class ForgetPasswordController extends GetxController {
  final globalKey = GlobalKey<FormState>().obs;

  final emailControllerLogin = TextEditingController().obs;

  sendEmailForgetPassword() {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        if (globalKey.value.currentState!.validate()) {
          AppHelperFunction.showCenterCircularIndicator(false);
          AuthApisClass.forgetPassword(emailControllerLogin.value.text);
        }
      }
    });
  }
}
