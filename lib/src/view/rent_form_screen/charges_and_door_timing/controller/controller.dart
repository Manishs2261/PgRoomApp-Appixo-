import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';

import '../../../../repositiry/apis/apis.dart';

class AdditionalChargesController extends GetxController {
  RxBool electricityBill = false.obs;
  RxBool waterBill = false.obs;
  RxBool fexibleTime = false.obs;
  RxBool restrictedTime = false.obs;
  RxBool loading = false.obs;

  final restrictedController = TextEditingController(text: "").obs;

  fexibleTimeCondition(value) {
    fexibleTime.value = value!;
    restrictedTime.value = false;
    restrictedController.value.clear();
  }

  restrictedTimeCondition(value) {
    restrictedTime.value = value!;
    fexibleTime.value = false;
  }


  onSubmitButton(){


    loading.value = false;
    Get.toNamed(RoutesName.perimissionScreen)?.then((value) {
      loading.value = false;
    }).onError((error, stackTrace){

      loading.value = false;
    });
  }
}
