import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/tiffine_services_api.dart';
import 'package:pgroom/src/features/foods_screen_new/foods_form_screen/second_food_form/controller.dart';
import 'package:pgroom/src/features/foods_screen_new/foods_form_screen/third_food_form/controller.dart';

import '../../../utils/helpers/helper_function.dart';
import 'first_food_form/controller.dart';
import 'fourth_food_form/controller.dart';

class FoodDataSaveController extends GetxController {
  final firstFoodFormController = Get.put(FirstFoodFormController());

  final secondFoodFormController = Get.put(SecondFoodFormController());

  final thirdFoodFormController = Get.put(ThirdFoodFormController());

  final fourthFoodFormController = Get.put(FourFoodFormController());

  onDataSave() async{
    bool value = await TiffineServicesApis.addFoodData(
      foodShopName: firstFoodFormController.nameController.text,
      latitude:
          thirdFoodFormController.lastTappedPosition!.longitude.toString(),
      longitude:
          thirdFoodFormController.lastTappedPosition!.latitude.toString(),
      address: firstFoodFormController.addressController.text,
      landmark: firstFoodFormController.landmarkController.text,
      city: firstFoodFormController.cityController.text,
      state: firstFoodFormController.stateController.text,
      imageFiles: firstFoodFormController.imageFiles,
      foodFAQ: fourthFoodFormController.foodFAQ,
       breakfastCost: secondFoodFormController.breakfastController.text,
      dal: secondFoodFormController.dalController.text,
      description: firstFoodFormController.descriptionController.text,
      lunchOrDinnerCost: secondFoodFormController.lunchOrDinnerController.text,
      lunchAndDinnerCost:
          secondFoodFormController.dinnerAndLunchCostController.text,
      mealRule: fourthFoodFormController.selectedHouseRules,
       roti: secondFoodFormController.rotiController.text,
      sabji: secondFoodFormController.sabjiController.text,
      thaliCost: secondFoodFormController.thaliController.text,
      typeOfShop: firstFoodFormController.foodShopType.value,
      breakfastAndLunchOrDinnerCost:
          secondFoodFormController.breakfastAndLunchDinnerController.text,
      aCupOfRice: secondFoodFormController.cupOfRiceController.text,
      subscriptionList: secondFoodFormController.subscriptionItem,
      dailyItemList: secondFoodFormController.dailyItem,
      restructureItemList: secondFoodFormController.restructureItem,
      typeFood: secondFoodFormController.foodType.value,
    );

    if (value) {
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      AppHelperFunction.showFlashbar('Saved successfully.');
    } else {
      AppHelperFunction.showFlashbar('Something went wrong.');
    }
  }
}
