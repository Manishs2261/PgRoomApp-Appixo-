import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

class AddImageController extends GetxController {
  // for bool value false not show a image
  RxBool isBool = false.obs;
  RxBool isSelected = false.obs;
  XFile? image;

  RxBool loading = false.obs;

  // for storing a more image in list
  RxList imageFileList = [].obs;

  // image picker form Gallery
  RxString selectedCoverImage = "".obs;

  //===========================================
  Future pickCoverImageFromGallery() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image == null) return;
    selectedCoverImage.value = image!.path.toString();
  }

  Future uploadCoverImage() async {
    await ApisClass.uploadCoverImage(File(image!.path)).then((value) {
      Get.snackbar("Image uploaded ", "Successfully");
    }).onError((error, stackTrace) {
      Get.snackbar("Image Upload", "Failed");
      AppLoggerHelper.error("image upload error", error);
      AppLoggerHelper.error("image upload error", stackTrace);
    });
  }

  //============================================

  // om submit button
  onSubmitButton() {
    if (selectedCoverImage.isEmpty) {
      AppHelperFunction.showSnackBar("Cover Image can't be empty.");
    } else {
      loading.value = true;
      Get.toNamed(RoutesName.rentDetailsFormScreen)?.then((value) {
        loading.value = false;
      });
    }
  }
}
