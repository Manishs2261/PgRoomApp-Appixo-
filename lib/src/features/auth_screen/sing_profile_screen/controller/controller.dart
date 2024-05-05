import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/repository/apis/apis.dart';
import '../../../../data/repository/apis/user_apis.dart';
import '../../../../data/repository/auth_apis/auth_apis.dart';
import '../../../../navigation_menu.dart';
import '../../../../res/route_name/routes_name.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../../../utils/logger/logger.dart';
import '../../../splash/controller/splash_controller.dart';
import '../../sing_in_screen/sing_screen_controller/sing_screen_controller.dart';

class SignProfileScreenController extends GetxController{




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

    UserApis.uploadUserImage(File(image.value)).then((value) {
      imageUrl.value = value;
      print("image url = $value");
    });
  }

  onSubmitButton( String email) {
    //AppHelperFunction.showDialogCenter(false);
    print("email ${ email}");
    print("email22 ${passwordController.value.text}");

   // check the internet connection
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        AppHelperFunction.showDialogCenter(false);
        loading.value = true;
        AuthApisClass.singEmailIdAndPassword(email, passwordController.value.text)
            .then((value) async {
          //in this condition
          //if email is already exist not sing


          // Login sharedPreference code +++++++++
          SharedPreferences preference = await SharedPreferences.getInstance();
          // store a data in   SharedPreferences
          preference.setString('userUid', ApisClass.user.uid);
          //initialize  a variable
          finalUserUidGlobal = preference.getString('userUid');
          //========================
          alreadyExistUser.value = value;
          loading.value = false;

          if (alreadyExistUser.value) {
            //Get.offAllNamed(RoutesName.homeScreen);
            Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                NavigationMenuScreen()), (Route<dynamic> route) => false);

            UserApis.saveUserData(
                nameController.value.text, cityNameController.value.text,  email,
                imageUrl.value)
                .then((value) {
              Get.snackbar("Save", "successfully");
            }).onError((error, stackTrace) {
              AppLoggerHelper.error("Email save Error");
              AppLoggerHelper.error(error.toString());
              AppLoggerHelper.error(stackTrace.toString());
            });
            print("home");
          }else{
            Get.offAllNamed(RoutesName.loginScreen);

          }



        });
      }
    });
  }
}
