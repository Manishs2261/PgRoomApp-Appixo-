import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/repository/apis/apis.dart';
import '../../../../data/repository/auth_apis/auth_apis.dart';
import '../../../../res/route_name/routes_name.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../../../utils/logger/logger.dart';
import '../../../splash/controller/splash_controller.dart';
import '../../sing_in_screen/sing_screen_controller/sing_screen_controller.dart';

class SignProfileScreenControllter extends GetxController {
  RxString image = ''.obs;
  final nameController = TextEditingController().obs;
  final cityNameController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final controller = Get.put(SingScreenController());
  RxBool loading = false.obs;
  RxBool alreadyExistUser = false.obs;
  RxString imageUrl = ''.obs;

  void getImageFromImagePicker(ImageSource imageSource) async {
    final pickFile = await ImagePicker().pickImage(source: imageSource, imageQuality: 70);
    if (pickFile == null) {
      AppHelperFunction.showFlashbar("Image not selected.");
    } else {
      image.value = pickFile.path.toString();
    }

    ApisClass.uploadUserImage(File(image.value)).then((value) {
      imageUrl.value = value;
      print("image url = $value");
    });
  }

  onSubmitButton() {
    //check the internet connection
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        loading.value = true;
        AuthApisClass.singEmailIdAndPassword(controller.emailController.value.text, passwordController.value.text)
            .then((value) async {
          //in this condition
          //if email is already exist not sing

          ApisClass.saveUserData(
                  nameController.value.text, cityNameController.value.text, controller.emailController.value.text,imageUrl)
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
          finalUserUidGlobal = preference.getString('userUid');
          //========================
          alreadyExistUser.value = value;
          loading.value = false;

          if (alreadyExistUser.value) Get.offAllNamed(RoutesName.homeScreen);
        });
      }
    });
  }
}