import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';

class EditOtherImageController extends GetxController {
  var itemid;

  EditOtherImageController(this.itemid);

  // for bool value false not show a image
  RxBool isBool = false.obs;
  XFile? otherImage;
  var containerHeight = 0.obs;
  RxBool contianShow = true.obs;

  Connectivity connectivity = Connectivity();

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
    await ApisClass.uploadOtherImage(File(otherImage!.path), itemid)
        .then((value) {
      Get.snackbar("upload ", "other image");
    }).onError((error, stackTrace) {
      Get.snackbar("error other image ", "error");
      print("errror => $error");
    });
  }

  onDeleteButton(BuildContext context, String imageId, String itemId,
      String imageUrl) async {
    await connectivity.checkConnectivity().then((value) {
      if (value == ConnectivityResult.none) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please Check Your Internet Connection '),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ApisClass.deleteotherImage(imageId, itemId, imageUrl);
      }
    });
  }

  onChooseImage(BuildContext context) async {
    await connectivity.checkConnectivity().then((value) {
      if (value == ConnectivityResult.none) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please Check Your Internet Connection '),
            backgroundColor: Colors.red,
          ),
        );
      } else {

        pickeImageFromGallery();
        isBool.value = true;
      }
    });

  }
}
