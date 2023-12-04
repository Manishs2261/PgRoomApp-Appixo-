
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/data/repository/apis/apis.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';

import '../../../utils/helpers/helper_function.dart';

class ProfileController extends GetxController {
  RxString image = ''.obs;

  RxBool loading = false.obs;

  final updateNameController = TextEditingController(text: ApisClass.userName).obs;
  final updateCityController = TextEditingController(text: ApisClass.userCity).obs;


  @override
  void onInit() {
    ApisClass.getUserData();
    super.onInit();
  }

  Future pickImageFromGallery(ImageSource imageSource) async {
    final pickFile = await ImagePicker().pickImage(source: imageSource, imageQuality: 70);
    if (pickFile == null) {
      AppHelperFunction.showFlashbar("Image not selected.");
    } else {
      image.value = pickFile.path.toString();
    }
    ApisClass.updateUserImage(File(image.value)).then((value){
      AppHelperFunction.showFlashbar("Image Successfully upload.");
    }).onError((error, stackTrace) {
      AppHelperFunction.showFlashbar("Image uploading Failed");
    });
  }

  updateProfileData(){

    AppHelperFunction.checkInternetAvailability().then((value) {
      if(value){
        loading.value = true;
        ApisClass.updateUserData(updateNameController.value.text, updateCityController.value.text).then((value) {

          Get.snackbar("Update Profile", "Successfully");
          loading.value = false;
       Navigator.pop(Get.context!);
        }).onError((error, stackTrace) {
          loading.value = false;
          Get.snackbar("Update Profile", "Failed");
        });

      }
    });

  }
}
