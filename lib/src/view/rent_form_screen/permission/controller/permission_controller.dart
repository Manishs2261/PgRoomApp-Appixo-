import 'package:get/get.dart';

class PermissionController extends GetxController {
  RxBool cookingAllow = false.obs;
  RxBool veg = false.obs;
  RxBool bothVegAndNonVeg = false.obs;
  RxBool girl = false.obs;
  RxBool boy = false.obs;
  RxBool familyMember = false.obs;
  RxBool loading = false.obs;
  var cookingType = "".obs;

  cookingAllowCondition(value) {
    cookingAllow.value = value;

    if (cookingAllow.value == false) {
      veg.value = false;
      bothVegAndNonVeg.value = false;
      cookingType.value = "";
    }
  }

  vegOnlyCondition(value) {
    veg.value = value!;
    bothVegAndNonVeg.value = false;
    cookingType.value = "veg Only";
  }

  vegAndNonVegCondition(value) {
    bothVegAndNonVeg.value = value!;
    veg.value = false;
    cookingType.value = "veg and non-veg both allow";
  }
}
