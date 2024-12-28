import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

import '../../../../res/route_name/routes_name.dart';

class FirstRoomFormController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Room ownership type
  RxString roomOwnerType = 'Owner'.obs;

  // Room type
  RxString roomType = 'Private'.obs;

  // Room category
  RxString roomCategory = 'PG'.obs;

  // Gender type
  RxString genderType = 'Boys'.obs;

  // Meal availability
  RxString mealsAvailable = 'Yes'.obs;

  RxString flatType = '1BHK'.obs;

  // Conditional fields
  TextEditingController singleRoomPriceController = TextEditingController();

  TextEditingController tripleRoomPriceController = TextEditingController();

  TextEditingController doubleRoomPriceController = TextEditingController();
  TextEditingController threePlusRoomPriceController = TextEditingController();
  TextEditingController  bhkCostController = TextEditingController();

  // Common facilities & house rules
  RxList selectedFacilities = [].obs;

  RxList selectedCommonAreas = [].obs;

  RxList selectedBills = [].obs;

  // Form fields
  TextEditingController roomNameController = TextEditingController();

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
      imageFiles.value =
          selectedImages.map((xfile) => File(xfile.path)).toList();
    }
  }

  onSaveAndNext() {
    if (!formKey.currentState!.validate()) {
      // Form validation failed
      return;
    }

    if (imageFiles.isEmpty) {
      AppHelperFunction.showSnackBar('Please select images');
      return;
    }

    Get.toNamed(RoutesName.secondRoomFormScreen);
  }
}
