import 'package:get/get.dart';
import 'package:pgroom/src/features/foods_screen_new/foods_form_screen/second_food_form/controller.dart';
import 'package:pgroom/src/features/foods_screen_new/foods_form_screen/third_food_form/controller.dart';

import 'first_food_form/controller.dart';

class FoodDataSaveController extends GetxController {
  final firstFoodFormController = Get.put(FirstFoodFormController());

  final secondFoodFormController = Get.put(SecondFoodFormController());

  final thirdFoodFormController = Get.put(ThirdFoodFormController());

  final fourthFoodFormController = Get.put(FourthFoodFormController());
}

class FourthFoodFormController {}
