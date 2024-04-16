import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';


class AdditionalChargesController extends GetxController {
  RxBool electricityBill = false.obs;
  RxBool waterBill = false.obs;
  RxBool flexibleTime = false.obs;
  RxBool restrictedTime = false.obs;
  RxBool loading = false.obs;

  final restrictedController = TextEditingController(text: "").obs;

  flexibleTimeCondition(value) {
    flexibleTime.value = value!;
    restrictedTime.value = false;
    restrictedController.value.clear();
  }

  restrictedTimeCondition(value) {
    restrictedTime.value = value!;
    flexibleTime.value = false;
  }

  onSubmitButton() {
    loading.value = false;
    Get.toNamed(RoutesName.mapScreen)?.then((value) {
      loading.value = false;
    }).onError((error, stackTrace) {
      loading.value = false;
    });
  }
}
