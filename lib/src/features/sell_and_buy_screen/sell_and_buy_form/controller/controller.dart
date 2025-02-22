import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/data/repository/apis/sell_and_buy_collection.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

import '../../../../utils/logger/logger.dart';

class SellAndBuyController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();
  final landmarkController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final priceController = TextEditingController();

  final RxList<File> imageFiles = <File>[].obs; // Store File objects

  final ImagePicker picker = ImagePicker();

  Future<void> pickImages() async {
    final List<XFile> selectedImages = await picker.pickMultiImage();

    if (selectedImages.length > 10) {
      // Show a message or alert if more than 10 images are selected
      AppHelperFunction.showSnackBar('You can only select up to 10 images!');
      // Limit the list to 10 images and convert XFile to File
      imageFiles.value = selectedImages
          .sublist(0, 10)
          .map((xfile) => File(xfile.path))
          .toList();
    } else {
      // Convert XFile to File and update the list
      imageFiles.value = selectedImages.map((xfile) => File(xfile.path)).toList();
    }
    }


  onDataSave() async {
    bool value = await SellAndBuyApis.addSellAndBuyData(
      itemName: nameController.text,
      description: descriptionController.text,
      imageFiles: imageFiles,
      address: addressController.text,
      landmark: landmarkController.text,
      city: cityController.text,
      state: stateController.text,
      price: priceController.text,
    );
    if (value) {
      Navigator.pop(Get.context!);
      AppHelperFunction.showFlashbar('Saved successfully.');
    } else {
      AppHelperFunction.showFlashbar('Something went wrong.');
    }
  }
  onSaveAndNext() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (imageFiles.isEmpty) {
      AppHelperFunction.showSnackBar('Please select images');
      return;
    }
    onDataSave();
  }
}
