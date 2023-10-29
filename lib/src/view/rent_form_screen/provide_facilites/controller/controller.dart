import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../repositiry/apis/apis.dart';
import '../../../../res/route_name/routes_name.dart';

class ProvideFacilitesController extends GetxController{


  RxBool wifi = false.obs;
  RxBool bed = false.obs;
  RxBool chari = false.obs;
  RxBool table = false.obs;
  RxBool fan = false.obs;
  RxBool gadda = false.obs;
  RxBool light = false.obs;
  RxBool locker = false.obs;
  RxBool bedSheet = false.obs;
  RxBool washingMachin = false.obs;
  RxBool parking = false.obs;
  RxBool loading = false.obs;


  // onsubmitButton(){
  //
  //
  //   loading.value = true;
  //   ApisClass.newProvidFacilites(
  //       wifi.value,
  //       bed.value,
  //       chari.value,
  //       table.value,
  //       fan.value,
  //       gadda.value,
  //       light.value,
  //       locker.value,
  //       bedSheet.value,
  //       washingMachin.value,
  //       parking.value
  //   ).then((value) {
  //
  //     loading.value = false;
  //     Get.snackbar("add","sussefully");
  //     Get.toNamed(RoutesName.chargeAndDoorTimingScreen);
  //   }).onError((error, stackTrace) {
  //     loading.value = false;
  //     if (kDebugMode) {
  //       print("error $error");
  //     }
  //     Get.snackbar("error", "error");
  //   });
  //}

}