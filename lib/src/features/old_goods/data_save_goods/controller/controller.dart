import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import '../../../../data/repository/apis/old_goods_api.dart';

class AddYourGoodsController extends GetxController {
  // for bool value false not show a image
  RxBool isBool = false.obs;
  RxBool isSelected = false.obs;
  XFile? coverImage;
  RxBool loading = false.obs;

  final goodsNameController = TextEditingController().obs;
  final priceController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final numberController = TextEditingController().obs;
  final globalKey = GlobalKey<FormState>();

  // image picker form Gallery
  RxString selectedCoverImage = "".obs;
  static final date = DateTime.now();

  //===========================================
  Future pickCoverImageFromGallery() async {
    coverImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (coverImage == null) return;
    selectedCoverImage.value = coverImage!.path.toString();
  }

  Future uploadCoverImage() async {
    await OldGoodsApis.uploadOldGoodsImage(File(coverImage!.path)).then((value) {}).onError((error, stackTrace) {
      AppLoggerHelper.error("image upload error", error);
      AppLoggerHelper.error("image upload error", stackTrace);
    });
  }

  //============================================

  Future onUserTiffineServicesData() async {
    await OldGoodsApis.addYourOldGoodsUserAccount(
      OldGoodsApis.imageUrl,
      goodsNameController.value.text,
      addressController.value.text,
      priceController.value.text,
      AppHelperFunction.getFormattedDate(date),
      numberController.value.text,
    ).then((value) {
      onTiffineServicesData();
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print("user data not upload");
      }
      if (kDebugMode) {
        print(error);
      }
    });
  }

  Future onTiffineServicesData() async {
    OldGoodsApis.addYourOldGoods(
      OldGoodsApis.imageUrl,
      goodsNameController.value.text,
      addressController.value.text,
      priceController.value.text,
      AppHelperFunction.getFormattedDate(date),
      numberController.value.text,
    ).then((value) {
      Get.snackbar("Save", "Successfully");
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
    }).onError((error, stackTrace) {
      Get.snackbar("Save", "Failed");
      Navigator.pop(Get.context!);
      if (kDebugMode) {
        print(error);
      }
    });
  }

  // om submit button
  onSubmitButton() {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        if (globalKey.currentState!.validate()) {
          if (selectedCoverImage.isEmpty) {
            AppHelperFunction.showSnackBar("Cover Image can't be empty.");
          } else {
            AppHelperFunction.showDialogCenter(false);
            uploadCoverImage().then((value) {
              onUserTiffineServicesData();
            });
          }
        }
      }
    });
  }
}
