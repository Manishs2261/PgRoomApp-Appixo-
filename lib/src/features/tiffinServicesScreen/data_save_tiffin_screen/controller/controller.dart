import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/data/repository/apis/tiffine_services_api.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';


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
  final numberController = TextEditingController().obs;
  final globalKey = GlobalKey<FormState>();

  // image picker form Gallery
  RxString selectedCoverImage = "".obs;
  RxString selectedMenuImage = "".obs;


  RxString latitude = ''.obs;
  RxString longitude = ''.obs;


  //===========================================
  Future pickCoverImageFromGallery() async {
    coverImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (coverImage == null) return;
    selectedCoverImage.value = coverImage!.path.toString();
  }

  Future uploadCoverImage() async {
    await TiffineServicesApis.uploadTiffineServicesCoverImage(File(coverImage!.path))
        .then((value) {})
        .onError((error, stackTrace) {
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
    await TiffineServicesApis.uploadMenuImage(File(menuImage!.path)).then((value) {}).onError((error, stackTrace) {
      AppLoggerHelper.error("image upload error", error);
      AppLoggerHelper.error("image upload error", stackTrace);
    });
  }

  //============================================

  Future onUserTiffineServicesData() async {
    TiffineServicesApis.addYourTiffineServicesUserAccount(
            TiffineServicesApis.tiffineServicesCoverImageUrl,
            servicesNameController.value.text,
            addressController.value.text,
            priceController.value.text,
            TiffineServicesApis.foodMenuImageUrl,
            numberController.value.text,
              latitude.value,
                  longitude.value
    )
        .then((value) {
      onTiffineServicesData();
    }).onError((error, stackTrace) {
      print("user data not upload");
      print(error);
    });
  }

  Future onTiffineServicesData() async {
    TiffineServicesApis.addYourTiffineServices(
            TiffineServicesApis.tiffineServicesCoverImageUrl,
            servicesNameController.value.text,
            addressController.value.text,
            priceController.value.text,
            TiffineServicesApis.foodMenuImageUrl,
            numberController.value.text,
        latitude.value,
        longitude.value
    )
        .then((value) {
      Get.snackbar("Save", "Successfully");
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
    }).onError((error, stackTrace) {
      Get.snackbar("Save", "Failed");
      Navigator.pop(Get.context!);
      print(error);
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
              uploadMenuImage().then((value) {
                onUserTiffineServicesData();
              });
            });
          }
        }
      }
    });
  }
}
