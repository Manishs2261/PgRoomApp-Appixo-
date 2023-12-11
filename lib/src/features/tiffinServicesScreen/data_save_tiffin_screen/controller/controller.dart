import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../../data/repository/apis/apis.dart';

class AddYourTiffineController extends GetxController {
  // for bool value false not show a image
  RxBool isBool = false.obs;
  RxBool isSelected = false.obs;
  XFile? coverImage;
  XFile? menuImage;
  RxBool loading = false.obs;

  final servicesNameController = TextEditingController().obs;
  final priceController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final globalKey = GlobalKey<FormState>();

  // image picker form Gallery
  RxString selectedCoverImage = "".obs;
  RxString selectedMenuImage = "".obs;

  //===========================================
  Future pickCoverImageFromGallery() async {
    coverImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (coverImage == null) return;
    selectedCoverImage.value = coverImage!.path.toString();
  }

  Future uploadCoverImage() async {
    await ApisClass.uploadTiffineServicesImage(File(coverImage!.path)).then((value) {
      Get.snackbar("Image uploaded ", "Successfully");
    }).onError((error, stackTrace) {
      // Get.snackbar("Image Upload", "Failed");
      AppLoggerHelper.error("image upload error", error);
      AppLoggerHelper.error("image upload error", stackTrace);
    });
  }

  Future pickMenuImageFromGallery() async {
    menuImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (menuImage == null) return;
    selectedMenuImage.value = menuImage!.path.toString();
  }

  Future uploadMenuImage() async {
    await ApisClass.uploadMenuImage(File(menuImage!.path)).then((value) {
      Get.snackbar("Image uploaded ", "Successfully");
    }).onError((error, stackTrace) {
      // Get.snackbar("Image Upload", "Failed");
      AppLoggerHelper.error("image upload error", error);
      AppLoggerHelper.error("image upload error", stackTrace);
    });
  }

  //============================================

  Future onUserTiffineServicesData() async {
    ApisClass.addYourTiffineServicesUserAccount(ApisClass.tiffineServicesUrl, servicesNameController.value.text,
            addressController.value.text, priceController.value.text, ApisClass.foodMenuUrl)
        .then((value) {
      print("user data upload");
      onTiffineServicesData();
    }).onError((error, stackTrace) {
      print("user data not upload");
      print(error);
    });
  }

  Future onTiffineServicesData() async {
    ApisClass.addYourTiffineServices(ApisClass.tiffineServicesUrl, servicesNameController.value.text,
            addressController.value.text, priceController.value.text, ApisClass.foodMenuUrl)
        .then((value) {
      print(" data upload");
    }).onError((error, stackTrace) {
      print("data not upload");
      print(error);
    });
  }

  // om submit button
  onSubmitButton() {
    if (globalKey.currentState!.validate()) {
      if (selectedCoverImage.isEmpty) {
        AppHelperFunction.showSnackBar("Cover Image can't be empty.");
      } else {
        loading.value = true;
        uploadCoverImage().then((value) {
          uploadMenuImage().then((value) {
            onUserTiffineServicesData();
          });
        });
      }
    }
  }
}
