import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';

class EditOtherImageController extends GetxController {

  var itemid ;
  EditOtherImageController(this.itemid);

  // for bool value false not show a image
  RxBool isBool = false.obs;
  XFile? otherImage;
  var containerHeight = 0.obs;
  RxBool contianShow = true.obs;



  // for storing a more image in list
  RxList imageFileList = [].obs;

  Future pickeImageFromGallery() async {
    otherImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (otherImage == null) return;
    imageFileList.add(File(otherImage!.path));

    uploadOtherImage();
  }

  Future uploadOtherImage() async {
    await ApisClass.uploadOtherImage(File(otherImage!.path) , itemid).then((value) {
        Get.snackbar("upload ", "other image");
      }).onError((error, stackTrace) {
        Get.snackbar("error other image ", "error");
        print("errror => $error");
      });

  }



}
