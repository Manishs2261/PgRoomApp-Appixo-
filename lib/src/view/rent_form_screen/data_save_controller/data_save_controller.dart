import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/model/rent_details_model/rent_details_model.dart';
import 'package:pgroom/src/model/user_rent_model/user_rent_model.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/view/rent_form_screen/charges_and_door_timing/controller/controller.dart';
import 'package:pgroom/src/view/rent_form_screen/provide_facilites/controller/controller.dart';

import '../add_image_/controller/controller.dart';
import '../hostel_and_room_type/controller/controller.dart';
import '../permission/controller/permission_controller.dart';
import '../rent_details/controller/controller.dart';

class DataSaveController extends GetxController {
  final premissionController = Get.put(PermissionController());
  final hostleController = Get.put(HostelAndRoomController());
  final rentControllet = Get.put(RentDetailsController());
  final addImageController = Get.put(AddImageController());
  final chargeAndDoorController = Get.put(AdditionalChargesController());
  final providerController = Get.put(ProvideFacilitesController());

  saveRentDetails() {
    ApisClass.rentDetailsHomeList(
            ApisClass.download,
            rentControllet.houseNameController.value.text,
            rentControllet.houseAddressController.value.text,
            rentControllet.cityNameController.value.text,
            rentControllet.landdMarkController.value.text,
            rentControllet.contactNumberController.value.text,
            hostleController.bhk.value,
            hostleController.roomType.value,
            hostleController.singlePersonContrller.value.text,
            hostleController.doublePersonContrller.value.text,
            hostleController.triplePersonContrller.value.text,
            hostleController.fourPersonContrller.value.text,
            hostleController.faimlyPersonContrller.value.text,
            chargeAndDoorController.restrictedController.value.text,
            "4.2",
            providerController.wifi.value,
            providerController.bed.value,
            providerController.chari.value,
            providerController.table.value,
            providerController.fan.value,
            providerController.gadda.value,
            providerController.light.value,
            providerController.locker.value,
            providerController.bedSheet.value,
            providerController.washingMachin.value,
            providerController.parking.value,
            chargeAndDoorController.electricityBill.value,
            chargeAndDoorController.waterBill.value,
            chargeAndDoorController.fexibleTime.value,
            premissionController.cookingAllow.value,
            premissionController.cookingType.value,
            premissionController.boy.value,
            premissionController.girl.value,
            premissionController.faimlyMamber.value,
            false)
        .then((value) {
      Get.snackbar("save", "details");
    }).onError((error, stackTrace) {
      Get.snackbar("Error", "details");
      print("save Error => $error");
      print("save Error => $stackTrace");
    });
  }

  saveUserRentDetaitls() {
    ApisClass.rentDetailsUser(
            ApisClass.download,
            rentControllet.houseNameController.value.text,
            rentControllet.houseAddressController.value.text,
            rentControllet.cityNameController.value.text,
            rentControllet.landdMarkController.value.text,
            rentControllet.contactNumberController.value.text,
            hostleController.bhk.value,
            hostleController.roomType.value,
            hostleController.singlePersonContrller.value.text,
            hostleController.doublePersonContrller.value.text,
            hostleController.triplePersonContrller.value.text,
            hostleController.fourPersonContrller.value.text,
            hostleController.faimlyPersonContrller.value.text,
            chargeAndDoorController.restrictedController.value.text,
            "4.2",
            providerController.wifi.value,
            providerController.bed.value,
            providerController.chari.value,
            providerController.table.value,
            providerController.fan.value,
            providerController.gadda.value,
            providerController.light.value,
            providerController.locker.value,
            providerController.bedSheet.value,
            providerController.washingMachin.value,
            providerController.parking.value,
            chargeAndDoorController.electricityBill.value,
            chargeAndDoorController.waterBill.value,
            chargeAndDoorController.fexibleTime.value,
            premissionController.cookingAllow.value,
            premissionController.cookingType.value,
            premissionController.boy.value,
            premissionController.girl.value,
            premissionController.faimlyMamber.value,
            false
    )
        .then((value) {
      //seva home list data
      saveRentDetails();

      Get.snackbar("save", "details", backgroundColor: Colors.red);
      Get.offAllNamed(RoutesName.homeScreen);
      //clearValue();
    }).onError((error, stackTrace) {
      Get.snackbar("Error", "details", backgroundColor: Colors.blue);
      print("save Error => $error");
      print("save Error => $stackTrace");
    });
  }

  uploadData(){

    addImageController.uploadCoverImage().then((value) {
      saveUserRentDetaitls();

    }).onError((error, stackTrace) {

      Get.snackbar("Error", "image upload error");
    });
  }

}
