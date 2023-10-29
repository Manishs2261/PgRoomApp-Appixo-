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

class DataSaveController extends GetxController{

  final premissionController = Get.put(PermissionController());
  final hostleController = Get.put(HostelAndRoomController());
  final rentControllet = Get.put(RentDetailsController());
  final addImageController = Get.put(AddImageController());
  final chargeAndDoorController = Get.put(AdditionalChargesController());
  final providerController = Get.put(ProvideFacilitesController());


 saveRentDetails() {

   // premissionController.onSubmitPermissionBotton();
   // hostleController.onSubmitButton();
   // rentControllet.onSubmitButton();
   // chargeAndDoorController.onSubmitButton();
   // providerController.onsubmitButton();

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
       false
    ).then((value)  {


      Get.snackbar("save", "details");
     // Get.offAllNamed(RoutesName.homeScreen);

      //clearValue();

    }).onError((error, stackTrace) {

      Get.snackbar("error", "details");
      print("save Error => $error");
      print("save Error => $stackTrace");
    });

  }


  saveUserRentDetaitls(){
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
    ).then((value)  {
      print("vberof ${ApisClass.userRentId}");
      saveRentDetails();
      print("after ${ApisClass.userRentId}");
      Get.snackbar("save", "details",backgroundColor: Colors.red);
      Get.offAllNamed(RoutesName.homeScreen);
      //clearValue();

    }).onError((error, stackTrace) {

      Get.snackbar("error", "details",backgroundColor: Colors.blue);
      print("save Error => $error");
      print("save Error => $stackTrace");
    });





  }






  // clearValue(){
//   //
//   //   ApisClass.download = "";
//   //   addImageController.selectedCoverImage.value = "";
//   //   rentControllet.houseNameController.value.clear();
//   //   rentControllet.houseAddressController.value.clear();
//   //   rentControllet.cityNameController.value.clear();
//   //   rentControllet.landdMarkController.value.clear();
//   //   rentControllet.contactNumberController.value.clear();
//   //
//   //   hostleController.singlePersonContrller.value.clear();
//   //   hostleController.doublePersonContrller.value.clear();
//   //   hostleController.triplePersonContrller.value.clear();
//   //   hostleController.fourPersonContrller.value.clear();
//   //   hostleController.faimlyPersonContrller.value.clear();
//   //   chargeAndDoorController.restrictedController.value.clear();
//   //   " ";
//   //   providerController.wifi.value = false;
//   //   providerController.bed.value = false;
//   //   providerController.chari.value = false;
//   //   providerController.table.value = false;
//   //   providerController.fan.value = false;
//   //   providerController.gadda.value = false;
//   //   providerController.light.value = false;
//   //   providerController.locker.value = false;
//   //   providerController.bedSheet.value = false;
//   //   providerController.washingMachin.value = false;
//   //   providerController.parking.value = false;
//   //   chargeAndDoorController.electricityBill.value = false;
//   //   chargeAndDoorController.waterBill.value = false;
//   //   chargeAndDoorController.fexibleTime.value = false;
//   //   premissionController.cookingAllow.value = false;
//   //
//   //   premissionController.boy.value = false;
//   //   premissionController.girl.value = false;
//   //   premissionController.faimlyMamber.value = false;
//   //
//   //   hostleController.checkboxSingle1.value  =false;
//   //   hostleController.checkboxDoble2.value = false;
//   //   hostleController.checkboxTriple3.value = false;
//   //   hostleController.checkboxFour4.value = false;
//   //   hostleController.checkboxFaimalyRoom.value = false;
//   //
//   //
//   // }

}