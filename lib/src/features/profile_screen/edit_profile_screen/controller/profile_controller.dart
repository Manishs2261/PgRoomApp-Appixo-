import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/repository/apis/user_collection.dart';
import '../../../../utils/helpers/helper_function.dart';

class ProfileController extends GetxController {
  RxString image = ''.obs;

  RxBool loading = false.obs;

  final updateNameController = TextEditingController(text: UserApis.userName).obs;
  final updateCityController = TextEditingController(text: UserApis.userCity).obs;

  @override
  void onInit() {
    UserApis.getUserData();
    super.onInit();
  }

  Future pickImageFromGallery(ImageSource imageSource) async {
    final pickFile = await ImagePicker().pickImage(source: imageSource, imageQuality: 50);
    if (pickFile == null) {
      AppHelperFunction.showFlashbar("Image not selected.");
    } else {
      image.value = pickFile.path.toString();
    }

    AppHelperFunction.showCenterCircularIndicator(false);
    UserApis.updateUserImage(File(image.value)).then((value) {
      Navigator.pop(Get.context!);
      AppHelperFunction.showFlashbar("Image Successfully upload.");
    }).onError((error, stackTrace) {
      Navigator.pop(Get.context!);
      AppHelperFunction.showFlashbar("Image uploading Failed");
    });
  }

  updateProfileData() {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        loading.value = true;
        AppHelperFunction.showCenterCircularIndicator(false);
        UserApis.updateUserData(updateNameController.value.text, updateCityController.value.text).then((value) {
          Navigator.pop(Get.context!);
          Navigator.pop(Get.context!);

          Get.snackbar("Update Profile", "Successfully");
          loading.value = false;
        }).onError((error, stackTrace) {
          loading.value = false;
          Navigator.pop(Get.context!);
          Get.snackbar("Update Profile", "Failed");
        });
      }
    });
  }
}
