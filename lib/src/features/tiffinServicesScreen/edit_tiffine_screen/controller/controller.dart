import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/data/repository/apis/tiffine_services_api.dart';

import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../../model/tiffin_services_model/tiffen_services_model.dart';

class EditTiffineScreenController extends GetxController {
  var itemId;

  TiffineServicesModel data = TiffineServicesModel();

  EditTiffineScreenController(this.itemId, this.data);

  // for bool value false not show a image
  RxBool isBool = false.obs;
  RxBool isSelected = false.obs;
  XFile? coverImage;
  XFile? menuImage;
  RxBool loading = false.obs;

  Rx<TextEditingController> servicesNameController = TextEditingController().obs;
  Rx<TextEditingController> priceController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> numberController = TextEditingController().obs;
  final globalKey = GlobalKey<FormState>();

  // image picker form Gallery
  RxString selectedCoverImage = "".obs;
  RxString selectedMenuImage = "".obs;
  RxBool isSelectedCoverImage = false.obs;
  RxBool isSelectedMenuImage = false.obs;

  RxString latitude = ''.obs;
  RxString longitude = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    servicesNameController = TextEditingController(text: data.servicesName).obs;
    priceController = TextEditingController(text: data.foodPrice).obs;
    addressController = TextEditingController(text: data.address).obs;
    numberController = TextEditingController(text: data.contactNumber).obs;

    selectedCoverImage = "${data.foodImage}".obs;
    selectedMenuImage = "${data.menuImage}".obs;
    isSelectedCoverImage = (data.foodImage != "").obs;
    isSelectedMenuImage = (data.menuImage != '').obs;
    latitude = "${data.latitude}".obs;
    longitude = "${data.longitude}".obs;

    super.onInit();
  }

  //===========================================
  Future pickCoverImageFromGallery() async {
    coverImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (coverImage == null) return;
    selectedCoverImage.value = coverImage!.path.toString();

    await TiffineServicesApis.updateTiffineCoverImage(File(coverImage!.path), itemId, data.coverImageId!).then((value) {
      Get.snackbar("Image upload ", "Successfully");
    }).onError((error, stackTrace) {
      Get.snackbar("Image Upload", "Failed");
      if (kDebugMode) {
        print(error);
        print(stackTrace);
      }
    });
  }

  Future pickMenuImageFromGallery() async {
    menuImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (menuImage == null) return;
    selectedMenuImage.value = menuImage!.path.toString();
    updateMenuImage();
  }

  Future updateMenuImage() async {
    await TiffineServicesApis.updateTiffineMenuImage(File(menuImage!.path), itemId, data.menuImageId!).then((value) {
      Get.snackbar("Image uploaded ", "Successfully");
    }).onError((error, stackTrace) {
      Get.snackbar("Image Upload", "Failed");
      AppLoggerHelper.error("image upload error", error);
      AppLoggerHelper.error("image upload error", stackTrace);
    });
  }

  // on submit button
  onSubmitButton() {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        if (globalKey.currentState!.validate()) {
          AppHelperFunction.showCenterCircularIndicator(false);
          TiffineServicesApis.updateTiffineServicesData(servicesNameController.value.text, addressController.value.text,
                  priceController.value.text, itemId, numberController.value.text, latitude.value, longitude.value)
              .then((value) {
            Get.snackbar("Update", "Successfully");
            Navigator.pop(Get.context!);
            Navigator.pop(Get.context!);
          }).onError((error, stackTrace) {
            Get.snackbar("Update", "Failed");
            Navigator.pop(Get.context!);
            if (kDebugMode) {
              print(error);
              print(stackTrace);
            }
          });
        }
      }
    });
  }
}
