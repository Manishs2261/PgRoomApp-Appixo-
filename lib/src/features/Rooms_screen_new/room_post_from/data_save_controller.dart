import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pgroom/src/data/repository/apis/apis.dart';
import 'package:pgroom/src/features/Rooms_screen_new/room_post_from/room_post_first_form/controller.dart';
import 'package:pgroom/src/features/Rooms_screen_new/room_post_from/room_post_fourth_form/controller.dart';
import 'package:pgroom/src/features/Rooms_screen_new/room_post_from/room_post_second_form/controller.dart';
import 'package:pgroom/src/features/Rooms_screen_new/room_post_from/room_post_third_form/controller.dart';

class RoomDataSaveController extends GetxController {

  final firstRoomFormController = Get.put(FirstRoomFormController());
  final secondRoomFormController = Get.put(SecondRoomFormController());
  final thirdRoomFormController = Get.put(ThirdRoomFormController());
  final fourthRoomFormController = Get.put(FourthRoomFormController());
  RxBool loading = false.obs;


  onSaveData() {
    ApisClass.addRoomRentList(
        firstRoomFormController.roomOwnerType.value,
        firstRoomFormController.roomNameController.text,
        firstRoomFormController.roomType.value,
        firstRoomFormController.roomCategory.value,
        firstRoomFormController.genderType.value,
        'image',
        secondRoomFormController.houseAddressController.text,
        secondRoomFormController.landmarkController.text,
        secondRoomFormController.cityController.text,
        secondRoomFormController.stateController.text,
        secondRoomFormController.numberOfRoomController.text,
        secondRoomFormController.mealsAvailable.value,
        secondRoomFormController.oneTimeDepositController.text,
        secondRoomFormController.availableFacilities,
        secondRoomFormController.availableCommonAreas,
        secondRoomFormController.availableBills,
        thirdRoomFormController.lastTappedPosition?.longitude,
        thirdRoomFormController.lastTappedPosition?.latitude,
        fourthRoomFormController.newHouseRulesController.text,
        fourthRoomFormController.houseFAQ,
        '123',
        '58966',
        DateTime.now().millisecondsSinceEpoch,
        DateTime.now().millisecondsSinceEpoch,
        false,
        false,
        false
    ).then((value){

      Get.snackbar("Upload", "Successfully");
    }).catchError((e){
      print('error $e');
    });
  }


}