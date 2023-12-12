import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../../data/repository/apis/apis.dart';
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
  final globalKey = GlobalKey<FormState>();

  // image picker form Gallery
  RxString selectedCoverImage = "".obs;
  RxString selectedMenuImage = "".obs;
  RxBool isSelectedCoverImage = false.obs;
  RxBool isSelectedMenuImage = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    servicesNameController = TextEditingController(text: data.servicesName).obs;
    priceController = TextEditingController(text: data.foodPrice).obs;
    addressController = TextEditingController(text: data.address).obs;

    selectedCoverImage = "${data.foodImage}".obs;
    selectedMenuImage = "${data.menuImage}".obs;
    isSelectedCoverImage = (data.foodImage != "").obs;
    isSelectedMenuImage = (data.menuImage != '').obs;

    super.onInit();
  }

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

  Future onUserEditTiffineServicesData() async {
    ApisClass.updateTiffineServicesData(
            servicesNameController.value.text, addressController.value.text, priceController.value.text, itemId)
        .then((value) {
      print("user data Edit");
      AppHelperFunction.showSnackBar("upadte");
    }).onError((error, stackTrace) {
      AppHelperFunction.showSnackBar("not upadte");
      print(error);
      print(stackTrace);
    });
  }

  // om submit button
  onSubmitButton() {
    if (globalKey.currentState!.validate()) {
      if (selectedCoverImage.isEmpty) {
        AppHelperFunction.showSnackBar("Cover Image can't be empty.");
      } else {
        loading.value = true;


        ApisClass.updateTiffineCoverImage(File(coverImage!.path),itemId).then((value) {
          AppHelperFunction.showFlashbar("update");

        }).onError((error, stackTrace) {

          AppHelperFunction.showFlashbar(" not update");
        });


      }
    }
  }
}
