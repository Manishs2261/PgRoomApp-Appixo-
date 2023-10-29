import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/view/rent_form_screen/add_image_/controller/controller.dart';

import '../../../../repositiry/apis/apis.dart';
import '../../hostel_and_room_type/controller/controller.dart';
import '../../rent_details/controller/controller.dart';

class PermissionController extends GetxController {

  RxBool cookingAllow = false.obs;
  RxBool veg = false.obs;
  RxBool bothVegAndNonVeg = false.obs;
  RxBool girl = false.obs;
  RxBool boy = false.obs;
  RxBool faimlyMamber = false.obs;
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


  vegOnlyCondition(value){

    veg.value = value!;
    bothVegAndNonVeg.value =
    false;
    cookingType.value =
    "veg Only";
  }

  vegAndNonVegCondition(value){

    bothVegAndNonVeg.value =
    value!;
   veg.value = false;
    cookingType.value =
    "veg and non-veg both allow";
  }

// onSubmitPermissionBotton(){
//
//   loading.value = true;
//
//   ApisClass.newPermission(
//       cookingAllow.value,
//        cookingType.value,
//         girl.value,
//       boy.value,
//       faimlyMamber.value)
//       .then((value) {
//       loading.value = false;
//     Get.snackbar("add", "sussefluy");
//   }).onError((error, stackTrace) {
//      loading.value = false;
//
//     Get.snackbar("error", "error");
//     if (kDebugMode) {
//       print("errror + $error");
//     }
//   });
// }






}