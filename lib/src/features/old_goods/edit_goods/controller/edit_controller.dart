import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
 import 'package:pgroom/src/utils/helpers/helper_function.dart';
import '../../../../data/repository/apis/old_goods_api.dart';
import '../../../../model/old_goods_model/old_goods_model.dart';

class EditGoodsScreenController extends GetxController {
  var itemId;

  OldGoodsModel data = OldGoodsModel();

  EditGoodsScreenController(this.itemId, this.data);

  // for bool value false not show a image
  RxBool isBool = false.obs;
  RxBool isSelected = false.obs;
  XFile? coverImage;

  RxBool loading = false.obs;

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> priceController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> numberController = TextEditingController().obs;
  final globalKey = GlobalKey<FormState>();

  // image picker form Gallery
  RxString selectedCoverImage = "".obs;

  RxBool isSelectedCoverImage = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    nameController = TextEditingController(text: data.name).obs;
    priceController = TextEditingController(text: data.price).obs;
    addressController = TextEditingController(text: data.address).obs;
    numberController = TextEditingController(text: data.contactNumber).obs;

    selectedCoverImage = "${data.image}".obs;

    isSelectedCoverImage = (data.image != "").obs;

    super.onInit();
  }

  //===========================================
  Future pickCoverImageFromGallery() async {
    coverImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (coverImage == null) return;
    selectedCoverImage.value = coverImage!.path.toString();

    await SellAndBuyApis.updateOldGoodsImage(File(coverImage!.path), itemId,data.coverImageId!).then((value) {
      Get.snackbar("Image upload ", "Successfully");
    }).onError((error, stackTrace) {
      Get.snackbar("Image Upload", "Failed");
      if (kDebugMode) {
        print(error);
        print(stackTrace);
      }
    });
  }

  // on submit button
  onSubmitButton() {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        if (globalKey.currentState!.validate()) {
          AppHelperFunction.showDialogCenter(false);
          SellAndBuyApis.updateOldGoodsData(nameController.value.text, addressController.value.text,
                  priceController.value.text, itemId, numberController.value.text)
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
