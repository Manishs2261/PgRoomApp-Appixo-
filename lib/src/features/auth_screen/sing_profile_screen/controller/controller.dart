import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/repository/apis/apis.dart';
import '../../../../data/repository/apis/user_apis.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../../../utils/logger/logger.dart';
import '../../../splash/controller/splash_controller.dart';
import '../../sing_in_screen/sing_screen_controller/sing_screen_controller.dart';

class SignProfileScreenController extends GetxController {
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
      AppHelperFunction.showFlashbar("Please select an image to proceed.");
    } else {

      image.value = pickFile.path.toString();
    }
    AppHelperFunction.showDialogCenter(false);
    UserApis.uploadUserImage(File(image.value)).then((value) {
      imageUrl.value = value;
      Navigator.pop(Get.context!);
    });


  }

  onSubmitButton(String email) {
    //AppHelperFunction.showDialogCenter(false);

    // check the internet connection
    AppHelperFunction.checkInternetAvailability().then((value) async {
      if (value) {
        if (imageUrl.value.isNotEmpty) {
          AppHelperFunction.showDialogCenter(false);
          loading.value = true;

          UserApis.saveUserData(nameController.value.text, cityNameController.value.text, email, imageUrl.value)
              .then((value) async {
            // Login sharedPreference code +++++++++
            SharedPreferences preference = await SharedPreferences.getInstance();
            // store a data in   SharedPreferences
            preference.setString('userUid', ApisClass.user.uid);
            //initialize  a variable
            finalUserUidGlobal = preference.getString('userUid');
            //========================

            loading.value = false;
            //
            // //Get.offAllNamed(RoutesName.homeScreen);
            Navigator.of(Get.context!).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const NavigationMenuScreen()), (Route<dynamic> route) => false);

            Get.snackbar("Save", "successfully");
          }).onError((error, stackTrace) {
            loading.value = false;
            AppLoggerHelper.error("Email save Error");
            AppLoggerHelper.error(error.toString());
            AppLoggerHelper.error(stackTrace.toString());
          });
        } else {
          Get.snackbar("Image", "choose an image ");
        }
      }
    });
  }
}
