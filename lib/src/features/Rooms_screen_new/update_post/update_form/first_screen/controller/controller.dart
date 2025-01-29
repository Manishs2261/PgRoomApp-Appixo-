import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/data/repository/apis/apis.dart';
import 'package:pgroom/src/features/Rooms_screen_new/model/room_model.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

class FirstRoomUpdateFormController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final RoomModel roomModel = Get.arguments;

  // Room ownership type
  late RxString roomOwnerType;

  // Room type
  late RxString roomType;

  // Room category
  late RxString roomCategory;

  // Gender type
  late RxString genderType;

  // Meal availability
  late RxString mealsAvailable;

  late RxString flatType;

  // Conditional fields
  late final TextEditingController singleRoomPriceController;

  late final TextEditingController tripleRoomPriceController;

  late final TextEditingController doubleRoomPriceController;

  late final TextEditingController threePlusRoomPriceController;

  late final TextEditingController bhkCostController;

  late final TextEditingController roomNameController;

  final RxList<File> imageFiles = <File>[].obs; // Store File objects

  final ImagePicker picker = ImagePicker();

  @override
  onInit() {
    roomOwnerType = roomModel.roomOwnershipType
        .toString()
        .obs;
    roomType = roomModel.roomType
        .toString()
        .obs;
    roomCategory = roomModel.roomCategory
        .toString()
        .obs;
    genderType = roomModel.genderType
        .toString()
        .obs;
    mealsAvailable = roomModel.mealsAvailable
        .toString()
        .obs;
    flatType = roomModel.flatType
        .toString()
        .obs;

    roomNameController = TextEditingController(text: roomModel.houseName);
    singleRoomPriceController =
        TextEditingController(text: roomModel.singlePersonCost);
    tripleRoomPriceController =
        TextEditingController(text: roomModel.triplePersonCost);
    doubleRoomPriceController =
        TextEditingController(text: roomModel.doublePersonCost);
    threePlusRoomPriceController =
        TextEditingController(text: roomModel.triplePlusCost);
    bhkCostController = TextEditingController(text: roomModel.familyCost);

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

  onDataSave() async {
  bool value = await  ApisClass.updateRoomDetailsData(
        documentId: roomModel.rId.toString(),
        roomOwnershipType: roomOwnerType.value,
        houseName: roomNameController.text,
        roomCategory: roomCategory.value ,
        genderType: genderType.value ,
        roomType: roomType.value,
        flatType: flatType.value,
        imageFiles: imageFiles,
        imageUrlsList:  roomModel.imageList ?? [],
        bhkCost: bhkCostController.text,
        singlePersonCost: singleRoomPriceController.text,
        doublePersonCost: doubleRoomPriceController.text,
        triplePersonCost: tripleRoomPriceController.text,
        triplePlusCost: threePlusRoomPriceController.text,
    );
  if (value) {
    Navigator.pop(Get.context!);
    AppHelperFunction.showFlashbar('Updated successfully.');
  } else {
    AppHelperFunction.showFlashbar('Something went wrong.');
  }
  }

  onSaveAndNext() {
    if (!formKey.currentState!.validate()) {
      // Form validation failed
      return;
    }

    onDataSave();
  }
}
