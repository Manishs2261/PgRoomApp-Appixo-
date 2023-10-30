import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';

import '../../rent_details/rent_details_screen.dart';

class AddImageController extends GetxController {
  // for bool value false not show a image
  RxBool isBool = false.obs;
  RxBool addimage = false.obs;
  RxBool isSelected = false.obs;
  XFile? image;

  // for storing a more image in list
  RxList imageFileList = [].obs;

  // image picker form Gallary
  RxString selectedCoverImage = "".obs;

  Future pickeImageFromGallery() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image == null) return;
    imageFileList.add(File(image.path));

    await ApisClass.uploadOtherImage(File(image.path)).then((value) {
      Get.snackbar("upload ", "other image");
    }).onError((error, stackTrace) {
      Get.snackbar("error", "error");
      print("errror => $error");
    });
  }

  Future pickeCoverImageFromGallery() async {
     image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image == null) return;
    selectedCoverImage.value = image!.path.toString();

  }

  Future uploadCoverImage()async{

    await ApisClass.uploadCoverImage(File(image!.path)).then((value) {
      Get.snackbar("upload ", "cover  image");
    }).onError((error, stackTrace) {
      Get.snackbar("error", "error");
      print("errror => $error");
    });

  }




  onSubmitButton() {
    if (selectedCoverImage.isEmpty) {
      Get.snackbar("cover image", "not emplty");
    } else {
      Get.toNamed(RoutesName.rentDetailsFormScreen);
    }
  }
}
