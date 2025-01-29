import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/apis.dart';
import 'package:pgroom/src/features/Rooms_screen_new/model/room_model.dart';

import '../../../../../../utils/helpers/helper_function.dart';


class SecondRoomUpdateFormController extends GetxController {


  final formKey = GlobalKey<FormState>();

  final RoomModel roomData = Get.arguments;

  // Meal availability
  late RxString mealsAvailable;

  // Common facilities & house rules
  late RxList<String> selectedCommonAreas;

  late RxList<String> selectedBills;

  RxList availableBills = [
    "Electricity",
    "Water",
  ].obs;

  RxList availableCommonAreas = [
    "Kitchen",
    "Dining Hall",
    "Study Room",
    "Library",
  ].obs;

  // To store selected common areas
  RxList availableFacilities = [
    'Bed',
    'Chair',
    'Table',
    'Fan',
    'Light',
    'Cooler',
    'Washing Machine',
    'Bed Sheet',
    'Fridge',
    'Water Purifier',
    'TV',
    'Laundry',
    'Housekeeping',
    'Internet/Wifi Connectivity',
    'Gym',
    'Lift',
    'Parking',
    'Power Backup',
    'CCTV',
    'AC',
    'Attached Bathroom',
  ].obs;

  late RxList<String> selectedFacilities;

  // To store selected facilities
  late final TextEditingController houseAddressController;

  late final TextEditingController landmarkController;

  late final TextEditingController cityController;

  late final TextEditingController stateController;

  late final TextEditingController numberOfRoomController;
  late final TextEditingController oneTimeDepositController;

  TextEditingController addNewFacilityController = TextEditingController();
  TextEditingController addCommonAreaController = TextEditingController();
  TextEditingController addBillsController = TextEditingController();


  @override
  void onInit() {
    houseAddressController = TextEditingController(text: roomData.homeAddress);
    landmarkController = TextEditingController(text: roomData.landmark);
    cityController = TextEditingController(text: roomData.city);
    stateController = TextEditingController(text: roomData.state);
    numberOfRoomController = TextEditingController(text: roomData.totalRoom);
    oneTimeDepositController =
        TextEditingController(text: roomData.depositAmount);

    selectedFacilities = <String>[].obs;
    selectedBills = <String>[].obs;
    selectedCommonAreas = <String>[].obs;

    selectedFacilities.addAll(roomData.roomFacilityList ?? []);
    selectedBills.addAll(roomData.billsList ?? []);
    selectedCommonAreas.addAll(roomData.commonAreasList ?? []);
    mealsAvailable = roomData.mealsAvailable
        .toString()
        .obs;
    super.onInit();
  }

  // For adding new facilities
  void addNewFacility(String facility) {
    if (facility.isNotEmpty && !availableFacilities.contains(facility)) {
      availableFacilities.add(facility);
    }
    addNewFacilityController.clear();
  }


  void addNewBills(String facility) {
    if (facility.isNotEmpty && !availableBills.contains(facility)) {
      availableBills.add(facility);
    }
    addBillsController.clear();
  }


  void addNewCommonArea(String facility) {
    if (facility.isNotEmpty && !availableCommonAreas.contains(facility)) {
      availableCommonAreas.add(facility);
    }
    addCommonAreaController.clear();
  }


  onSaveData() async {
   bool value = await ApisClass.updateRoomAddressData(
        documentId: roomData.rId.toString(),
        address: houseAddressController.text ,
        landmark: landmarkController.text,
        city: cityController.text,
        state:  stateController.text,
        totalRoom: numberOfRoomController.text,
        isMealsAvailable:  mealsAvailable.value,
        depositAmount: oneTimeDepositController.text ,
        facilities: selectedFacilities ,
        commonArea: selectedCommonAreas,
        bills: selectedBills
    );

    if (value) {
      Navigator.pop(Get.context!);
      AppHelperFunction.showFlashbar('Updated successfully.');
    } else {
      AppHelperFunction.showFlashbar('Something went wrong.');
    }

  }


  onSaveAndNext() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    onSaveData();
  }


}