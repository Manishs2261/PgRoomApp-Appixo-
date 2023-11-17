import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';

class EditOtherImageController extends GetxController {
  // for bool value false not show a image
  RxBool isBool = false.obs;
  RxBool addimage = false.obs;
  RxBool isSelected = false.obs;
  XFile? image;
  XFile? otherImage;
  RxBool loading = false.obs;

  // for storing a more image in list
  RxList imageFileList = [].obs;

  // image picker form Gallary
  RxString selectedCoverImage = "".obs;

  Future pickeImageFromGallery() async {
    otherImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (otherImage == null) return;
    imageFileList.add(File(otherImage!.path));
  }

  Future uploadOtherImage() async {
    for (var i in imageFileList) {
      await ApisClass.uploadOtherImage(File(i!.path)).then((value) {
        Get.snackbar("upload ", "other image");
      }).onError((error, stackTrace) {
        Get.snackbar("error other image ", "error");
        print("errror => $error");
      });
    }
  }

  //===========================================
  Future pickeCoverImageFromGallery() async {
    image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image == null) return;
    selectedCoverImage.value = image!.path.toString();
  }

  Future uploadCoverImage() async {
    await ApisClass.uploadCoverImage(File(image!.path)).then((value) {
      Get.snackbar("upload ", "cover  image");
    }).onError((error, stackTrace) {
      Get.snackbar("error", "error");
      print("errror => $error");
    });
  }

  //============================================

  // om submit button
  onSubmitButton() {
    if (selectedCoverImage.isEmpty) {
      Get.snackbar("cover image", "not emplty");
    } else {
      loading.value = true;
      Get.toNamed(RoutesName.rentDetailsFormScreen)?.then((value) {
        loading.value = false;
      }).onError((error, stackTrace) {
        loading.value = false;
      });
    }
  }

  onPrint() {
    print(imageFileList);
  }
}
