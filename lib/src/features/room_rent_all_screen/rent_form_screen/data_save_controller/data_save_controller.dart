import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

 import '../../../../data/repository/apis/apis.dart';
import '../add_image_/controller/controller.dart';
import '../charges_and_door_timing/controller/controller.dart';
import '../hostel_and_room_type/controller/controller.dart';
import '../map_screen/controller/controller.dart';
import '../permission/controller/permission_controller.dart';
import '../provide_facilities/controller/controller.dart';
import '../rent_details/controller/controller.dart';

class DataSaveController extends GetxController {
  final permissionController = Get.put(PermissionController());
  final hostelController = Get.put(HostelAndRoomController());
  final rentController = Get.put(RentDetailsController());
  final addImageController = Get.put(AddImageController());
  final chargeAndDoorController = Get.put(AdditionalChargesController());
  final providerController = Get.put(ProvideFacilitiesController());
  final mapViewController = Get.put(MapScreenController());
  RxBool loading = false.obs;

  saveRentDetails() {
    ApisClass.rentDetailsHomeList(
            ApisClass.coverImageDownloadUrl,
            rentController.houseNameController.value.text,
            rentController.houseAddressController.value.text,
            rentController.cityNameController.value.text,
            rentController.landMarkController.value.text,
            rentController.contactNumberController.value.text,
            hostelController.bhk.value,
            hostelController.roomType.value,
            hostelController.singlePersonController.value.text,
            hostelController.doublePersonController.value.text,
            hostelController.triplePersonController.value.text,
            hostelController.fourPersonController.value.text,
            hostelController.familyPersonController.value.text,
            chargeAndDoorController.restrictedController.value.text,
            rentController.numberOfRoomsController.value.text,
            providerController.wifi.value,
            providerController.bed.value,
            providerController.chair.value,
            providerController.table.value,
            providerController.fan.value,
            providerController.gadda.value,
            providerController.light.value,
            providerController.locker.value,
            providerController.bedSheet.value,
            providerController.washingMachine.value,
            providerController.parking.value,
            chargeAndDoorController.electricityBill.value,
            chargeAndDoorController.waterBill.value,
            chargeAndDoorController.flexibleTime.value,
            permissionController.cookingAllow.value,
            permissionController.cookingType.value,
            permissionController.boy.value,
            permissionController.girl.value,
            permissionController.familyMember.value,
            providerController.attachBathRoom.value,
            providerController.shareAbleBathRoom.value,
            false,
      mapViewController.latitude.value,
      mapViewController.longitude.value,

    )
        .then((value) {
      Get.snackbar("Upload", "Successfully");
      loading.value = false;
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
    }).onError((error, stackTrace) {
      loading.value = false;
      Get.snackbar("Upload", "Failed");
      AppLoggerHelper.error("Save Rent Data Error", stackTrace);
      AppLoggerHelper.error("Save Rent Data Error", error);
    });
  }

  saveUserRentDetails() {
    ApisClass.rentDetailsUser(
            ApisClass.coverImageDownloadUrl,
            rentController.houseNameController.value.text,
            rentController.houseAddressController.value.text,
            rentController.cityNameController.value.text,
            rentController.landMarkController.value.text,
            rentController.contactNumberController.value.text,
            hostelController.bhk.value,
            hostelController.roomType.value,
            hostelController.singlePersonController.value.text,
            hostelController.doublePersonController.value.text,
            hostelController.triplePersonController.value.text,
            hostelController.fourPersonController.value.text,
            hostelController.familyPersonController.value.text,
            chargeAndDoorController.restrictedController.value.text,
        rentController.numberOfRoomsController.value.text,
            providerController.wifi.value,
            providerController.bed.value,
            providerController.chair.value,
            providerController.table.value,
            providerController.fan.value,
            providerController.gadda.value,
            providerController.light.value,
            providerController.locker.value,
            providerController.bedSheet.value,
            providerController.washingMachine.value,
            providerController.parking.value,
            chargeAndDoorController.electricityBill.value,
            chargeAndDoorController.waterBill.value,
            chargeAndDoorController.flexibleTime.value,
            permissionController.cookingAllow.value,
            permissionController.cookingType.value,
            permissionController.boy.value,
            permissionController.girl.value,
            permissionController.familyMember.value,
            providerController.attachBathRoom.value,
            providerController.shareAbleBathRoom.value,
            false,
      mapViewController.latitude.value,
      mapViewController.longitude.value,
    )
        .then((value) {
      //save home list data
      saveRentDetails();
    }).onError((error, stackTrace) {
      AppLoggerHelper.error("Save UserRent Data Error", error);
      AppLoggerHelper.error("Save UserRent Data Error", stackTrace);
    });
  }

  uploadData() {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        AppHelperFunction.showCenterCircularIndicator(false);
        loading.value = true;
        addImageController.uploadCoverImage().then((value) {
          loading.value = false;
          saveUserRentDetails();
        }).onError((error, stackTrace) {
          loading.value = false;
          AppLoggerHelper.error("Cover image Error", error);
          AppLoggerHelper.error("Cover image Error", stackTrace);
        });
      }
    });
  }
}
