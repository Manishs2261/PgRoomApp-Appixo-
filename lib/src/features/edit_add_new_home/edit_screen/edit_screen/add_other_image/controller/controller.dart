import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
 import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../../../../data/repository/apis/apis.dart';

class EditOtherImageController extends GetxController {
  var itemid;

  EditOtherImageController(this.itemid);

  // for bool value false not show a image
  RxBool isBool = false.obs;
  XFile? otherImage;

  //dynamic container height
  var containerHeight = 0.obs;

  //for display  list view
  RxBool containerShow = true.obs;
  RxBool loading = false.obs;

  // for storing a more image in list
  RxList imageFileList = [].obs;

  Future pickImageFromGallery() async {
    otherImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (otherImage == null) return;
    imageFileList.add(File(otherImage!.path));

    uploadOtherImage();
  }

  Future uploadOtherImage() async {
    await ApisClass.uploadOtherImage(File(otherImage!.path), itemid).then((value) {
      Get.snackbar("Image Upload ", "Successfully");
      loading.value = false;
    }).onError((error, stackTrace) {
      Get.snackbar("Image Upload", "Failed");
      AppLoggerHelper.error("Other image Upload Error", error);
      AppLoggerHelper.error("Other image Upload Error", stackTrace);
    });
  }

  onDeleteButton(String imageId, String itemId, String imageUrl) async {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        ApisClass.deleteOtherImage(imageId, itemId, imageUrl).then((value) {
          AppHelperFunction.showSnackBar("Image Deleted");
        });
      }
    });
  }

  onChooseUploadOtherImage() async {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        loading.value = true;
        pickImageFromGallery();
        isBool.value = true;
      }
    });
  }
}
