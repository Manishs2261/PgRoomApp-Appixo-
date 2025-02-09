import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/features/foods_screen_new/model/food_model.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

import '../../../../../data/repository/apis/food_collection.dart';
import '../../../../../res/route_name/routes_name.dart';

class FirstFoodUpdateController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final FoodModel foodModel = Get.arguments;

  // food type
  late RxString foodShopType;

  late final TextEditingController nameController;

  late final TextEditingController descriptionController;

  late final TextEditingController addressController;

  late final TextEditingController landmarkController;

  late final TextEditingController cityController;

  late final TextEditingController stateController;

  final RxList<File> imageFiles = <File>[].obs; // Store File objects

  final ImagePicker picker = ImagePicker();

  @override
  onInit() {
    nameController = TextEditingController(text: foodModel.shopName);
    descriptionController = TextEditingController(text: foodModel.description);
    addressController = TextEditingController(text: foodModel.address);
    landmarkController = TextEditingController(text: foodModel.landmark);
    cityController = TextEditingController(text: foodModel.city);
    stateController = TextEditingController(text: foodModel.state);
    foodShopType = foodModel.typeOfShop.toString().obs;
    super.onInit();
  }

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
      return;
    }
    Get.toNamed(RoutesName.secondFoodUpdateForm, arguments: foodModel);
  }
}
