import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../repositiry/apis/apis.dart';

class RentDetailsController extends GetxController{

  final houseNameController = TextEditingController().obs;
  final houseAddressController = TextEditingController().obs;
  final cityNameController = TextEditingController().obs;
  final landdMarkController = TextEditingController().obs;
  final contactNumberController = TextEditingController().obs;
  RxBool loading = false.obs;


  onSubmitButton(){
    loading.value = true;
    ApisClass.newRentDetailsCollection(
        houseNameController.value.text,
        houseAddressController.value.text,
        cityNameController.value.text,
        landdMarkController.value.text,
        contactNumberController.value.text).then((value) {
          loading.value = false;
          Get.snackbar("add", "sussfulyy");
    }).onError((error, stackTrace) {
          loading.value = false;
      Get.snackbar("errror", "errrr");
      if (kDebugMode) {
        print("Error + : $error");
      }
    });
  }


}