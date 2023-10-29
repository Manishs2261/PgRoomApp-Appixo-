import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';

import '../../../../repositiry/apis/apis.dart';

class RentDetailsController extends GetxController {
  final houseNameController = TextEditingController().obs;
  final houseAddressController = TextEditingController().obs;
  final cityNameController = TextEditingController().obs;
  final landdMarkController = TextEditingController().obs;
  final contactNumberController = TextEditingController().obs;
  RxBool loading = false.obs;

  // onSubmitButton() {
  //   loading.value = true;
  //   ApisClass.newRentDetailsCollection(
  //           houseNameController.value.text,
  //           houseAddressController.value.text,
  //           cityNameController.value.text,
  //           landdMarkController.value.text,
  //           contactNumberController.value.text
  //   )
  //       .then((value) {
  //     loading.value = false;
  //     Get.snackbar("add", "sussfuly");
  //
  //     Get.toNamed(RoutesName.hostelAndRoomTypeScreen);
  //   }).onError((error, stackTrace) {
  //     loading.value = false;
  //     Get.snackbar("error", "error");
  //     if (kDebugMode) {
  //       print("Error ⛔ RentDetailsController =>   $error");
  //     }
  //   });
  // }
}
