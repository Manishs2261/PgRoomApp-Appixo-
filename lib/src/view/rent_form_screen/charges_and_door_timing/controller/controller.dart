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

onSubmitButton(){

  loading.value = true;
  ApisClass.newAdditionChargesAndDoorClosing(
      restrictedController.value.text,
      electricityBill.value,
      waterBill.value,
      fexibleTime.value).then((value) {
        loading.value = false;
    Get.snackbar("add","sussefulley");
  Get.toNamed(RoutesName.perimissionScreen);


  }).onError((error, stackTrace) {
   loading.value = false;
    if (kDebugMode) {
      print("Errr :$error");
    }
    Get.snackbar("errro", "error");
  });
}

fexibleTimeCondition(value){

  fexibleTime.value = value!;
  restrictedTime.value = false;
   restrictedController.value.clear();

}

restrictedTimeCondition(value){

  restrictedTime.value = value!;
   fexibleTime.value = false;
}



}