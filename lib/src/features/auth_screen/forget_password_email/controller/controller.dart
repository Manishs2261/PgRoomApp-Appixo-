import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/auth_apis/auth_apis.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

class ForgetPasswordController extends GetxController {
  final globalKey = GlobalKey<FormState>().obs;

  final emailControlerLogin = TextEditingController().obs;

  sendEmailForgetPassword() {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        AppHelperFunction.showDialogCenter(false);
        if (globalKey.value.currentState!.validate()) {
          AuthApisClass.forgetPassword(emailControlerLogin.value.text);
        }
      }
    });
  }
}
