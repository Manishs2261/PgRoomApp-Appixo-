import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pgroom/src/data/repository/apis/apis.dart';
import 'package:pgroom/src/features/Rooms_screen_new/room_post_from/room_post_first_form/controller.dart';
import 'package:pgroom/src/features/Rooms_screen_new/room_post_from/room_post_fourth_form/controller.dart';
import 'package:pgroom/src/features/Rooms_screen_new/room_post_from/room_post_second_form/controller.dart';
import 'package:pgroom/src/features/Rooms_screen_new/room_post_from/room_post_third_form/controller.dart';

import '../../../utils/helpers/helper_function.dart';

class RoomDataSaveController extends GetxController {

  final firstRoomFormController = Get.put(FirstRoomFormController());
  final secondRoomFormController = Get.put(SecondRoomFormController());
  final thirdRoomFormController = Get.put(ThirdRoomFormController());
  final fourthRoomFormController = Get.put(FourthRoomFormController());
  RxBool loading = false.obs;


  onSaveData() async{
    bool value = await ApisClass.addRoomData(
        homeName: firstRoomFormController.roomNameController.text,
        latitude: thirdRoomFormController.lastTappedPosition!.latitude.toString(),
        longitude: thirdRoomFormController.lastTappedPosition!.longitude.toString(),
        address: secondRoomFormController.houseAddressController.text,
        landmark: secondRoomFormController.landmarkController.text,
        city: secondRoomFormController.cityController.text,
        state: secondRoomFormController.stateController.text,
        commonAreasList: secondRoomFormController.selectedCommonAreas,
        roomFacilityList: secondRoomFormController.selectedFacilities,
        roomType: firstRoomFormController.roomType.value,
        billsList: secondRoomFormController.selectedBills,
        imageFiles: firstRoomFormController.imageFiles,
        houseFAQ: fourthRoomFormController.houseFAQ,
        roomOwnership: firstRoomFormController.roomOwnerType.value,
        roomCategory: firstRoomFormController.roomCategory.value,
        depositAmount: secondRoomFormController.oneTimeDepositController.text,
        singlePersonCost: firstRoomFormController.singleRoomPriceController.text,
        doublePersonCost: firstRoomFormController.doubleRoomPriceController.text,
        triplePersonCost: firstRoomFormController.tripleRoomPriceController.text,
        triplePlusCost: firstRoomFormController.threePlusRoomPriceController.text,
        familyCost: firstRoomFormController.singleRoomPriceController.text,
        roomsAvailable:  '',
        noticePride: '',
        mealsAvailable: secondRoomFormController.mealsAvailable.value,
        houseRules: fourthRoomFormController.selectedHouseRules,
        genderType:  firstRoomFormController.genderType.value,
        totalRoom: secondRoomFormController.numberOfRoomController.text
    );

    if (value) {
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      AppHelperFunction.showFlashbar('Saved successfully.');
    } else {
      AppHelperFunction.showFlashbar('Something went wrong.');
    }



  }


}