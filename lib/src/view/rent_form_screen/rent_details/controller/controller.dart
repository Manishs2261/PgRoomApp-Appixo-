import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pinput/pinput.dart';

import '../../../../repositiry/apis/apis.dart';

class RentDetailsController extends GetxController {
  final houseNameController = TextEditingController().obs;
  final houseAddressController = TextEditingController().obs;
  final cityNameController = TextEditingController().obs;
  final landdMarkController = TextEditingController().obs;
  final contactNumberController = TextEditingController().obs;
  RxBool loading = false.obs;

 onSubmitButton() async {
   if(contactNumberController.value.length
       != 10)
   {
     Get.snackbar("Number", "PLaese Enter 10 digites "
         "of number");
   }
   else {
     loading.value = true;
     Get.toNamed(RoutesName.hostelAndRoomTypeScreen)?.then((value) {

       loading.value = false;
     }).onError((error, stackTrace) {

       loading.value = false;
     });
   }


}


}
