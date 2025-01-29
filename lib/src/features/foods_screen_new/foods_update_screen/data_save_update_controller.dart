import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/tiffine_services_api.dart';
  import 'package:pgroom/src/features/foods_screen_new/foods_update_screen/second_food_update_screen/controller/controller.dart';
import 'package:pgroom/src/features/foods_screen_new/foods_update_screen/third_food_update_screen/controller/controller.dart';
import 'package:pgroom/src/features/foods_screen_new/model/food_model.dart';

import '../../../utils/helpers/helper_function.dart';
 import 'first_food_update_screen/controlller/controller.dart';
import 'fourth_food_update_screen/controller/controller.dart';

class FoodDataSaveController extends GetxController {
  final firstFoodFormController = Get.put(FirstFoodUpdateController());

  final secondFoodFormController = Get.put(SecondFoodUpdateController());

  final thirdFoodFormController = Get.put(ThirdFoodUpdateController());

  final fourthFoodFormController = Get.put(FourFoodUpdateController());

  final FoodModel foodModel = Get.arguments;

  onDataUpdate() async{
    bool value = await TiffineServicesApis.updateFoodData(

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
      foodCategory: secondFoodFormController.foodType.value,
      documentId: foodModel.fId.toString(),
      imageUrlsList: foodModel.imageList ?? [],
    );

    if (value) {
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      AppHelperFunction.showFlashbar('updated  successfully.');
    } else {
      AppHelperFunction.showFlashbar('Something went wrong.');
    }
  }
}
