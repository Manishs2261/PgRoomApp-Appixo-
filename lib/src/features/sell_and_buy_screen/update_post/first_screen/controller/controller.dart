import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/data/repository/apis/old_goods_api.dart';
import 'package:pgroom/src/features/sell_and_buy_screen/model/buy_and_sell_model.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

import '../../../../Home_fitter_new/view_your_post/view_screen/sell_and_buy_update/controller/controller.dart';

class SellAndBuyUpdateController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final listOfSellAndBuyController = Get.put(SellAndBuyUpdateListController());

  final BuyAndSellModel sellAndBuyData = Get.arguments;

  late final TextEditingController nameController;

  late final TextEditingController descriptionController;
  late final TextEditingController addressController;
  late final TextEditingController landmarkController;
  late final TextEditingController cityController;
  late final TextEditingController stateController;
  late final TextEditingController priceController;

  final RxList<File> imageFiles = <File>[].obs; // Store File objects

  final ImagePicker picker = ImagePicker();

  @override
  onInit() {
    descriptionController =
        TextEditingController(text: sellAndBuyData.description);
    addressController = TextEditingController(text: sellAndBuyData.address);
    landmarkController = TextEditingController(text: sellAndBuyData.landmark);
    cityController = TextEditingController(text: sellAndBuyData.city);
    stateController = TextEditingController(text: sellAndBuyData.state);
    priceController = TextEditingController(text: sellAndBuyData.price);
    nameController = TextEditingController(text: sellAndBuyData.itemName);

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
    bool value = await SellAndBuyApis.updateSellAndBuyData(
        documentId:  sellAndBuyData.sabId.toString(),
        itemName:nameController.text ,
        price:priceController.text ,
        description: descriptionController.text,
        imageFiles: imageFiles,
        imageUrlsList:  sellAndBuyData.image!,
        address: addressController.text,
        landmark: landmarkController.text,
        city: cityController.text,
        state: stateController.text,
    );

    if (value) {
      Navigator.pop(Get.context!);
      listOfSellAndBuyController.sellAndBuyModel.clear();
      listOfSellAndBuyController.lastDocument = null;
      listOfSellAndBuyController.hasMoreData.value = true;
      await listOfSellAndBuyController.fetchData();
      AppHelperFunction.showFlashbar('Updated successfully.');
    } else {
      AppHelperFunction.showFlashbar('Something went wrong.');
    }
  }

  onSaveAndNext() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    onDataSave();
  }
}
